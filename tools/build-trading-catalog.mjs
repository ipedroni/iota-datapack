import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { sales as retailQuotes, purchases as purchaseQuotes } from './trading-candidate-quotes.mjs';
import { professionPools } from './trading-profession-pools.mjs';
import { rollEquipment, rollBook, enchantmentPremium } from './trading-enchantments.mjs';
import { explorerMaps } from './trading-explorer-maps.mjs';
import { planOffers } from './trading-offer-plan.mjs';

const root = fileURLToPath(new URL('../', import.meta.url));
const output = path.join(root, 'docs/discovery/drafts');
const read = file => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const matrix = new Map(read('docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/items.json')
  .map(item => [item.id.replace('minecraft:', ''), item.value_vu]));
const families = ['pickaxe', 'axe', 'shovel', 'hoe'];
const namespace = item => 'minecraft:' + item;
const tools = materials => families.flatMap(family => materials.map(material => material + '_' + family));
const ordinary = ['copper', 'iron'];
const heroInput = (count, level) => level
  ? Math.max(1, count - Math.max(1, Math.floor(count * (.30 + .0625 * (level - 1)))))
  : count;

function encodeRetail(total) {
  const blocks = total > 64 ? Math.min(64, Math.floor((total - 1) / 9)) : 0;
  const emeralds = total - blocks * 9;
  assert(emeralds >= 1 && emeralds <= 64);
  return [stack('emerald', emeralds), ...(blocks ? [stack('emerald_block', blocks)] : [])];
}

function stack(item, count) {
  assert(Number.isInteger(count) && count >= 1 && count <= 64);
  return { item: namespace(item), count };
}

const buy = {
  flint: [48, 12], coal: [32, 15], charcoal: [32, 9], copper_ingot: [32, 17],
  iron_ingot: [32, 62], gold_ingot: [64, 243], diamond: [1, 15], leather: [32, 9],
};
const sell = {
  copper_ingot: [8, 21], iron_ingot: [8, 41], gold_ingot: [8, 72],
  diamond: [1, 34], netherite_scrap: [1, 68],
};
const explicitTools = { iron_axe: [19, 8], iron_shovel: [9, 4] };

function toolBidAndAsk(item) {
  const value = matrix.get(item);
  assert(Number.isFinite(value), item);
  if (item.endsWith('_horse_armor') || item.endsWith('_nautilus_armor')) {
    return { bid: 0, ask: Math.ceil(1.05 * value) };
  }
  const material = item.split('_')[0];
  const recipeName = material === 'netherite' ? item + '_smithing' : item;
  const recipe = read('vendor/generated/data/minecraft/recipe/' + recipeName + '.json');
  const metal = material === 'golden' ? 'gold_ingot' : material === 'diamond' ? 'diamond' : material + '_ingot';
  const ingredients = (recipe.pattern ?? []).join('').replaceAll(' ', '').split('').map(symbol => recipe.key[symbol]);
  const estimate = material === 'netherite' ? value
    : ingredients.reduce((sum, id) => sum + matrix.get(id.startsWith('#') ? metal : id.replace('minecraft:', '')), 0);
  assert(Number.isFinite(estimate), item);
  const floor = Math.ceil(estimate + 1);
  const [startingAsk, startingBid] = explicitTools[item] ?? [Math.ceil(1.05 * value), Math.max(1, Math.floor(.95 * value))];
  const bid = ['diamond', 'netherite'].includes(material) ? 0 : Math.max(startingBid, floor);
  let ask = Math.max(startingAsk, floor);
  while (heroInput(encodeRetail(ask)[0].count, 5) + (encodeRetail(ask)[1]?.count ?? 0) * 9 <= bid) ask++;
  return { bid, ask };
}

