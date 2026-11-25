import assert from 'node:assert/strict';
import { HeadlessClient, vi } from './headless-client.mjs';
import { Rcon } from './iron-farm/rcon.mjs';

const rcon = new Rcon();
const client = new HeadlessClient();
const second = new HeadlessClient('IotaOther');
const run = command => rcon.send(command);
const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
const fixture = '@e[type=minecraft:villager,tag=iota_current_qual_test,limit=1]';
const cases = [
  { label: 'plain axe', item: 'iron_axe', effects: {}, accepted: true },
  { label: 'qualifying Basic plus extra', item: 'iron_axe', effects: { efficiency: 2, unbreaking: 3, fortune: 1 }, accepted: true },
  { label: 'higher Basic only', item: 'iron_axe', effects: { efficiency: 3 }, accepted: false },
  { label: 'Advanced only', item: 'iron_axe', effects: { fortune: 1 }, accepted: false },
  { label: 'damaged Basic', item: 'iron_axe', effects: { efficiency: 1 }, damage: 1, accepted: false },
  { label: 'plain-only with enchantment', item: 'leather_boots', effects: { protection: 1 }, plainOnly: true, accepted: false },
  { label: 'plain-only unenchanted', item: 'leather_boots', effects: {}, plainOnly: true, accepted: true },
  { label: 'Shears with Basic', item: 'shears', effects: { unbreaking: 2 }, accepted: true },
  { label: 'foreign qualification components preserved', item: 'iron_axe', effects: { efficiency: 1 }, foreign: true, accepted: false },
  { label: 'item changed after opening', item: 'iron_axe', effects: { efficiency: 2 }, replaceWith: 'fortune', accepted: false },
];

