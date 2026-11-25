import assert from 'node:assert/strict';
import { rollBook, rollEquipment, enchantmentPremium } from './trading-enchantments.mjs';

const nameOf = candidate => candidate.item?.split(':')[1];
const identity = offer => [offer.item, offer.variant, offer.enchantments].join('/');
const variantIdentity = offer => [offer.item, offer.variant].join('/');
const family = offer => nameOf(offer)?.split('_').at(-1);
const isArrow = offer => ['spectral_arrow', 'tipped_arrow'].includes(nameOf(offer));
const next = (options, random) => {
  const total = options.reduce((sum, option) => sum + option.weight, 0);
  let offset = random() * total;
  for (const option of options) {
    offset -= option.weight;
    if (offset < 0) return option;
  }
  return options.at(-1);
};

function orderByWeight(options, random) {
  const remaining = [...options];
  const ordered = [];
  while (remaining.length) {
    const selected = next(remaining, random);
    remaining.splice(remaining.indexOf(selected), 1);
    ordered.push(selected);
  }
  return ordered;
}

export function eligible(offer, context) {
  const { profession, stage, slot, records, direction, locatedMaps, group } = context;
  if (offer.pending) return offer.variant === 'remaining';
  if (offer.resolveDestination) {
    const components = locatedMaps[offer.variant];
    if (!offer.requireComponents.every(component => components?.[component] !== undefined)
      || !Number.isInteger(components['minecraft:map_id'])
      || !Object.keys(components['minecraft:map_decorations']).length) return false;
  }
  if (offer.item === 'minecraft:enchanted_book') return true;
  const sameDirection = records.filter(record => record.offer?.direction === direction);
  const sameSlot = records.filter(record => record.slot === slot);
  const previous = level => sameDirection.filter(record => record.stage === level);
  const exact = record => identity(record.offer) === identity(offer);
  const item = record => variantIdentity(record.offer) === variantIdentity(offer);
  if (slot.distinctBy && sameSlot.some(record => family(record.offer) === family(offer))) return false;
  if (sameSlot.some(item)) return false;

  if (['farmer', 'butcher', 'shepherd', 'librarian', 'cartographer', 'cleric', 'mason'].includes(profession)
    && sameDirection.some(item)) return false;
  if (profession === 'fisherman' && sameDirection.some(exact)) return false;
  if (profession === 'leatherworker') {
    if (direction === 'sell' && sameDirection.some(item)) return false;
    if (direction === 'buy' && nameOf(offer).endsWith('_dye')
      && ['Journeyman', 'Expert', 'Master'].includes(stage) && sameDirection.some(item)) return false;
    if (direction === 'buy' && group.exclude && sameDirection.some(item)) return false;
  }
  if (profession === 'fletcher') {
    if (isArrow(offer) && sameDirection.some(item)) return false;
    if (stage === 'Apprentice' && previous('Novice').some(item)) return false;
  }
  if (profession === 'cartographer' && stage === 'Apprentice' && slot.exclude && previous('Novice').some(item)) return false;
  if (['toolsmith', 'armorer', 'weaponsmith'].includes(profession)) {
    if (direction === 'sell' && stage === 'Apprentice' && previous('Novice').some(item)) return false;
    if (direction === 'sell' && nameOf(offer).endsWith('_ingot') && sameDirection.some(item)) return false;
    if (direction === 'buy' && stage === 'Apprentice' && previous('Novice').some(item)) return false;
    if (direction === 'buy' && profession === 'armorer' && stage !== 'Master' && sameDirection.some(item)) return false;
    if (direction === 'buy' && stage === 'Journeyman' && nameOf(offer) === 'iron_ingot'
      && previous('Apprentice').some(item)) return false;
  }
  return !(direction === 'buy' && stage === 'Master' && slot.exclude && previous('Expert').some(exact));
}

export function weightedLeaves(group, context) {
  const nested = group.groups?.flatMap(child => weightedLeaves(child, context));
  const leaves = nested ?? group.candidates.filter(offer => eligible(offer, { ...context, group }))
    .map(offer => ({ offer, weight: 1 }));
  if (!leaves.length) return [];
  if (group.conditionalColorChances && leaves.some(leaf => nameOf(leaf.offer) === 'white_wool') && leaves.length > 1) {
    for (const leaf of leaves) leaf.weight = nameOf(leaf.offer) === 'white_wool' ? .5 : .5 / (leaves.length - 1);
  }
  if (group.familyWeights === 'equal') {
    const counts = new Map();
    for (const leaf of leaves) counts.set(family(leaf.offer), (counts.get(family(leaf.offer)) ?? 0) + 1);
    for (const leaf of leaves) leaf.weight = 1 / counts.get(family(leaf.offer));
  }
  if (group.materialChances) {
    const counts = new Map();
    for (const leaf of leaves) {
      const material = nameOf(leaf.offer).split('_')[0];
      counts.set(material, (counts.get(material) ?? 0) + 1);
    }
    for (const leaf of leaves) {
      const material = nameOf(leaf.offer).split('_')[0];
      leaf.weight = group.materialChances[material] / counts.get(material);
    }
  }
  const fixedWeight = group.chance ?? group.weight ?? (group.family || group.familyWeights ? 1 : undefined);
  if (fixedWeight !== undefined) {
    const subtotal = leaves.reduce((sum, leaf) => sum + leaf.weight, 0);
    for (const leaf of leaves) leaf.weight *= fixedWeight / subtotal;
  }
  return leaves;
}