function contract(item, direction, enchantments = 'plain', profession = 'toolsmith') {
  const commodity = (direction === 'buy' ? buy : sell)[item];
  const goldPurchase = profession === 'weaponsmith' && item === 'gold_ingot' && direction === 'buy';
  const [lot, payment] = goldPurchase ? [16, 61]
    : commodity ?? [1, toolBidAndAsk(item)[direction === 'buy' ? 'bid' : 'ask']];
  assert(payment > 0, item);
  const metal = item.endsWith('_ingot');
  const [intake, retailStock] = { armorer: [128, 16], toolsmith: [64, 32], weaponsmith: [32, 64] }[profession];
  const stock = metal ? (direction === 'buy' ? intake : retailStock) : null;
  const uses = stock ? stock / lot : !commodity ? 2 : direction === 'sell' ? 1 : null;
  const retail = direction === 'sell' && item === 'iron_ingot'
    ? [stack('emerald', 5), stack('emerald_block', 4)]
    : direction === 'sell' ? encodeRetail(payment) : null;
  const money = direction === 'sell' ? retail
    : [payment > 64 ? stack('emerald_block', payment / 9) : stack('emerald', payment)];
  return {
    item: namespace(item), direction,
    inputs: direction === 'sell' ? money : [stack(item, lot)],
    output: direction === 'sell' ? stack(item, lot) : money[0],
    enchantments, usesPerRefill: uses,
    ...(direction === 'sell' && enchantments !== 'plain'
      ? { price: 'minimum before enchantment premium', perLevelPremium: 1, treasurePremium: 4 }
      : {}),
  };
}

const group = (items, direction, enchantments, options = {}) => ({
  ...options, candidates: items.map(item => contract(item, direction, enchantments)),
});
const equipment = (materials, direction, enchantments, options) =>
  group(tools(materials), direction, enchantments, { familyWeights: 'equal', ...options });
const metal = (items, direction, options) => group(items, direction, 'plain', options);
const lateBuy = () => [
  metal(['gold_ingot', 'diamond'], 'buy'),
  equipment(['iron', 'golden'], 'buy', 'optional low-potency Basic, additional effects accepted at the same payout'),
];
const catalog = {
  version: '1.21.11',
  profession: 'minecraft:toolsmith',
  source: 'docs/discovery/drafts/trading_toolsmith_template.md',
  status: 'candidate pricing and offer pools for C02',
  sharedRules: {
    discounts: 'First-input Hero rounding. Prices and stock remain subject to integration checks.',
    axeEnchantments: ['efficiency', 'unbreaking', 'fortune', 'silk_touch', 'mending'].map(namespace),
    axeIncompatibility: ['fortune', 'silk_touch'].map(namespace),
    enchantmentStages: {
      Journeyman: { count: [1, 2], potency: 'low', categories: ['Basic', 'Situational'] },
      Expert: { count: [2, 4], potency: 'medium', categories: ['Basic', 'Advanced', 'Situational'] },
      Master: { count: [2, 4], potency: 'high', categories: ['Basic', 'Advanced', 'Treasure'], situationalMayAccompany: true, maxTreasure: 1 },
    },
  },
  stages: [
    { name: 'Novice', sales: [{ draws: 2, distinctBy: 'family', groups: [equipment(ordinary, 'sell', 'plain')] }],
      purchases: [{ draws: 1, groups: [metal(['flint'], 'buy')] }, { draws: 1, groups: [metal(['coal', 'charcoal'], 'buy')] }] },
    { name: 'Apprentice', sales: [{ draws: 1, exclude: 'exact family and material selected at Novice', groups: [equipment(ordinary, 'sell', 'plain')] }],
      purchases: [{ draws: 1, exclude: 'fuel selected at Novice', groups: [metal(['coal', 'charcoal', 'copper_ingot', 'iron_ingot'], 'buy')] }] },
    { name: 'Journeyman', sales: [{ draws: 1, groups: [equipment([...ordinary, 'golden'], 'sell', 'few low-potency enchantments')] }],
      purchases: [{ draws: 1, exclude: 'iron ingot if selected at Apprentice', groups: [
        metal(['iron_ingot', 'gold_ingot'], 'buy'), equipment(ordinary, 'buy', 'plain'),
      ] }] },
    { name: 'Expert', sales: [{ draws: 1, groups: [
      equipment(['iron', 'golden', 'diamond'], 'sell', 'some medium-potency enchantments'),
      metal(['copper_ingot', 'iron_ingot', 'gold_ingot'], 'sell'),
    ] }], purchases: [{ draws: 1, groups: lateBuy() }] },
    { name: 'Master', sales: [{ draws: 1, groups: [
      metal(['netherite_scrap'], 'sell', { chance: 5 }),
      metal(['diamond'], 'sell', { chance: 15 }),
      equipment(['diamond', 'netherite'], 'sell', 'some high-potency enchantments', {
        chance: 80, materialChances: { diamond: 95, netherite: 5 },
      }),
    ] }], purchases: [{ draws: 1, exclude: 'option selected at Expert (contract granularity pending)', groups: lateBuy() }] },
  ],
};

