import assert from 'node:assert/strict';
import { HeadlessClient, vi } from './headless-client.mjs';
import { Rcon } from './iron-farm/rcon.mjs';

const rcon = new Rcon();
await rcon.connect();
const command = value => rcon.send(value);
const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
const finalNumber = text => Number(text.match(/(-?\d+)[bsldf]?$/i)?.[1]);
const testTag = 'iota_high_resident_test';
const fixtures = [
  { client: new HeadlessClient(), player: 'IotaProbe', x: 1, z: 0 },
  { client: new HeadlessClient('IotaOther'), player: 'IotaOther', x: 9, z: 0 },
];

try {
  assert.match(await command('datapack list enabled'), /iota-trades-identity/);
  await command('kill @e[tag=' + testTag + ']');
  await command('execute unless score #next it_identity matches 99.. run scoreboard players set #next it_identity 99');
  await command('forceload add 0 0');
  await command('fill -2 300 -2 24 300 3 stone');
  await command('setblock 2 301 2 smithing_table');
  await command('setblock 10 301 2 smithing_table');
  for (const [index, record] of fixtures.entries()) {
    await record.client.connect();
    await command('gamemode survival ' + record.player);
    await command('effect clear ' + record.player);
    await command('clear ' + record.player);
    await command('tp ' + record.player + ' 22.5 301 0.5');
    const parts = [7133, 22, Math.floor(Math.random() * 0x3fffffff), 5 + index];
    record.uuid = Buffer.alloc(16);
    parts.forEach((part, offset) => record.uuid.writeInt32BE(part, offset * 4));
    const tag = testTag + '_' + index;
    record.selector = '@e[tag=' + tag + ',limit=1]';
    const spawn = await command('summon villager ' + record.x + '.5 301 0.5 {UUID:[I;' + parts.join(',')
      + '],Tags:["' + testTag + '","' + tag + '","iota_trades_current_probe"],NoAI:1b,Invulnerable:1b'
      + ',VillagerData:{profession:"minecraft:toolsmith",type:"minecraft:plains",level:1},Xp:0'
      + ',Brain:{memories:{"minecraft:job_site":{value:{dimension:"minecraft:overworld",pos:[I;'
      + (record.x + 1) + ',301,2]}}}}}');
    assert.match(spawn, /Summoned/);
  }
  // Both villagers need a publication interval without an adjacent player.
  for (const record of fixtures) await command('tp ' + record.player + ' 25.5 301 0.5');
  await wait(3650);
  for (const record of fixtures) {
    const data = await command('data get entity ' + record.selector + ' Tags');
    record.id = Number(data.match(/iota_trades_id\.(\d+)/)?.[1]);
    assert(record.id >= 100, data);
    record.path = 'iota_trades:residents r' + record.id;
    assert.match(await command('data get storage ' + record.path + '.active_slots'), /\[1, 2, 3, 4\]/);
    await command('give ' + record.player + ' minecraft:flint 48');
  }
  for (const record of fixtures) await command('tp ' + record.player + ' ' + (record.x - 1) + '.5 301 0.5');
  await wait(350);
  for (const record of fixtures) {
    const target = record.client.entities.get(record.uuid.toString('hex'));
    assert(target !== undefined);
    record.client.interact(target);
  }
  await wait(250);
  assert(fixtures.every(({ client }) => client.containerId));
  for (const { client } of fixtures) client.send('select_trade', vi(2));
  await wait(160);
  for (const { client } of fixtures) client.quickMove(2);
  await wait(350);
  for (const { client, player, path } of fixtures) {
    assert.equal(finalNumber(await command('data get storage ' + path + '.rolled.o3.native.uses')), 1);
    assert.equal(finalNumber(await command('data get storage ' + path + '.commercial_xp')), 1);
    assert.match(await command('data get entity ' + player + ' Inventory'), /id: "minecraft:emerald"/);
    client.closeContainer();
  }
  const [first, second] = fixtures;
  await command('data modify entity ' + first.selector + ' Offers.Recipes[2].uses set value 0');
  await wait(200);
  assert.equal(finalNumber(await command('data get entity ' + first.selector + ' Offers.Recipes[2].uses')), 1);
  assert.equal(finalNumber(await command('data get storage ' + first.path + '.commercial_xp')), 1);
  for (const { player } of fixtures) await command('tp ' + player + ' 25.5 301 0.5');
  await wait(3300);
  await command('data modify storage ' + first.path + '.clock.ordinary set value 71999');
  await wait(260);
  assert.equal(finalNumber(await command('data get storage ' + first.path + '.rolled.o3.native.uses')), 0);
  assert.equal(finalNumber(await command('data get storage ' + second.path + '.rolled.o3.native.uses')), 1);
  console.log(JSON.stringify({ residents: fixtures.map(record => record.id), concurrentTrades: true,
    commercialXpPerResident: 1, prematureStockResetCorrected: true, timedRefillIsolated: true }));
} finally {
  for (const { client } of fixtures) client.close();
  await command('kill @e[tag=' + testTag + ']');
  rcon.close();
}
