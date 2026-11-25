import assert from 'node:assert/strict';
import { Rcon } from './iron-farm/rcon.mjs';

const rcon = new Rcon();
await rcon.connect();
const run = command => rcon.send(command);
const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
const fixture = 'iota_native_production_fixture';
const previous = '@e[tag=iota_preserve_original,limit=1]';
const getOldOffers = () => run('data get entity ' + previous + ' Offers.Recipes');
const present = [];
try {
  const packs = await run('datapack list enabled');
  assert.match(packs, /iota-trades-identity|iota_trading_test_mc1\.21\.11/);
  if (!packs.includes('iota_trading_test_mc1.21.11')) await run('scoreboard players set #new_only it_identity_tmp 1');
  assert.match(await run('scoreboard players get #new_only it_identity_tmp'), /has 1 /);
  await run('forceload add 0 0');
  await run('kill @e[tag=' + fixture + ']');
  await run('setblock 2 301 2 smithing_table');
  const old = await run('summon villager 1.5 301 1.5 {Tags:["' + fixture
    + '","iota_preserve_original"],NoAI:1b,Invulnerable:1b,VillagerData:{profession:"minecraft:toolsmith",type:"minecraft:plains",level:2},'
    + 'Xp:14,CustomName:{text:"Keep This Villager"},Offers:{Recipes:[{buy:{id:"minecraft:emerald",count:7},'
    + 'sell:{id:"minecraft:iron_axe",count:1},uses:2,maxUses:4}]}}');
  assert.match(old, /Summoned/);
  await wait(350);
  const originalOffers = await getOldOffers();
  assert.match(originalOffers, /minecraft:iron_axe/);
  for (let index = 0; index < 8; index++) {
    const result = await run('summon villager ' + (index + 2) + '.5 301 2.5 {Tags:["' + fixture
      + '","iota_trades_production_test","iota_production_' + index
      + '"],NoAI:1b,Invulnerable:1b,VillagerData:{profession:"minecraft:toolsmith",type:"minecraft:plains",level:1},Xp:0,'
      + 'Brain:{memories:{"minecraft:job_site":{value:{dimension:"minecraft:overworld",pos:[I;2,301,2]}}}}}');
    assert.match(result, /Summoned/);
  }
  await wait(4600);
  const diversity = new Set();
  for (let index = 0; index < 8; index++) {
    const actor = '@e[tag=iota_production_' + index + ',limit=1]';
    const id = (await run('data get entity ' + actor + ' Tags')).match(/iota_trades_id\.(\d+)/)?.[1];
    assert(id);
    const base = 'iota_trades:residents r' + id;
    const read = field => run('data get storage ' + base + '.' + field);
    assert.match(await read('region'), /production/);
    assert.match(await read('active_slots'), /\[1, 2, 3, 4\]/);
    assert.match(await read('order'), /\[1, 2, 5, 7, 9, 11, 3, 4, 6, 8, 10, 12\]/);
    const first = (await read('rolled.o1.item')).match(/:(\w+)"$/)?.[1];
    const second = (await read('rolled.o2.item')).match(/:(\w+)"$/)?.[1];
    assert(first && second && first.split('_').at(-1) !== second.split('_').at(-1));
    assert.match(await read('rolled.o3.item'), /minecraft:flint/);
    assert.match(await read('rolled.o7.native'), /minecraft:enchantments/);
    assert.match(await read('rolled.o11.native'), /netherite_scrap|diamond|netherite/);
    assert.match(await run('data get storage iota_trades:templates toolsmith_production.p' + id), /found no elements|No elements/i);
    diversity.add(await read('rolled'));
    const snapshot = 'iota_trades:test_production s' + index;
    await run('data modify storage ' + snapshot + ' set from storage ' + base + '.rolled');
    present.push({ snapshot, base });
  }
  assert(diversity.size > 1);
  await run('reload');
  await wait(1800);
  assert.equal(await getOldOffers(), originalOffers);
  assert.match(await run('data get entity ' + previous + ' Xp'), /14$/);
  assert.match(await run('data get entity ' + previous + ' CustomName'), /Keep This Villager/);
  assert(!(await run('data get entity ' + previous + ' Tags')).includes('iota_trades_id.'));
  for (const { snapshot, base } of present) {
    await run('execute store success score #prod_changed it_identity_tmp run data modify storage ' + snapshot
      + ' set from storage ' + base + '.rolled');
    assert.match(await run('scoreboard players get #prod_changed it_identity_tmp'), /has 0 /);
  }
  console.log(JSON.stringify({ newResidents: present.length, distinctPlans: diversity.size, oldResidentUnmodified: true, reloadStable: true }));
} finally {
  await run('kill @e[tag=' + fixture + ']');
  rcon.close();
}