await rcon.connect();
try {
  assert.match(await run('datapack list enabled'), /iota-trades-identity/);
  await client.connect();
  await second.connect();
  await run('gamemode survival IotaProbe');
  await run('effect clear IotaProbe');
  await run('fill -2 300 -2 13 300 3 stone');
  let sequence = Math.floor(Math.random() * 0x3fffffff);
  for (const test of cases) {
    await run('tp IotaProbe 12.5 301 0.5');
    await run('clear IotaProbe');
    await run('kill ' + fixture);
    const effects = Object.fromEntries(Object.entries(test.effects).map(([key, level]) => ['minecraft:' + key, level]));
    const componentList = [
      'minecraft:damage=' + (test.damage ?? 0),
      'minecraft:enchantments=' + JSON.stringify(effects),
      'minecraft:custom_name={text:"Keep Name"}',
      'minecraft:custom_data={foreign:{keep:1}}',
    ];
    if (test.foreign) componentList.push('minecraft:map_color=123', 'minecraft:note_block_sound="minecraft:entity.villager.ambient"');
    await run('item replace entity IotaProbe hotbar.0 with minecraft:' + test.item + '[' + componentList.join(',') + ']');
    const inventory = () => run('data get entity IotaProbe Inventory[{Slot:0b}]');
    const original = await inventory();
    const parts = [5681, 331, 891, ++sequence];
    const uuid = Buffer.alloc(16);
    parts.forEach((part, index) => uuid.writeInt32BE(part, index * 4));
    const components = { 'minecraft:damage': 0, ...(test.plainOnly
      ? { 'minecraft:note_block_sound': 'iota_trades_qual:plain' } : { 'minecraft:map_color': 1091330 }) };
    const offer = {
      buy: { id: 'minecraft:' + test.item, count: 1, components },
      sell: { id: 'minecraft:emerald', count: 8 }, maxUses: 1, priceMultiplier: 0,
    };
    const spawned = await run('summon villager 1.5 301 0.5 {UUID:[I;' + parts.join(',')
      + '],Tags:["iota_current_qual_test","iota_trades_catalog","iota_trades_current_probe"],NoAI:1b,Invulnerable:1b'
      + ',VillagerData:{profession:"minecraft:butcher",type:"minecraft:plains",level:1},Offers:{Recipes:[' + JSON.stringify(offer) + ']}}');
    assert.match(spawned, /Summoned/);
    await run('tp IotaProbe 0.5 301 0.5');
    await wait(350);
    const target = client.entities.get(uuid.toString('hex'));
    assert(target !== undefined);
    client.interact(target);
    await wait(250);
    assert(client.containerId);
    if (test.replaceWith) {
      await run('tp IotaOther 0.5 301 0.5');
      await wait(200);
      const otherTarget = second.entities.get(uuid.toString('hex'));
      assert(otherTarget !== undefined);
      second.interact(otherTarget);
      await wait(200);
      assert(!second.containerId, 'Two players opened the same villager concurrently');
      const replacement = componentList.map(component => component.startsWith('minecraft:enchantments=')
        ? 'minecraft:enchantments=' + JSON.stringify({ ['minecraft:' + test.replaceWith]: 1 }) : component);
      replacement.push('minecraft:note_block_sound="iota_trades_qual:basic"', 'minecraft:map_color=1091330');
      await run('item replace entity IotaProbe hotbar.0 with minecraft:' + test.item + '[' + replacement.join(',') + ']');
      await wait(180);
      assert(!(await inventory()).includes('1091330'), 'Replaced equipment still qualifies');
      // Only the temporary qualification components are expected to disappear on leaving.
      await run('data modify storage iota_trades:qual_test rejected set from entity IotaProbe Inventory[{Slot:0b}]');
      await run('data remove storage iota_trades:qual_test rejected.components."minecraft:map_color"');
      await run('data remove storage iota_trades:qual_test rejected.components."minecraft:note_block_sound"');
    }
    client.send('select_trade', vi(0));
    await wait(180);
    client.quickMove(2);
    await wait(350);
    client.closeContainer();
    const recipe = await run('data get entity ' + fixture + ' Offers.Recipes[0]');
    const uses = Number(recipe.match(/\buses: (\d+)/)?.[1] ?? 0);
    assert.equal(uses, test.accepted ? 1 : 0, test.label + ': ' + recipe + ' ' + await inventory());
    assert.equal((await run('data get entity IotaProbe Inventory')).includes('id: "minecraft:emerald"'), test.accepted, test.label);
    await run('tp IotaProbe 12.5 301 0.5');
    await wait(220);
    if (test.replaceWith) {
      await run('data modify storage iota_trades:qual_test compare set from entity IotaProbe Inventory[{Slot:0b}]');
      await run('execute store success score #qual_changed it_identity_tmp run data modify storage iota_trades:qual_test compare set from storage iota_trades:qual_test rejected');
      assert.match(await run('scoreboard players get #qual_changed it_identity_tmp'), /has 0 /);
      await run('tp IotaOther 12.5 301 0.5');
    } else if (!test.accepted) assert.equal(await inventory(), original, test.label + ': rejected item changed');
    console.log('PASS ' + test.label);
  }
  await run('tp IotaProbe 0.5 301 0.5');
  await run('clear IotaProbe');
  await run('clear IotaOther');
  const dropped = '@e[type=minecraft:item,nbt={Item:{id:"minecraft:iron_axe",components:{"minecraft:custom_data":{probe_transfer:1}}}},limit=1]';
  await run('kill ' + dropped);
  await run('item replace entity IotaProbe hotbar.0 with minecraft:iron_axe[minecraft:enchantments={"minecraft:efficiency":1},minecraft:custom_data={probe_transfer:1},minecraft:note_block_sound="iota_trades_qual:basic",minecraft:map_color=1091330]');
  client.send('player_action', Buffer.concat([vi(3), Buffer.alloc(8), Buffer.from([0]), vi(1)]));
  await wait(350);
  const stack = await run('data get entity ' + dropped + ' Item');
  assert.match(stack, /probe_transfer: 1/);
  assert(!stack.includes('1091330'));
  await run('tp IotaProbe 20.5 301 0.5');
  await wait(2300);
  assert.match(await run('tp IotaOther ' + dropped), /Teleported/);
  await wait(600);
  await run('tp IotaOther 20.5 301 0.5');
  await wait(220);
  const received = await run('data get entity IotaOther Inventory');
  assert.match(received, /probe_transfer: 1/);
  assert(!received.includes('1091330'));
  console.log('PASS dropped equipment transferred cleanly');

  await run('kill ' + fixture);
  const pair = [
    { player: 'IotaProbe', peer: client, x: 0, item: 'iron_axe', effect: 'efficiency', level: 2, expected: 1 },
    { player: 'IotaOther', peer: second, x: 12, item: 'shears', effect: 'unbreaking', level: 3, expected: 0 },
  ];
  for (const test of pair) {
    const { player, x, item, effect, level } = test;
    await run('gamemode survival ' + player);
    await run('tp ' + player + ' ' + x + '.5 301 0.5');
    await run('clear ' + player);
    await run('item replace entity ' + player + ' hotbar.0 with minecraft:' + item
      + '[minecraft:enchantments={"minecraft:' + effect + '":' + level + '},minecraft:custom_data={concurrent_owner:"' + player + '"}]');
    const parts = [5681, 331, 891, ++sequence];
    const uuid = Buffer.alloc(16);
    parts.forEach((part, index) => uuid.writeInt32BE(part, index * 4));
    test.uuid = uuid;
    test.tag = 'iota_qual_concurrent_' + player;
    test.actor = '@e[type=minecraft:villager,tag=' + test.tag + ',limit=1]';
    await run('kill ' + test.actor);
    const offer = {
      buy: { id: 'minecraft:' + item, count: 1, components: { 'minecraft:damage': 0, 'minecraft:map_color': 1091330 } },
      sell: { id: 'minecraft:emerald', count: 8 }, maxUses: 1, priceMultiplier: 0,
    };
    const spawn = await run('summon villager ' + (x + 1) + '.5 301 0.5 {UUID:[I;' + parts.join(',')
      + '],Tags:["iota_current_qual_concurrent","iota_trades_catalog","iota_trades_current_probe","' + test.tag
      + '"],NoAI:1b,Invulnerable:1b,VillagerData:{profession:"minecraft:butcher",type:"minecraft:plains",level:1},Offers:{Recipes:['
      + JSON.stringify(offer) + ']}}');
    assert.match(spawn, /Summoned/);
  }
  await wait(350);
  for (const { peer, uuid } of pair) {
    const target = peer.entities.get(uuid.toString('hex'));
    assert(target !== undefined);
    peer.interact(target);
  }
  await wait(250);
  assert(pair.every(({ peer }) => peer.containerId), 'Both menus must be open before testing concurrent trades');
  for (const { peer } of pair) peer.send('select_trade', vi(0));
  await wait(180);
  for (const { peer } of pair) peer.quickMove(2);
  await wait(350);
  for (const { player, peer, actor, expected } of pair) {
    peer.closeContainer();
    const recipe = await run('data get entity ' + actor + ' Offers.Recipes[0]');
    const uses = Number(recipe.match(/\buses: (\d+)/)?.[1] ?? 0);
    assert.equal(uses, expected, player + ': ' + recipe);
    const inventory = await run('data get entity ' + player + ' Inventory');
    assert.equal(inventory.includes('id: "minecraft:emerald"'), Boolean(expected), player);
    if (!expected) assert.match(inventory, /concurrent_owner: "IotaOther"/);
  }
  console.log('PASS concurrent transactions remained isolated');
} finally {
  client.close();
  second.close();
  await run('kill ' + fixture);
  await run('kill @e[type=minecraft:villager,tag=iota_current_qual_concurrent]');
  rcon.close();
}
