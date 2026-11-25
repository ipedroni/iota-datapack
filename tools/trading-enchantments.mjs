import assert from 'node:assert/strict';
import fs from 'node:fs';

const vendor = new URL('../vendor/generated/data/minecraft/', import.meta.url);
const load = name => JSON.parse(fs.readFileSync(new URL(name, vendor), 'utf8'));
const design = fs.readFileSync(new URL('../docs/design_directions.md', import.meta.url), 'utf8');
const definitions = new Map();
const categoryRows = design.split('## Shared enchantment classification')[1].split('## Repository layout')[0];
function expand(kind, value, seen = new Set()) {
  if (Array.isArray(value)) return value.flatMap(entry => expand(kind, entry, seen));
  if (typeof value === 'object') return expand(kind, value.id, seen);
  if (!value.startsWith('#')) return [value];
  assert(!seen.has(value), value);
  const file = 'tags/' + kind + '/' + value.slice('#minecraft:'.length) + '.json';
  return expand(kind, load(file).values, new Set([...seen, value]));
}
for (const line of categoryRows.split(/\r?\n/)) {
  const [, category, , effects] = line.split('|').map(part => part.trim());
  if (!['Basic', 'Advanced', 'Situational', 'Treasure'].includes(category)) continue;
  for (const name of effects.replace(/\.$/, '').split(', ')) {
    const key = name.toLowerCase().replaceAll(' ', '_');
    const data = load('enchantment/' + key + '.json');
    definitions.set('minecraft:' + key, {
      id: 'minecraft:' + key, category, max: data.max_level,
      items: new Set(expand('item', data.supported_items)),
      exclusive: new Set(expand('enchantment', data.exclusive_set ?? [])),
    });
  }
}

const bands = {
  low: [[1, 1], [1, 1], [1, 1], [1, 2], [1, 2]],
  medium: [[1, 1], [1, 2], [2, 2], [2, 3], [2, 4]],
  high: [[1, 1], [2, 2], [3, 3], [3, 4], [4, 5]],
};
const integer = (low, high, random) => low + Math.floor(random() * (high - low + 1));
const choose = (options, random) => options[integer(0, options.length - 1, random)];
const mending = 'minecraft:mending';
const axe = new Set(['efficiency', 'unbreaking', 'fortune', 'silk_touch', 'mending'].map(id => 'minecraft:' + id));
const compatibility = (first, second) =>
  !first.exclusive.has(second.id) && !second.exclusive.has(first.id)
  && !(first.category === 'Treasure' && second.category === 'Treasure');

function combinations(pool, target, chosen = [], index = 0) {
  if (chosen.length === target) return [chosen];
  const results = [];
  for (let i = index; i <= pool.length - target + chosen.length; i++) {
    if (chosen.every(other => compatibility(pool[i], other))) {
      results.push(...combinations(pool, target, [...chosen, pool[i]], i + 1));
    }
  }
  return results;
}

function equipmentPool(item, stage, includeMending) {
  const master = stage === 'Master';
  const journeyman = stage === 'Journeyman';
  assert(master || journeyman || stage === 'Expert', stage);
  const gated = master && (item.endsWith('_sword') || item === 'minecraft:crossbow');
  return [...definitions.values()].filter(effect =>
    effect.items.has(item)
    && (!item.endsWith('_axe') || axe.has(effect.id))
    && (!journeyman || ['Basic', 'Situational'].includes(effect.category))
    && (master || effect.category !== 'Treasure')
    && (!gated || effect.id !== mending || includeMending));
}

function viableSets(pool, target, stage, includeMending) {
  for (let count = target; count > 0; count--) {
    const viable = combinations(pool, count)
      .filter(list => !includeMending || list.some(effect => effect.id === mending))
      .filter(list => stage !== 'Master' || list.some(effect => effect.category !== 'Situational'));
    if (viable.length) return viable;
  }
  throw new Error('No eligible enchantments at ' + stage);
}

export function rollEquipment(item, stage, random = Math.random) {
  const master = stage === 'Master';
  const journeyman = stage === 'Journeyman';
  const potency = master ? 'high' : journeyman ? 'low' : 'medium';
  const gated = master && (item.endsWith('_sword') || item === 'minecraft:crossbow');
  const includeMending = gated && random() < .025;
  const target = journeyman ? integer(1, 2, random) : integer(2, 4, random);
  const options = viableSets(equipmentPool(item, stage, includeMending), target, stage, includeMending);
  return Object.fromEntries(choose(options, random).map(effect =>
    [effect.id, integer(...bands[potency][effect.max - 1], random)]));
}

