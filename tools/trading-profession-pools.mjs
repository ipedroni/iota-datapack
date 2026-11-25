const words = text => text.split(' ');
const common = words('white orange magenta light_blue yellow lime pink gray light_gray cyan purple red');
const uncommon = words('brown green blue black');
const colored = (colors, item) => colors.map(color => color + '_' + item);
const slot = (items, draws = 1, rules = {}) => ({ items: typeof items === 'string' ? words(items) : items, draws, ...rules });
const group = (items, rules = {}) => ({ items: typeof items === 'string' ? words(items) : items, ...rules });
const grouped = (groups, draws = 1, rules = {}) => ({ groups, draws, ...rules });
const stage = (sales, purchases) => ({ sales, purchases });
const history = 'Exclude previous exact offers in the same direction';
const regularArrows = words('tipped_arrow/slowness tipped_arrow/weakness');
const earlyArrows = ['spectral_arrow', ...regularArrows];
const arrows = [...earlyArrows, 'tipped_arrow/poison', 'tipped_arrow/harming'];
const basic = 'optional low-potency Basic; additional effects accepted at the same payout';
const rod = (chance, enchantments) => group('fishing_rod', { chance, enchantments });
const weapons = (enchantments, rules = {}) => group('bow crossbow', { familyWeights: 'equal', enchantments, ...rules });
const dye = (colors, rules = {}) => group(colored(colors, 'dye'), { family: 'dye', ...rules });
const saplings = {
  common: words('oak_sapling birch_sapling spruce_sapling'),
  rare: words('acacia_sapling jungle_sapling dark_oak_sapling'),
  treasure: words('cherry_sapling pale_oak_sapling mangrove_propagule'),
};
const sapling = rarity => group(saplings[rarity], { family: rarity + '_sapling' });
const leather = words('leather_helmet leather_chestplate leather_leggings leather_boots');
const leatherMaterials = words('rotten_flesh leather string rabbit_hide');
const leatherAccessory = words('bundle lead');
const animalLeather = words('leather_horse_armor wolf_armor');
const leatherHighBuy = [group(leather, { enchantments: basic, durability: 'full' }), dye([...common, ...uncommon])];
const farmerBuys = [group('apple wheat beetroot carrot potato bread pumpkin_seeds melon_seeds'), sapling('rare')];
const farmerMid = [group('pumpkin_seeds melon_seeds honey_bottle cocoa_beans pitcher_pod'), sapling('treasure')];
const butcherLow = 'wheat wheat_seeds carrot potato beetroot iron_axe';
const butcherMid = 'bread apple honey_bottle egg milk_bucket coal charcoal paper string';
const rawMeat = 'chicken porkchop beef mutton';
const butcherSale = rawMeat + ' bone leather rabbit_hide';
const fishGear = 'bucket shears fishing_rod';
const fishGoods = 'string cod salmon kelp seagrass lily_pad ink_sac';
const fishBaseBuy = 'stick string kelp seagrass iron_nugget bread';
const fishBuckets = 'cod_bucket salmon_bucket pufferfish_bucket tropical_fish_bucket';
const fishMid = fishBuckets + ' prismarine_shard prismarine_crystals turtle_scute nautilus_shell';
const fishHigh = fishMid + ' axolotl_bucket turtle_egg heart_of_the_sea';
const fishHighBuy = 'turtle_scute nautilus_shell turtle_egg seagrass iron_nugget bread prismarine_shard prismarine_crystals heart_of_the_sea';
const wool = (colors, rules = {}) => group(colored(colors, 'wool'), { family: 'wool', ...rules });
const harness = colors => group(colored(colors, 'harness'), { family: 'harness' });
const shepherdLowBuy = [group('string leather honeycomb wheat shears'), dye(uncommon)];
const shepherdHighBuy = [dye([...common, ...uncommon]), group('hay_block painting')];
const librarianLowBuy = 'paper book feather ink_sac glow_ink_sac black_dye leather';
const librarianMidBuy = 'leather lapis_lazuli gold_nugget amethyst_shard';
const librarianHighBuy = librarianMidBuy + ' echo_shard';
const discs = (rarity, list) => group(words(list).map(disc => 'music_disc_' + disc), { family: 'music_disc', rarity });
const book = (key, enchantments) => group('enchanted_book/' + key, { enchantments });
const ordinaryBook = book('expert', 'one high-potency Basic, Advanced or Situational effect');
const treasureBook = book('treasure', 'one medium- or high-potency Treasure effect');
const cartLow = 'paper ink_sac black_dye feather';
const cartHigh = cartLow + ' compass clock amethyst_shard copper_nugget iron_nugget gold_nugget redstone chorus_fruit quartz';
const map = (destinations, rules = {}) => group(words(destinations).map(destination => 'filled_map/' + destination), rules);
const clericLow = 'candle lantern sugar gunpowder redstone spider_eye slime_ball glass_bottle';
const clericBuy = 'rotten_flesh bone paper feather string honeycomb black_dye ink_sac';
const clericHigh = 'ender_pearl quartz blaze_powder magma_cream phantom_membrane';
const stoneStarter = 'flint clay_ball clay sand gravel brick nether_brick';
const ceramicStarter = 'clay_ball clay brick nether_brick flower_pot decorated_pot';
const stoneLow = 'stone smooth_stone sandstone bricks mud_bricks nether_bricks';
const stoneMid = 'polished_andesite polished_diorite polished_granite polished_deepslate polished_tuff calcite';
const ceramic = (colors, plain = false) => words('stained_glass terracotta glazed_terracotta concrete').map(family => group([
  ...colored(colors, family), ...(plain && family === 'stained_glass' ? ['glass'] : []),
  ...(plain && family === 'terracotta' ? ['terracotta'] : []),
], { family }));
const masonLowBuy = [group('clay_ball wheat iron_nugget copper_nugget gunpowder'), dye(common)];
const masonHighBuy = [...masonLowBuy.slice(0, 1), group('quartz prismarine_shard'), dye([...common, ...uncommon]), group('pottery_sherd/all', { family: 'pottery_sherd' })];
const specialty = (pool, groups, draws = 1) => grouped(groups, draws, { requiresSaleGroup: pool });