function smithCatalog(profession) {
  const armorer = profession === 'armorer';
  const types = armorer ? ['helmet', 'chestplate', 'leggings', 'boots'] : ['sword', 'spear'];
  const options = (items, direction, enchantments = 'plain', rules = {}) => ({
    ...rules, candidates: items.map(item => contract(item, direction, enchantments, profession)),
  });
  const gear = (materials, direction, enchantments, rules) =>
    options(types.flatMap(type => materials.map(material => material + '_' + type)), direction, enchantments, rules);
  const animal = (materials, rules) => options(
    materials.flatMap(material => [material + '_horse_armor', material + '_nautilus_armor']), 'sell', 'plain', rules);
  const slot = (groups, rules = {}) => ({ draws: 1, groups, ...rules });
  const late = () => slot([options(['gold_ingot', 'diamond'], 'buy'),
    gear(['iron', 'golden'], 'buy', 'optional low-potency Basic, additional effects accepted at the same payout')]);
  return {
    version: catalog.version, profession: namespace(profession),
    source: 'docs/discovery/drafts/trading_profession_catalog_draft.md#' + profession,
    status: catalog.status,
    sharedRules: {
      ...Object.fromEntries(Object.entries(catalog.sharedRules).filter(([key]) => !key.startsWith('axe'))),
      ...(armorer ? {
        purchaseHistory: 'Exclude prior purchase options through Expert. Master excludes the Expert option.',
        playerArmor: 'Swift Sneak on leggings and Soul Speed on boots from Journeyman, within stage potency.',
      } : {
        familyWeights: 'Sword and Spear are equally weighted when both are eligible.',
        purchaseDurability: 'full',
        masterSwordMendingChance: 2.5,
      }),
    },
    stages: [
      { name: 'Novice', sales: armorer
        ? [slot([gear(ordinary, 'sell')], { draws: 2, distinctBy: 'body slot' })]
        : types.map(type => slot([options(ordinary.map(material => material + '_' + type), 'sell')])),
      purchases: armorer
        ? [slot([options(['coal', 'charcoal'], 'buy')]), slot([options(['copper_ingot', 'iron_ingot'], 'buy')])]
        : [slot([options(['flint'], 'buy')]), slot([options(['coal', 'charcoal'], 'buy')])] },
      { name: 'Apprentice', sales: [slot([gear(ordinary, 'sell')], {
        exclude: armorer ? 'exact Novice piece; the same body slot may repeat in a different material' : 'the Novice material for the same family',
      })], purchases: [slot([options(armorer
        ? ['leather', 'coal', 'charcoal', 'copper_ingot', 'iron_ingot']
        : ['coal', 'charcoal', 'copper_ingot', 'iron_ingot'], 'buy')], { exclude: 'options selected at Novice' })] },
      { name: 'Journeyman', sales: [slot([
        gear([...ordinary, 'golden'], 'sell', 'few low-potency enchantments'),
        ...(armorer ? [options(['copper_ingot', 'iron_ingot', 'gold_ingot'], 'sell')] : []),
      ])], purchases: [slot([options(['iron_ingot', 'gold_ingot'], 'buy'), gear(ordinary, 'buy')], {
        exclude: armorer ? 'options selected before Journeyman' : 'Iron Ingot if selected at Apprentice',
      })] },
      { name: 'Expert', sales: [slot([gear(['iron', 'golden', 'diamond'], 'sell', 'some medium-potency enchantments'),
        armorer ? animal(ordinary) : options(['copper_ingot', 'iron_ingot', 'gold_ingot'], 'sell')])],
      purchases: [{ ...late(), ...(armorer ? { exclude: 'options selected before Expert' } : {}) }] },
      { name: 'Master', sales: [slot([
        options(['netherite_scrap'], 'sell', 'plain', { chance: 5 }),
        options(['diamond'], 'sell', 'plain', { chance: 15 }),
        ...(armorer ? [
          gear(['diamond', 'netherite'], 'sell', 'some high-potency enchantments', {
            chance: 56, materialChances: { diamond: 95, netherite: 5 },
          }),
          options(['golden_horse_armor', 'diamond_horse_armor'], 'sell', 'plain', { chance: 12 }),
          options(['golden_nautilus_armor', 'diamond_nautilus_armor'], 'sell', 'plain', { chance: 12 }),
        ] : [gear(['diamond', 'netherite'], 'sell', 'some high-potency enchantments', {
          chance: 80, materialChances: { diamond: 95, netherite: 5 },
        })]),
      ])], purchases: [{ ...late(), exclude: 'contract selected at Expert' }] },
    ],
  };
}