export function equipmentOutcomes(item, stage) {
  const gated = stage === 'Master' && (item.endsWith('_sword') || item === 'minecraft:crossbow');
  const targets = stage === 'Journeyman' ? [1, 2] : [2, 3, 4];
  const potency = stage === 'Master' ? 'high' : stage === 'Expert' ? 'medium' : 'low';
  const results = new Map();
  const passes = gated ? [[false, .975], [true, .025]] : [[false, 1]];
  for (const [includeMending, chance] of passes) {
    const pool = equipmentPool(item, stage, includeMending);
    for (const target of targets) {
      const combinations = viableSets(pool, target, stage, includeMending);
      for (const combination of combinations) {
        const concrete = combination.reduce((options, effect) => {
          const [low, high] = bands[potency][effect.max - 1];
          return options.flatMap(option => Array.from({ length: high - low + 1 }, (_, index) =>
            ({ ...option, [effect.id]: low + index })));
        }, [{}]);
        const weight = chance / targets.length / combinations.length / concrete.length;
        for (const effects of concrete) {
          const key = JSON.stringify(effects);
          results.set(key, { effects, weight: (results.get(key)?.weight ?? 0) + weight });
        }
      }
    }
  }
  return [...results.values()];
}

export function rollBook(variant, specialty, random = Math.random) {
  assert(['journeyman', 'expert', 'treasure'].includes(variant), variant);
  const effects = [...definitions.values()];
  const treasure = variant === 'treasure';
  const journeyman = variant === 'journeyman';
  const specialtyId = specialty && 'minecraft:' + specialty[0];
  let pool = effects.filter(effect => treasure ? effect.category === 'Treasure'
    : effect.category !== 'Treasure' && (!journeyman || effect.category !== 'Advanced'));
  if (treasure && specialty) {
    if (random() < .75) return { [specialtyId]: integer(specialty[1], specialty[2], random) };
    pool = pool.filter(effect => effect.id !== specialtyId);
  }
  const effect = choose(pool, random);
  const potency = treasure || journeyman && effect.category === 'Situational'
    ? choose(journeyman ? ['low', 'medium'] : ['medium', 'high'], random)
    : journeyman ? 'low' : 'high';
  return { [effect.id]: integer(...bands[potency][effect.max - 1], random) };
}

export function bookOutcomes(variant, specialty) {
  assert(['journeyman', 'expert', 'treasure'].includes(variant), variant);
  const treasure = variant === 'treasure';
  const journeyman = variant === 'journeyman';
  const specialtyId = specialty && 'minecraft:' + specialty[0];
  const pool = [...definitions.values()].filter(effect => treasure
    ? effect.category === 'Treasure' && effect.id !== specialtyId
    : effect.category !== 'Treasure' && (!journeyman || effect.category !== 'Advanced'));
  const outcome = new Map();
  function add(id, level, weight) {
    const key = id + '/' + level;
    outcome.set(key, { effects: { [id]: level }, weight: (outcome.get(key)?.weight ?? 0) + weight });
  }
  if (treasure && specialty) {
    const [ , low, high] = specialty;
    for (let level = low; level <= high; level++) add(specialtyId, level, .75 / (high - low + 1));
  }
  const groupWeight = treasure && specialty ? .25 : 1;
  for (const effect of pool) {
    const potencies = treasure ? ['medium', 'high']
      : journeyman && effect.category === 'Situational' ? ['low', 'medium']
      : journeyman ? ['low'] : ['high'];
    for (const potency of potencies) {
      const [low, high] = bands[potency][effect.max - 1];
      const weight = groupWeight / pool.length / potencies.length / (high - low + 1);
      for (let level = low; level <= high; level++) add(effect.id, level, weight);
    }
  }
  return [...outcome.values()];
}

export function enchantmentPremium(effects) {
  const entries = Object.entries(effects);
  return entries.reduce((sum, [, level]) => sum + level, 0)
    + (entries.some(([id]) => definitions.get(id).category === 'Treasure') ? 4 : 0);
}