export const professionPools = {
  fletcher: {
    rules: { arrows: 'Exclude each arrow variant from later draws in the same direction', purchaseDurability: 'full',
      masterCrossbowMendingChance: 2.5, incompatibilities: 'Multishot/Piercing and Infinity/Mending' },
    stages: [
      stage([slot('arrow'), grouped([weapons('plain')])], [slot('feather string flint stick', 2)]),
      stage([grouped([weapons('plain', { exclude: 'Novice weapon' }), group(regularArrows)])], [slot('feather string flint stick', 1, { exclude: 'Novice purchases' })]),
      stage([grouped([weapons('few low-potency enchantments'), group(earlyArrows)])], [grouped([weapons('plain'), group(earlyArrows)])]),
      stage([grouped([weapons('some medium-potency enchantments'), group(arrows)])], [grouped([weapons(basic), group(arrows)])]),
      stage([grouped([weapons('some high-potency enchantments')])], [grouped([weapons(basic), group(arrows)], 1, { exclude: 'Expert contract' })]),
    ],
  },
  leatherworker: {
    rules: { saleHistory: history, dyePurchases: 'From Journeyman onward exclude every previously purchased dye color',
      journeymanSaleWeights: { leather: 2, rabbit_hide: 2, dyeGroup: 1 } },
    stages: [
      stage([slot(leather, 2)], [slot(leatherMaterials, 2)]),
      stage([grouped([group(leather), dye(common), group(leatherAccessory)], 2)], [grouped([group(leatherMaterials, { exclude: 'Novice purchases' }), dye([...common, ...uncommon])])]),
      stage([grouped([group([...leather, ...leatherAccessory]), group('leather', { weight: 2 }),
        group('rabbit_hide', { weight: 2 }), dye(common, { weight: 1 })])],
        [grouped([group(leatherMaterials, { exclude: 'previous purchases' }),
          group(leather, { enchantments: 'plain', durability: 'full' }), dye([...common, ...uncommon])])]),
      stage([grouped([group([...animalLeather, 'leather', 'rabbit_hide', 'saddle']), harness(common)])], [grouped(leatherHighBuy)]),
      stage([grouped([dye(uncommon, { quote: 'master_dye' }), group([...animalLeather, 'saddle']), harness(uncommon)])],
        [grouped(leatherHighBuy, 1, { exclude: 'Expert contract' })]),
    ],
  },
  farmer: {
    rules: { history },
    stages: [
      stage([grouped([group('wheat_seeds beetroot_seeds wheat apple carrot potato'), sapling('common'), sapling('rare')], 4)], [grouped(farmerBuys, 2)]),
      stage([grouped([group('wheat apple carrot potato'), sapling('common'), sapling('rare')], 2)], [grouped(farmerBuys, 2)]),
      stage([grouped(farmerMid)], [grouped([group('pumpkin_seeds melon_seeds cocoa_beans hay_block'), sapling('treasure')])]),
      stage([grouped(farmerMid)], [grouped([group('hay_block cake pumpkin_pie pitcher_pod torchflower_seeds'), sapling('treasure')])]),
      stage([grouped([group('sniffer_egg', { chance: 5 }), group('golden_apple golden_carrot honey_bottle torchflower_seeds', { chance: 95 })])],
        [slot('cake pumpkin_pie pitcher_pod torchflower_seeds')]),
    ],
  },
  butcher: {
    rules: { history, purchasesAtFullDurability: ['iron_axe'] },
    stages: [
      stage([slot(rawMeat, 2)], [slot(butcherLow, 2)]),
      stage([slot(butcherSale)], [slot(butcherLow + ' paper string')]),
      stage([slot(butcherSale)], [slot(butcherMid)]),
      stage([slot('cooked_chicken cooked_mutton cooked_rabbit')], [slot(butcherMid)]),
      stage([slot('cooked_beef cooked_porkchop rabbit_stew')], [slot(butcherMid)]),
    ],
  },
  fisherman: {
    rules: { history, rodIdentity: 'Plain, low and high potency are distinct offers',
      purchasesAtFullDurability: ['leather_boots', 'iron_shovel', 'shears'] },
    stages: [
      stage([slot(fishGear), slot(fishGoods)], [slot(fishBaseBuy, 2)]),
      stage([slot(fishGear), slot(fishGoods)], [slot(fishBaseBuy + ' bucket iron_shovel leather_boots shears', 2)]),
      stage([grouped([rod(25, 'few low-potency enchantments'), group(fishMid, { chance: 75, weights: 'equal' })])],
        [slot('iron_nugget bread honeycomb glass_bottle cooked_cod cooked_salmon prismarine_shard prismarine_crystals')]),
      stage([slot(fishHigh, 1, { weights: 'equal' })], [slot(fishHighBuy)]),
      stage([grouped([rod(25, 'some high-potency enchantments'), group(words(fishHigh).slice(2), { chance: 75 })])], [slot(fishHighBuy)]),
    ],
  },
  shepherd: {
    rules: { history, coloredItems: 'Draw the group before the eligible color; history applies to the exact item and color' },
    stages: [
      stage([grouped([wool(common, { conditionalColorChances: { white: 50, otherCommon: 50 } }), group('shears')])], [grouped(shepherdLowBuy)]),
      stage([grouped([wool(common), dye(common), group('shears')])], [grouped(shepherdLowBuy)]),
      stage([grouped([wool([...common, ...uncommon]), dye([...common, ...uncommon]), group('painting shears')])],
        [grouped([group('leather honeycomb wheat hay_block shears'), dye([...common, ...uncommon])])]),
      stage([grouped([wool(uncommon), dye(uncommon), group('painting shears'), harness(common)])], [grouped(shepherdHighBuy)]),
      stage([grouped([wool(uncommon), dye(uncommon), harness(uncommon)])], [grouped(shepherdHighBuy)]),
    ],
  },
  librarian: {
    rules: { history, bookIdentity: 'Enchantment and level', treasureSpecialty: {
      chance: 75, otherTreasureChance: 25, biomes: {
        desert: ['infinity', 1, 1], jungle: ['feather_falling', 2, 4], plains: ['channeling', 1, 1],
        savanna: ['lunge', 2, 3], snow: ['frost_walker', 1, 2], swamp: ['mending', 1, 1], taiga: ['silk_touch', 1, 1],
      },
    } },
    stages: [
      stage([slot('paper book'), slot('ink_sac black_dye')], [slot(librarianLowBuy, 2)]),
      stage([grouped([group('paper book name_tag clock compass experience_bottle'),
        discs('common', '13 cat blocks chirp far mall mellohi stal strad ward 11 wait'),
        discs('uncommon', 'otherside relic precipice lava_chicken')], 2)], [slot(librarianLowBuy)]),
      stage([grouped([book('journeyman', 'one low-potency Basic or low- to medium-potency Situational effect')])], [slot(librarianMidBuy)]),
      stage([grouped([ordinaryBook])], [slot(librarianHighBuy)]),
      stage([grouped([ordinaryBook, treasureBook], 1, { saveRemainingCandidate: true }),
        grouped([group('enchanted_book/remaining', { reuseRemainingCandidate: true }),
          discs('rare', '5 pigstep creator creator_music_box tears'), group('echo_shard')])], [slot(librarianHighBuy)]),
    ],
  },
  cartographer: {
    rules: { history, mapIdentity: 'Destination type',
      mapResolution: { requireLocatedDestination: true, drawFromLocatedCandidatesOnly: true, noEligibleDestination: 'leave slot pending' } },
    stages: [
      stage([slot('map'), slot('clock compass', 1, { weights: 'equal' })], [slot(cartLow, 2)]),
      stage([slot('clock compass', 1, { exclude: 'Novice tool' }), grouped([map('village shipwreck')])], [slot(cartLow)]),
      stage([grouped([group('spyglass', { chance: 25 }), map('shipwreck ruined_portal buried_treasure', { chance: 75 })])], [slot(cartHigh)]),
      stage([grouped([map('ocean_monument trial_chambers')])], [slot(cartHigh)]),
      stage([grouped([map('woodland_mansion ancient_city')])], [slot(cartHigh)]),
    ],
  },
  cleric: {
    rules: { history },
    stages: [
      stage([slot(clericLow, 2)], [slot(clericBuy, 2)]),
      stage([slot(clericLow)], [slot(clericBuy)]),
      stage([slot(clericLow)], [slot('glass_bottle spider_eye gunpowder redstone slime_ball')]),
      stage([slot('blaze_powder glowstone_dust ender_pearl nether_wart magma_cream quartz')], [slot(clericHigh)]),
      stage([slot('blaze_powder glowstone_dust ender_pearl phantom_membrane ghast_tear wither_skeleton_skull')],
        [slot('ghast_tear ender_eye wither_skeleton_skull ' + clericHigh)]),
    ],
  },
  mason: {
    rules: { history, persistentSaleGroups: ['stonemason', 'ceramist'], groupWeights: { stonemason: 50, ceramist: 50 } },
    stages: [
      stage([specialty('stonemason', [group(stoneStarter)], 2), specialty('stonemason', [group(stoneLow)], 2),
        specialty('ceramist', [group(ceramicStarter)], 2), specialty('ceramist', ceramic(common, true), 2)], [grouped(masonLowBuy, 2)]),
      stage([specialty('stonemason', [group(stoneStarter)]), specialty('stonemason', [group(stoneLow)]),
        specialty('ceramist', [group(ceramicStarter)]), specialty('ceramist', ceramic(common, true))], [grouped(masonLowBuy, 2)]),
      stage([specialty('stonemason', [group(stoneMid)]), specialty('ceramist', ceramic(uncommon))], [grouped(masonHighBuy)]),
      stage([specialty('stonemason', [group(stoneMid)]), specialty('ceramist', [
        group('lantern copper_lantern redstone_lamp', { chance: 60 }), { chance: 40, groups: ceramic(uncommon) },
      ])], [grouped(masonHighBuy)]),
      stage([specialty('stonemason', [group('smooth_quartz end_stone blackstone prismarine dark_prismarine obsidian')]),
        specialty('ceramist', [{ chance: 50, groups: [group('soul_lantern'), group('ochre_froglight verdant_froglight pearlescent_froglight', { family: 'froglight' })] },
          group('lantern copper_lantern redstone_lamp', { chance: 35 }), { chance: 15, groups: ceramic(uncommon) }])], [grouped(masonHighBuy)]),
    ],
  },
};