function payment(total) {
  const blocks = total > 64 ? Math.min(64, Math.floor((total - 1) / 9)) : 0;
  const emeralds = total - blocks * 9;
  assert(emeralds > 0 && emeralds <= 64);
  return [{ item: 'minecraft:emerald', count: emeralds },
    ...(blocks ? [{ item: 'minecraft:emerald_block', count: blocks }] : [])];
}

function materialize(candidate, current, records, villagerType, locatedMaps, catalog, random) {
  if (!candidate) return null;
  const offer = structuredClone(candidate);
  delete offer.enchantmentExamples;
  if (offer.pending && offer.variant === 'remaining') {
    const picked = records.find(record => record.slot.saveRemainingCandidate)?.offer.variant;
    const remaining = current.masterBooks.find(book => book.variant !== picked);
    assert(remaining, 'Missing the second Master book candidate');
    return structuredClone(remaining);
  }
  if (offer.resolveDestination) offer.output.components = structuredClone(locatedMaps[offer.variant]);
  if (offer.item === 'minecraft:enchanted_book') {
    const specialty = catalog.sharedRules.treasureSpecialty.biomes[villagerType];
    const existing = new Set(records.filter(record => record.offer?.item === offer.item)
      .map(record => JSON.stringify(record.offer.output.components)));
    if (current.slot.saveRemainingCandidate) {
      return structuredClone(current.masterBooks.find(book => book.variant === offer.variant));
    }
    for (let attempt = 0; attempt < 128; attempt++) {
      const effects = rollBook(offer.variant, specialty, random);
      offer.output.components = { 'minecraft:stored_enchantments': effects };
      if (existing.has(JSON.stringify(offer.output.components))) continue;
      const { base, perLevel } = offer.priceFormula;
      offer.inputs = payment(base + perLevel * Object.values(effects)[0]);
      return offer;
    }
    throw new Error('Unable to draw a distinct book for ' + catalog.profession);
  }
  if (offer.direction === 'sell' && offer.perLevelPremium) {
    const effects = rollEquipment(offer.item, current.stage, random);
    offer.output.components = { 'minecraft:enchantments': effects };
    const base = offer.inputs.reduce((sum, input) => sum + input.count * (input.item.endsWith('emerald_block') ? 9 : 1), 0);
    offer.inputs = payment(base + enchantmentPremium(effects));
  }
  if (offer.variant && offer.item === 'minecraft:tipped_arrow') {
    const stack = offer.direction === 'sell' ? offer.output : offer.inputs[0];
    stack.components = { 'minecraft:potion_contents': { potion: 'minecraft:' + offer.variant } };
  }
  return offer;
}

export function planOffers(catalog, { villagerType = 'plains', locatedMaps = {}, random = Math.random } = {}) {
  const profession = catalog.profession.split(':')[1];
  const weightedGroups = Object.entries(catalog.sharedRules.groupWeights ?? {});
  const saleGroup = weightedGroups.length
    ? next(weightedGroups.map(([name, weight]) => ({ name, weight })), random).name : undefined;
  const steps = catalog.stages.flatMap(stage => [...stage.sales, ...stage.purchases]
    .filter(slot => !slot.requiresSaleGroup || slot.requiresSaleGroup === saleGroup)
    .flatMap(slot => Array.from({ length: slot.draws }, () => ({
      stage: stage.name, slot, direction: stage.sales.includes(slot) ? 'sell' : 'buy',
    }))));
  const records = [];
  let attempts = 0;
  function fill(index, masterBooks = []) {
    if (index === steps.length) return true;
    if (++attempts > 10000) throw new Error('Offer search overflow for ' + profession);
    const step = steps[index];
    const ctx = { ...step, profession, records, locatedMaps, masterBooks };
    const pool = step.slot.groups.flatMap(group => weightedLeaves(group, ctx));
    if (!pool.length) {
      const mapSlot = step.slot.groups.some(group => group.candidates?.some(candidate => candidate.resolveDestination));
      if (!mapSlot) return false;
      records.push({ ...step, offer: null, pending: 'no eligible destination' });
      const filled = fill(index + 1, masterBooks);
      if (!filled) records.pop();
      return filled;
    }
    if (step.slot.saveRemainingCandidate) {
      masterBooks = pool.map(({ offer }) => materialize(offer, { ...step, slot: {} }, records,
        villagerType, locatedMaps, catalog, random));
      ctx.masterBooks = masterBooks;
    }
    for (const { offer: picked } of orderByWeight(pool, random)) {
      const offer = materialize(picked, ctx, records, villagerType, locatedMaps, catalog, random);
      records.push({ ...step, offer });
      if (fill(index + 1, masterBooks)) return true;
      records.pop();
    }
    return false;
  }
  assert(fill(0), 'No complete offer plan for ' + profession);
  return { profession: catalog.profession, villagerType, ...(saleGroup ? { saleGroup } : {}),
    offers: records.map(({ stage, offer, pending }) => ({ stage, ...(offer ? { offer } : { pending }) })) };
}
