import assert from 'node:assert/strict';
import { HeadlessClient } from './headless-client.mjs';
import { Rcon } from './iron-farm/rcon.mjs';

const rcon = new Rcon();
await rcon.connect();
const client = new HeadlessClient();
const run = command => rcon.send(command);
const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
const tag = 'iota_trading_poll_benchmark';
const population = 64;

async function tickSamples() {
  await wait(7000);
  const samples = [];
  for (let sample = 0; sample < 5; sample++) {
    const response = await run('tick query');
    const match = response.match(/(?:average(?: tick time)?[ :]+)?(\d+(?:\.\d+)?)\s*ms/i);
    assert(match, response);
    samples.push(Number(match[1]));
    await wait(500);
  }
  const sorted = [...samples].sort((a, b) => a - b);
  return { medianMs: sorted[2], samples };
}

try {
  assert.match(await run('datapack list enabled'), /iota-trades-identity/);
  await client.connect();
  await run('gamemode creative IotaProbe');
  await run('tp IotaProbe 35.5 301 0.5');
  await run('kill @e[tag=' + tag + ']');
  await run('forceload add 0 0');
  await run('execute unless score #next it_identity matches 99.. run scoreboard players set #next it_identity 99');
  await run('setblock 2 301 2 smithing_table');
  for (let index = 0; index < population; index++) {
    const x = index % 8;
    const z = Math.floor(index / 8);
    const result = await run('summon villager ' + x + '.5 301 ' + z + '.5 {Tags:["' + tag + '"]'
      + ',NoAI:1b,NoGravity:1b,Invulnerable:1b,VillagerData:{profession:"minecraft:toolsmith",type:"minecraft:plains",level:5},Xp:250'
      + ',Brain:{memories:{"minecraft:job_site":{value:{dimension:"minecraft:overworld",pos:[I;2,301,2]}}}}}');
    assert.match(result, /Summoned/);
  }
  const baseline = await tickSamples();
  await run('tag @e[tag=' + tag + '] add iota_trades_current_probe');
  const managed = await tickSamples();
  const published = await run('execute as @e[tag=' + tag + ',tag=iota_trades_catalog,scores={it_identity=65..}] if data entity @s Offers.Recipes[11]');
  assert.equal((published.match(/Test passed\. Count: 1/g) ?? []).length, population);
  let nearby;
  if (process.argv.includes('--near')) {
    await run('tp IotaProbe 3.5 301 3.5');
    nearby = await tickSamples();
  }
  console.log(JSON.stringify({ population, stage: 'Master', baseline, managed, ...(nearby ? { nearby } : {}) }));
} finally {
  client.close();
  await run('kill @e[tag=' + tag + ']');
  rcon.close();
}