const stagesByName = ['Novice', 'Apprentice', 'Journeyman', 'Expert', 'Master'];
const variantPrices = {
  village: 12, shipwreck: 12, ruined_portal: 16, buried_treasure: 16,
  ocean_monument: 24, trial_chambers: 24, woodland_mansion: 32, ancient_city: 32,
};
const saplingPrices = {
  common_sapling: [6, 0], rare_sapling: [10, 4], treasure_sapling: [16, 7],
};
const pricesByDirection = {
  sell: new Map(retailQuotes.map(quote => [quote.item, quote])),
  buy: new Map(purchaseQuotes.map(quote => [quote.item, quote])),
};
// The shared ordinary quote precedes the separate Master dye quote in the price input.
for (const quote of retailQuotes.filter(quote => quote.item.endsWith('_dye') && quote.lot === 8)) {
  pricesByDirection.sell.set(quote.item, quote);
}
const consumableUses = { cooked_cod: 4, cooked_salmon: 4, ender_eye: 2, tipped_arrow: 2 };
const potency = {
  journeyman: { base: 8, perLevel: 4 },
  expert: { base: 12, perLevel: 5 },
  treasure: { base: 24, perLevel: 6 },
};
const masonSherds = [...matrix.keys()].filter(item => item.endsWith('_pottery_sherd'));
assert(masonSherds.length > 0);

function generalContract(key, direction, rules, profession) {
  const [item, variant] = key.split('/');
  if (item === 'pending' || variant === 'remaining') {
    return { item: item === 'pending' ? null : namespace(item), direction, variant, pending: true };
  }
  const gameItem = namespace(item);
  let quote = pricesByDirection[direction].get(gameItem);
  const fixed = (lot, payment) => direction === 'sell'
    ? { lot, emeralds: payment, blocks: 0 }
    : { lot, payout: payment };
  if (variant && item === 'filled_map') quote = fixed(1, variantPrices[variant]);
  if (variant && item === 'tipped_arrow') quote = fixed(8, direction === 'sell' ? 23 : 5);
  if (variant && item === 'enchanted_book') quote = fixed(1, potency[variant].base + potency[variant].perLevel);
  if (item.endsWith('_pottery_sherd') || item === 'pottery_sherd') quote = fixed(1, 4);
  if (item === 'decorated_pot') quote = fixed(1, 37);
  if (rules.rarity && item.startsWith('music_disc_')) {
    quote = fixed(1, { common: 24, uncommon: 32, rare: 40 }[rules.rarity]);
  }
  if (rules.quote === 'master_dye') quote = fixed(10, item === 'black_dye' ? 23 : 9);
  if (saplingPrices[rules.family]) {
    const [retail, payout] = saplingPrices[rules.family];
    quote = fixed(direction === 'sell' ? 4 : 8, direction === 'sell' ? retail : payout);
  }
  if (!quote && /^leather_(helmet|chestplate|leggings|boots)$/.test(item)) {
    const { bid, ask } = toolBidAndAsk(item);
    quote = fixed(1, direction === 'sell' ? ask : bid);
  }
  assert(quote && Number.isFinite(quote.lot), profession + ': missing ' + direction + ' quote for ' + key);
  const money = direction === 'sell'
    ? [stack('emerald', quote.emeralds), ...(quote.blocks ? [stack('emerald_block', quote.blocks)] : [])]
    : [quote.payout > 64 ? stack('emerald_block', quote.payout / 9) : stack('emerald', quote.payout)];
  const approvedEquipment = direction === 'buy' && professionPools[profession]?.rules.purchasesAtFullDurability?.includes(item);
  const gear = rules.enchantments && rules.enchantments !== 'plain' && item !== 'enchanted_book';
  return {
    item: gameItem, ...(variant ? { variant } : {}), direction,
    inputs: direction === 'sell' ? money : [stack(item, quote.lot)],
    output: direction === 'sell' ? stack(item, quote.lot) : money[0],
    enchantments: approvedEquipment ? 'optional low-potency Basic; additional effects accepted at the same payout'
      : rules.enchantments ?? 'plain',
    ...(approvedEquipment || rules.durability ? { durability: approvedEquipment ? 'full' : rules.durability } : {}),
    ...(item === 'filled_map' ? {
      resolveDestination: true,
      lootTable: 'iota_trades:explorer/' + variant,
      structure: explorerMaps[variant].target,
      requireComponents: ['minecraft:map_id', 'minecraft:map_decorations'],
    } : {}),
    ...(variant && item === 'enchanted_book' ? { price: 'depends on enchantment level', priceFormula: potency[variant] } : {}),
    ...(direction === 'sell' && gear ? { price: 'minimum before enchantment premium', perLevelPremium: 1, treasurePremium: 4 } : {}),
    usesPerRefill: direction === 'buy' ? consumableUses[item] ?? null : gear ? 2 : null,
  };
}

