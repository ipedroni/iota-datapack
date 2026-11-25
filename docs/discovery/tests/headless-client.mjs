import net from 'node:net';import zlib from 'node:zlib';import crypto from 'node:crypto';import fs from 'node:fs';import {EventEmitter} from 'node:events';
const report=JSON.parse(fs.readFileSync(new URL('../../../vendor/generated/reports/packets.json',import.meta.url),'utf8'));
export const vi=n=>{const a=[];n>>>=0;do{let b=n&127;n>>>=7;if(n)b|=128;a.push(b);}while(n);return Buffer.from(a);};
export function readVI(b,i=0){let value=0,shift=0,pos=i;while(pos<b.length){const byte=b[pos++];value|=(byte&127)<<shift;if(!(byte&128))return{value:value>>>0,next:pos};shift+=7;if(shift>35)throw Error('Invalid VarInt');}return null;}
export const str=s=>{const b=Buffer.from(s);return Buffer.concat([vi(b.length),b]);};
const packetId=(state,direction,name)=>{const p=report[state]?.[direction]?.['minecraft:'+name];if(!p)throw Error('Missing native packet '+state+' '+direction+' '+name);return p.protocol_id;};
export class HeadlessClient extends EventEmitter{
 constructor(name='IotaProbe'){super();this.name=name;this.state='login';this.buffer=Buffer.alloc(0);this.compression=false;this.counts={};this.entities=new Map();this.log=[];}
 send(name,data=Buffer.alloc(0)){let p=Buffer.concat([vi(packetId(this.state,'serverbound',name)),data]);if(this.compression)p=Buffer.concat([vi(0),p]);this.socket.write(Buffer.concat([vi(p.length),p]));}
 async connect(){this.socket=net.createConnection({host:'127.0.0.1',port:25585});this.socket.on('data',b=>{try{this.receive(b);}catch(e){this.emit('failure',e);this.socket.destroy();}});this.socket.on('error',e=>this.emit('failure',e));this.socket.on('close',()=>this.emit('closed'));
  await new Promise((resolve,reject)=>{this.socket.once('connect',resolve);this.socket.once('error',reject);});
  const port=Buffer.alloc(2);port.writeUInt16BE(25585);const handshake=Buffer.concat([vi(0),vi(774),str('localhost'),port,vi(2)]);this.socket.write(Buffer.concat([vi(handshake.length),handshake]));
  const uuid=crypto.createHash('md5').update('OfflinePlayer:'+this.name).digest();uuid[6]=(uuid[6]&15)|48;uuid[8]=(uuid[8]&63)|128;this.uuid=uuid;this.send('hello',Buffer.concat([str(this.name),uuid]));
  await new Promise((resolve,reject)=>{const timer=setTimeout(()=>reject(Error('Login timeout; '+JSON.stringify(this.log))),30000);this.once('ready',()=>{clearTimeout(timer);resolve();});this.once('failure',e=>{clearTimeout(timer);reject(e);});});return this;
 }
 receive(b){this.buffer=Buffer.concat([this.buffer,b]);while(this.buffer.length){const frame=readVI(this.buffer);if(!frame||this.buffer.length<frame.next+frame.value)return;let p=this.buffer.subarray(frame.next,frame.next+frame.value);this.buffer=this.buffer.subarray(frame.next+frame.value);if(this.compression){const n=readVI(p);p=n.value?zlib.inflateSync(p.subarray(n.next)):p.subarray(n.next);}const id=readVI(p);if(!id)continue;const body=p.subarray(id.next),type=Object.entries(report[this.state].clientbound).find(([,v])=>v.protocol_id===id.value)?.[0]?.slice(10)??'unknown_'+id.value;this.counts[this.state+':'+type]=(this.counts[this.state+':'+type]??0)+1;this.handle(type,body);this.emit('packet',{type,body,state:this.state});}}
 handle(type,b){
  if(type==='login_compression'){this.compression=true;this.threshold=readVI(b).value;return;}
  if(type==='login_finished'){this.log.push('login_finished');this.send('login_acknowledged');this.state='configuration';return;}
  if(type==='select_known_packs'){this.log.push('known_packs');this.send('select_known_packs',vi(0));return;}
  if(type==='finish_configuration'){this.log.push('configuration_finished');this.send('finish_configuration');this.state='play';return;}
  if(type==='keep_alive'){this.send('keep_alive',b);return;}
  if(type==='ping'){this.send('pong',b);return;}
  if(type==='code_of_conduct'){this.send('accept_code_of_conduct');return;}
  if(type==='cookie_request'){const n=readVI(b),key=b.subarray(n.next,n.next+n.value);this.send('cookie_response',Buffer.concat([vi(key.length),key,Buffer.from([0])]));return;}
  if(type==='start_configuration'){this.send('configuration_acknowledged');this.state='configuration';return;}
  if(type==='login'){this.log.push('play_login');this.send('player_loaded');this.emit('ready');return;}
  if(type==='player_position'){const id=readVI(b);if(b.length>=id.next+60){const off=id.next,flags=b.readUInt32BE(off+56),prior=this.position??{x:0,y:0,z:0,yaw:0,pitch:0};this.position={x:b.readDoubleBE(off)+(flags&1?prior.x:0),y:b.readDoubleBE(off+8)+(flags&2?prior.y:0),z:b.readDoubleBE(off+16)+(flags&4?prior.z:0),yaw:b.readFloatBE(off+48)+(flags&8?prior.yaw:0),pitch:b.readFloatBE(off+52)+(flags&16?prior.pitch:0)};}this.send('accept_teleportation',vi(id.value));if(!this.movementTimer)this.movementTimer=setInterval(()=>{if(this.state!=='play'||!this.position||!this.socket?.writable)return;const p=Buffer.alloc(33),v=this.position;p.writeDoubleBE(v.x,0);p.writeDoubleBE(v.y,8);p.writeDoubleBE(v.z,16);p.writeFloatBE(v.yaw,24);p.writeFloatBE(v.pitch,28);p[32]=1;this.send('move_player_pos_rot',p);this.send('client_tick_end');},50);return;}
  if(type==='chunk_batch_finished'){const f=Buffer.alloc(4);f.writeFloatBE(16);this.send('chunk_batch_received',f);return;}
  if(type==='open_screen'){this.containerId=readVI(b).value;return;}
  if(type==='container_set_content'||type==='container_set_slot'){const id=readVI(b),state=readVI(b,id.next);this.containerStates??=new Map();this.containerStates.set(id.value,state.value);return;}
  if(type==='container_close'){this.containerId=null;return;}
  if(type==='add_entity'){const id=readVI(b);this.entities.set(b.subarray(id.next,id.next+16).toString('hex'),id.value);return;}
  if(type==='disconnect'||type==='login_disconnect'){this.log.push('disconnect '+b.toString('utf8').slice(0,500));this.emit('failure',Error(this.log.at(-1)));}
 }
 useBlock(x,y,z,hand=0){const pos=Buffer.alloc(8);pos.writeBigInt64BE(BigInt.asIntN(64,(BigInt(x)&0x3ffffffn)<<38n|(BigInt(z)&0x3ffffffn)<<12n|(BigInt(y)&0xfffn)));const f=Buffer.alloc(12);f.writeFloatBE(.5,0);f.writeFloatBE(1,4);f.writeFloatBE(.5,8);this.send('use_item_on',Buffer.concat([vi(hand),pos,vi(1),f,Buffer.from([0,0]),vi(this.sequence=(this.sequence??0)+1)]));}
 selectSlot(slot){const b=Buffer.alloc(2);b.writeInt16BE(slot);this.send('set_carried_item',b);}
 useItem(hand=0){this.send('use_item',Buffer.concat([vi(hand),vi(this.sequence=(this.sequence??0)+1),Buffer.alloc(8)]));}
 releaseItem(){this.send('player_action',Buffer.concat([vi(5),Buffer.alloc(8),Buffer.from([0]),vi(this.sequence=(this.sequence??0)+1)]));}
 interact(entityId,hand=0){this.send('interact',Buffer.concat([vi(entityId),vi(0),vi(hand),Buffer.from([0])]));}
 quickMove(slot){const short=Buffer.alloc(2);short.writeInt16BE(slot);this.send('container_click',Buffer.concat([vi(this.containerId),vi(this.containerStates?.get(this.containerId)??0),short,Buffer.from([0]),vi(1),vi(0),Buffer.from([0])]));}
 closeContainer(){if(this.containerId!==null&&this.containerId!==undefined)this.send('container_close',vi(this.containerId));this.containerId=null;}
 close(){clearInterval(this.movementTimer);this.socket?.end();}
}
if(process.argv[1]?.endsWith('headless-client.mjs')){const client=new HeadlessClient();try{await client.connect();console.log(JSON.stringify({connected:true,name:client.name,protocol:774,log:client.log}));await new Promise(r=>setTimeout(r,2000));console.log(JSON.stringify(client.counts));}finally{client.close();}}
