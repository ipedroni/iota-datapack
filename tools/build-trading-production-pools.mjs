import assert from 'node:assert/strict';
import fs from 'node:fs';
import { eligible, weightedLeaves } from './trading-offer-plan.mjs';
import { nativeOffer } from './trading-native-offer.mjs';
import { bookOutcomes, enchantmentPremium, equipmentOutcomes } from './trading-enchantments.mjs';

const professions = ['toolsmith', 'weaponsmith', 'armorer', 'fletcher', 'leatherworker',
  'farmer', 'butcher', 'fisherman', 'shepherd', 'cleric', 'mason', 'librarian', 'cartographer'];
const xp = [1, 5, 10, 15, 20];
function concrete(candidate, stage, specialty) {
  if (candidate.pendingMap) return [{ weight: 1 }];
  if (candidate.item === 'minecraft:enchanted_book') {
    return bookOutcomes(candidate.variant, specialty).map(({ effects, weight }) => {
      const [id, level] = Object.entries(effects)[0];
      const offer = structuredClone(candidate);
      const { base, perLevel } = candidate.priceFormula;
      offer.output.components = { 'minecraft:stored_enchantments': effects };
      offer.inputs = [{ item: 'minecraft:emerald', count: base + perLevel * level }];
      return { weight: Math.max(1, Math.round(weight * 100000)), signature: id + '/' + level, native: nativeOffer(offer) };
    });
  }
  if (!candidate.perLevelPremium) {
    const offer = structuredClone(candidate);
    if (offer.variant && offer.item === 'minecraft:tipped_arrow') {
      const stack = offer.direction === 'sell' ? offer.output : offer.inputs[0];
      stack.components = { 'minecraft:potion_contents': { potion: 'minecraft:' + offer.variant } };
    }
    return [{ weight: 1, native: nativeOffer(offer) }];
  }
  return equipmentOutcomes(candidate.item, stage).map(({ effects, weight }) => {
    const offer = structuredClone(candidate);
    offer.output.components = { 'minecraft:enchantments': effects };
    const total = candidate.inputs.reduce((sum, input) => sum
      + input.count * (input.item === 'minecraft:emerald_block' ? 9 : 1), 0) + enchantmentPremium(effects);
    const blocks = total > 64 ? Math.min(64, Math.floor((total - 1) / 9)) : 0;
    offer.inputs = [{ item: 'minecraft:emerald', count: total - blocks * 9 },
      ...(blocks ? [{ item: 'minecraft:emerald_block', count: blocks }] : [])];
    return { weight: Math.max(1, Math.round(weight * 100000)), native: nativeOffer(offer) };
  });
}

