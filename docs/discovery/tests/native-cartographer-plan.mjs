import assert from 'node:assert/strict';
import { Rcon } from './iron-farm/rcon.mjs';

const connection = new Rcon();
await connection.connect();
const run = command => connection.send(command);
const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
const overworld = 'minecraft:overworld';
const emptyDimension = 'minecraft:the_end';
const tag = 'iota_cartographer_test';
const production = process.argv.includes('--production');
const actor = '@e[type=minecraft:villager,tag=' + tag + ',distance=..8,limit=1]';
const location = (dimension, y) => 'execute in ' + dimension + ' positioned 0 ' + y + ' 0';

async function fixture(dimension, y) {
  const at = location(dimension, y) + ' run ';
  const tags = JSON.stringify([tag, production ? 'iota_trades_production_test' : 'iota_trades_current_probe']);
  await run(at + 'forceload add 0 0');
  await run(at + 'setblock 2 ' + y + ' 2 cartography_table');
  const job = '{dimension:"' + dimension + '",pos:[I;2,' + y + ',2]}';
  const spawn = await run(at + 'summon villager 0 ' + y + ' 0 {Tags:' + tags
    + ',NoAI:1b,NoGravity:1b,Invulnerable:1b,VillagerData:{profession:"minecraft:cartographer",type:"minecraft:plains",level:1},Xp:250'
    + ',Brain:{memories:{"minecraft:job_site":{value:' + job + '}}}}');
  assert.match(spawn, /Summoned/);
  await wait(600);
  const identity = (await run(at + 'data get entity ' + actor + ' Tags')).match(/iota_trades_id\.(\d+)/)?.[1];
  assert(identity, spawn);
  const base = 'iota_trades:residents r' + identity;
  for (let attempt = 0; attempt < 30; attempt++) {
    if ((await run('data get storage ' + base + '.published')).endsWith('1b')) break;
    await wait(500);
  }
  assert.match(await run('data get storage ' + base + '.published'), /1b$/);
  assert.match(await run('data get storage ' + base + '.map_work'), /found no elements|No elements/i);
  const offers = await run(at + 'data get entity ' + actor + ' Offers.Recipes');
  return { base, offers, at };
}

try {
  const packs = await run('datapack list enabled');
  assert.match(packs, /iota-trades-identity|iota_trading_test_mc1\.21\.11/, 'Run on a disposable server with the current Trades pack');
  if (production) await run('scoreboard players set #new_only it_identity_tmp 1');
  for (const [dimension, y] of [[overworld, 301], [emptyDimension, 120]]) await run(location(dimension, y) + ' run kill ' + actor);
  const found = await fixture(overworld, 301);
  const mapCount = (found.offers.match(/minecraft:filled_map/g) ?? []).length;
  assert(mapCount === 3 || mapCount === 4, found.offers);
  assert.equal((found.offers.match(/minecraft:map_id/g) ?? []).length, mapCount);
  assert.equal((found.offers.match(/minecraft:map_decorations/g) ?? []).length, mapCount);
  const destinations = await run('data get storage ' + found.base + '.rolled');
  const types = [...destinations.matchAll(/destination: "(\w+)"/g)].map(match => match[1]);
  assert.equal(types.length, mapCount);
  assert.equal(new Set(types).size, mapCount);
  const initial = found.offers;
  await run('reload');
  await wait(1900);
  assert.equal(await run(found.at + 'data get entity ' + actor + ' Offers.Recipes'), initial);
  await run(found.at + 'setblock 2 301 2 stonecutter');
  await run('data modify storage ' + found.base + '.clock.ordinary set value 71999');
  await wait(350);
  assert.match(await run('data get storage ' + found.base + '.clock.ordinary'), /72000$/);
  await run(found.at + 'setblock 2 301 2 cartography_table');
  await wait(350);
  const clock = await run('data get storage ' + found.base + '.clock.ordinary');
  assert(Number(clock.match(/(\d+)$/)?.[1]) < 20, clock);
  assert.equal(await run(found.at + 'data get entity ' + actor + ' Offers.Recipes'), initial);

  const missing = await fixture(emptyDimension, 120);
  assert.match(missing.offers, /minecraft:spyglass/);
  assert(!missing.offers.includes('minecraft:filled_map'));
  assert.equal((missing.offers.match(/minecraft:map"/g) ?? []).length, 1, missing.offers);
  const countCommand = missing.at + 'execute store result score #cartographer_count it_identity_tmp run data get entity ' + actor + ' Offers.Recipes';
  await run(countCommand);
  assert.match(await run('scoreboard players get #cartographer_count it_identity_tmp'), /has 10 /);
  console.log(JSON.stringify({ mapsPublished: mapCount, distinctDestinations: types, preservedOnReload: true,
    preservedOnRefill: true, pendingWithoutDestination: 3 }));
} finally {
  for (const [dimension, y] of [[overworld, 301], [emptyDimension, 120]]) await run(location(dimension, y) + ' run kill ' + actor);
  connection.close();
}