function convertPool(pool, direction, profession) {
  const { items, groups, ...rules } = pool;
  if (groups) return { ...rules, groups: groups.map(group => convertPool(group, direction, profession)) };
  const keys = items.flatMap(key => key === 'pottery_sherd/all' && masonSherds.length ? masonSherds : [key]);
  return { ...rules, candidates: keys.map(key => generalContract(key, direction, rules, profession)) };
}

function otherCatalog(profession, definition) {
  return {
    version: catalog.version, profession: namespace(profession),
    source: 'docs/discovery/drafts/trading_profession_catalog_draft.md#' + profession,
    status: catalog.status, sharedRules: definition.rules,
    stages: definition.stages.map((stage, index) => ({
      name: stagesByName[index],
      ...Object.fromEntries([['sales', 'sell'], ['purchases', 'buy']].map(([key, direction]) => [
        key, stage[key].map(slot => {
          const { items, groups, ...rules } = slot;
          return { ...rules, groups: (groups ?? [{ items }]).map(group => convertPool(group, direction, profession)) };
        }),
      ])),
    })),
  };
}

const catalogs = [catalog, smithCatalog('armorer'), smithCatalog('weaponsmith'),
  ...Object.entries(professionPools).map(([profession, definition]) => otherCatalog(profession, definition))];
const allCandidates = group => group.candidates ?? group.groups.flatMap(allCandidates);
const expectedDraws = { toolsmith: 12, armorer: 12, weaponsmith: 12, fletcher: 12, leatherworker: 13,
  farmer: 16, butcher: 12, fisherman: 14, shepherd: 10, librarian: 14, cartographer: 13, cleric: 12, mason: 16 };
const candidatesByCatalog = catalogs.map(entry => {
  const profession = entry.profession.split(':')[1];
  const slots = entry.stages.flatMap(stage => [...stage.sales, ...stage.purchases]);
  for (const saleGroup of entry.sharedRules.persistentSaleGroups ?? [undefined]) {
    assert.equal(slots.filter(slot => !slot.requiresSaleGroup || slot.requiresSaleGroup === saleGroup)
      .reduce((sum, slot) => sum + slot.draws, 0), expectedDraws[profession], profession);
  }
  return slots.flatMap(slot => slot.groups.flatMap(allCandidates));
});
const candidates = candidatesByCatalog.flat();
assert(candidatesByCatalog[0].every(candidate => candidate.direction !== 'sell' || candidate.item !== 'minecraft:flint'));
assert(candidates.every(candidate => candidate.pending || matrix.has(candidate.item.replace('minecraft:', ''))));
const unitValue = item => item.count * (item.item === 'minecraft:emerald_block' ? 9 : 1);
let resaleChecks = 0;
for (const sale of candidates.filter(candidate => candidate.direction === 'sell' && !candidate.pending)) {
  for (const purchase of candidates.filter(candidate => candidate.direction === 'buy' && !candidate.pending
    && candidate.item === sale.item && candidate.variant === sale.variant)) {
    for (let hero = 0; hero <= 5; hero++) {
      const ask = unitValue({ ...sale.inputs[0], count: heroInput(sale.inputs[0].count, hero) })
        + (sale.inputs[1] ? unitValue(sale.inputs[1]) : 0);
      const input = heroInput(purchase.inputs[0].count, hero);
      assert(ask * input > unitValue(purchase.output) * sale.output.count, sale.item + ' Hero ' + hero);
      resaleChecks++;
    }
  }
}