function compile(catalog, profession, saleGroup, villagerType) {
  const stages = catalog.stages.flatMap(({ name: stage, sales, purchases }, index) =>
    [sales, purchases].flatMap((slots, d) => slots
      .filter(slot => !slot.requiresSaleGroup || slot.requiresSaleGroup === saleGroup)
      .flatMap(slot => Array.from({ length: slot.draws }, () =>
        ({ stage, slot, direction: d ? 'buy' : 'sell', level: index + 1 })))));
  const offers = [];
  const mapSlots = [];
  const masterBooks = profession === 'librarian' ? catalog.stages.at(-1).sales[0].groups.flatMap(group => group.candidates) : [];
  const specialty = catalog.sharedRules.treasureSpecialty?.biomes[villagerType];
  const compiled = stages.map((step, index) => {
    const context = { ...step, profession, locatedMaps: {}, records: [] };
    let leaves = step.slot.groups.flatMap((group, bucket) => {
      if (group.reuseRemainingCandidate) return masterBooks.map(offer => ({ offer, weight: .5, group, mass: 1, bucket }));
      const mass = group.chance ?? group.weight ?? (group.family || group.familyWeights ? 1 : 0);
      return weightedLeaves(group, context).map(entry => ({ ...entry, group, mass, bucket }));
    });
    const mapCandidates = step.slot.groups.flatMap(group => group.candidates ?? []).filter(offer => offer.resolveDestination);
    if (mapCandidates.length) {
      mapSlots.push({ slot: index + 1, choices: mapCandidates.map(offer => ({
        destination: offer.variant, table: offer.lootTable, native: nativeOffer(offer),
      })) });
      if (!leaves.length) leaves = [{
        offer: { item: 'minecraft:filled_map', direction: 'sell', variant: 'pending_' + index, pendingMap: true },
        weight: 1, group: {}, mass: 0, bucket: 0,
      }];
    }
    const candidates = leaves.map(({ offer, weight, group, mass, bucket }, candidateIndex) => {
      const key = 'c' + candidateIndex;
      const denied = offers.flatMap((options, previous) => options.filter(({ offer: prior }) =>
        (group.reuseRemainingCandidate && stages[previous].slot.saveRemainingCandidate && prior.variant === offer.variant)
        || !eligible(offer, { ...context, group, records: [{ ...stages[previous], offer: prior }] }))
        .map(option => ({ slot: 's' + (previous + 1), choice: option.key })));
      return { key, offer, weight: Math.max(1, Math.round(weight * 1000 / (mass || 1))),
        mass: mass * 1000, bucket: 'b' + bucket, denied };
    });
    offers.push(candidates);
    return { slot: index + 1, direction: step.direction,
      candidates: candidates.map(({ offer, key, weight, mass, bucket, denied }) => {
        let limit = 0;
        const variants = concrete(offer, step.stage, specialty).map(({ weight: odds, signature, native }) => {
          limit += odds;
          return { ceiling: limit, ...(signature ? { signature } : {}), ...(native ? { native } : {}) };
        });
        return { key, weight, mass, bucket, denied, item: offer.item, level: step.level, xp: xp[step.level - 1], limit, variants };
      }) };
  });
  assert.equal(compiled.length, catalog.examplePlan.offers.length);
  assert(compiled.every(step => step.candidates.length && step.candidates.every(candidate => candidate.weight > 0 && candidate.variants.length)));
  return { compiled, mapSlots };
}
const base = new URL('../modules/experimental/trades/data/iota_trades/function/production/', import.meta.url);
fs.mkdirSync(base, { recursive: true });
const lines = ['# Generated by tools/build-trading-production-pools.mjs. Individual weighted offers, not fixed plans.'];
const summary = [];
for (const profession of professions) {
  const file = new URL('../docs/discovery/drafts/trading_' + profession + '_catalog.json', import.meta.url);
  const catalog = JSON.parse(fs.readFileSync(file, 'utf8'));
  const variants = catalog.sharedRules.persistentSaleGroups
    ?? Object.keys(catalog.sharedRules.treasureSpecialty?.biomes ?? {}).map(type => 'type_' + type);
  for (const variant of variants.length ? variants : [null]) {
    const key = variant ? profession + '_' + variant : profession;
    const { compiled, mapSlots } = compile(catalog, profession, variant, variant?.replace('type_', ''));
    if (mapSlots.length) {
      lines.push('data modify storage iota_trades:production ' + key + '_maps set value ' + JSON.stringify(mapSlots));
    }
    lines.push('data modify storage iota_trades:production ' + key + ' set value []');
    for (const { candidates, ...slot } of compiled) {
      lines.push('data modify storage iota_trades:production ' + key + ' append value ' + JSON.stringify({ ...slot, candidates: [] }));
      for (const candidate of candidates) {
        lines.push('data modify storage iota_trades:production ' + key + '[-1].candidates append value ' + JSON.stringify(candidate));
      }
    }
    summary.push({ key, slots: compiled.length, candidates: compiled.reduce((n, slot) => n + slot.candidates.length, 0) });
  }
}
fs.writeFileSync(new URL('pools.mcfunction', base), lines.join('\n') + '\n');
console.log(JSON.stringify(summary));