let sampleState = 0x318becc3;
const previewRandom = () => {
  sampleState = (Math.imul(sampleState, 1664525) + 1013904223) >>> 0;
  return sampleState / 2 ** 32;
};
let enchantmentSamples = 0;
for (const entry of catalogs) {
  for (const stage of entry.stages) {
    for (const candidate of stage.sales.flatMap(slot => slot.groups.flatMap(allCandidates))) {
      if (candidate.pending || !candidate.price) continue;
      const book = candidate.item === 'minecraft:enchanted_book';
      const specialties = book && candidate.variant === 'treasure'
        ? Object.entries(entry.sharedRules.treasureSpecialty.biomes) : [[null, null]];
      candidate.enchantmentExamples = specialties.map(([villagerType, specialty]) => {
        const enchantments = book ? rollBook(candidate.variant, specialty, previewRandom)
          : rollEquipment(candidate.item, stage.name, previewRandom);
        const total = book ? candidate.priceFormula.base + candidate.priceFormula.perLevel * Object.values(enchantments)[0]
          : candidate.inputs.reduce((sum, stack) => sum + unitValue(stack), 0) + enchantmentPremium(enchantments);
        enchantmentSamples++;
        return { ...(villagerType ? { villagerType } : {}), enchantments, inputs: encodeRetail(total) };
      });
    }
  }
}

const escape = text => String(text).replace(/[&<>"]/g, char => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[char]);
const formatStack = ({ item, count }) => count + ' × ' + item.replace('minecraft:', '').replaceAll('_', ' ');
const titleCase = name => name[0].toUpperCase() + name.slice(1);

function previewGroup(group) {
  const label = [
    group.chance === undefined ? '' : group.chance + '%',
    group.family?.replaceAll('_', ' '),
    group.weight === undefined ? '' : 'Weight ' + group.weight,
    group.materialChances ? 'Diamond 95% / Netherite 5% within equipment' : '',
    group.exclude ? 'Exclude ' + group.exclude : '',
  ].filter(Boolean).join(' · ');
  const heading = label ? '<tr><th colspan="4">' + escape(label) + '</th></tr>' : '';
  if (group.groups) return heading + group.groups.map(previewGroup).join('');
  const rows = group.candidates.map(candidate => {
    if (candidate.pending) return '<tr><td colspan="4">' + escape(candidate.variant === 'remaining'
      ? 'Reuse the remaining book candidate' : 'Purchase eligibility pending') + '</td></tr>';
    const payment = escape(candidate.inputs.map(formatStack).join(' + '));
    const variant = candidate.variant ? ' · ' + escape(candidate.variant.replaceAll('_', ' ')) : '';
    const quantity = escape(formatStack(candidate.output)) + variant;
    const samples = candidate.enchantmentExamples?.map(example =>
      '<div>' + (example.villagerType ? escape(example.villagerType) + ' · ' : '')
      + escape(Object.entries(example.enchantments).map(([id, level]) =>
        id.replace('minecraft:', '').replaceAll('_', ' ') + ' ' + level).join(', '))
      + ' · ' + escape(example.inputs.map(formatStack).join(' + ')) + '</div>').join('') ?? '';
    return '<tr><td>' + payment + (candidate.price ? ' (' + escape(candidate.price) + ')' : '')
      + '</td><td>' + quantity + '</td><td>' + escape(candidate.enchantments)
      + (candidate.durability === 'full' ? ' · Full durability' : '')
      + (samples ? '<details><summary>Example rolls</summary>' + samples + '</details>' : '')
      + '</td><td>' + (candidate.usesPerRefill ?? 'Pending') + '</td></tr>';
  });
  return heading + rows.join('');
}

function writeCatalog(entry, index) {
  const profession = entry.profession.replace('minecraft:', '');
  const title = titleCase(profession);
  const plan = planOffers(entry, { random: previewRandom });
  assert.equal(plan.offers.length, expectedDraws[profession]);
  const examplePlan = '<details><summary>Example career plan</summary><ol>'
    + plan.offers.map(({ stage, offer, pending }) => '<li>' + escape(stage) + ' · '
      + (offer ? escape(offer.inputs.map(formatStack).join(' + ') + ' → ' + formatStack(offer.output)
          + (offer.variant ? ' · ' + offer.variant.replaceAll('_', ' ') : ''))
        : escape(pending))
      + '</li>').join('') + '</ol></details>';
  const stages = entry.stages.map(stage =>
    '<section><h2>' + stage.name + '</h2>' + [stage.sales, stage.purchases].map((slots, index) =>
      '<h3>' + (index ? 'Purchases' : 'Sales') + '</h3>' + slots.map(slot =>
        '<p>Draw ' + slot.draws + (slot.distinctBy ? ' with distinct ' + slot.distinctBy : '')
      + (slot.exclude ? '. Exclude ' + escape(slot.exclude) : '')
      + (slot.requiresSaleGroup ? ' · ' + escape(slot.requiresSaleGroup) : '') + '.</p>'
        + '<table><thead><tr><th>Input</th><th>Output</th><th>Enchantments</th><th>Uses per refill</th></tr></thead><tbody>'
        + slot.groups.map(previewGroup).join('') + '</tbody></table>').join('')).join('') + '</section>').join('');
  const html = '<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width">'
    + '<title>Iota ' + title + ' offers</title><style>body{max-width:72rem;margin:auto;padding:2rem;font:16px/1.5 system-ui;color:#202823;background:#f5f5ef}'
    + 'table{border-collapse:collapse;width:100%;margin-bottom:1.5rem;background:#fff}td,th{text-align:left;padding:.5rem;border-bottom:1px solid #ddd}'
    + 'thead th{background:#e3e9df}section{margin-block:2rem}h2{border-bottom:2px solid #526550}</style>'
    + '<main><a href="trading_catalog_previews.html">All professions</a><h1>' + title
    + ' offers</h1><p>Candidate prices and stock for Minecraft Java ' + entry.version + '</p>'
    + '<details><summary>Profession rules</summary><pre>' + escape(JSON.stringify(entry.sharedRules, null, 2))
    + '</pre></details>' + examplePlan + stages + '</main></html>\n';

  fs.writeFileSync(path.join(output, 'trading_' + profession + '_catalog.json'),
    JSON.stringify({ ...entry, examplePlan: plan }, null, 2) + '\n');
  fs.writeFileSync(path.join(output, 'trading_' + profession + '_preview.html'), html);
  return { profession, stages: entry.stages.length, draws: expectedDraws[profession], candidateRows: candidatesByCatalog[index].length };
}
const summaries = catalogs.map(writeCatalog);
const index = '<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width">'
  + '<title>Iota Trading catalogs</title><style>body{max-width:40rem;margin:auto;padding:2rem;font:16px/1.6 system-ui;background:#f5f5ef}'
  + 'li{margin-block:.4rem}</style><main><h1>Iota Trading catalogs</h1><p>Minecraft Java 1.21.11 · Candidate prices and stock</p><ul>'
  + summaries.map(({ profession, draws }) => '<li><a href="trading_' + profession + '_preview.html">'
    + titleCase(profession) + '</a> · ' + draws + ' offers by Master'
    + ' · <a href="trading_' + profession + '_catalog.json">JSON</a></li>').join('')
  + '</ul></main></html>\n';
fs.writeFileSync(path.join(output, 'trading_catalog_previews.html'), index);
console.log(JSON.stringify({ catalogs: summaries, resaleChecks, enchantmentSamples }));
