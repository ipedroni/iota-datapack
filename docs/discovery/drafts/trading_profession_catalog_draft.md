# Profession catalogs — current working candidates

Minecraft Java 1.21.11. See [shared Trading rules](trading_design_directions.md) and the [Toolsmith template](trading_toolsmith_template.md). These are design choices for the five-level redesign. Candidate rows remain open until reviewed.

See the [shared Expert ingot alternative and stock calibration](trading_design_directions.md#working-price-and-stock-calibration).




## Armorer

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Two Copper/Iron pieces for different body slots | Candidate: one of Coal/Charcoal and one of Copper/Iron Ingots |
| Apprentice | One unenchanted Copper/Iron piece. A Novice body slot may repeat in a different material. | Leather or one material skipped at Novice |
| Journeyman | One Copper, Iron or Gold piece with a few low-potency enchantments | Candidate: Iron/Gold Ingots or one unenchanted Copper/Iron piece. Exclude Iron Ingots if selected at Novice or Apprentice. |
| Expert | One Iron, Gold or Diamond piece with some medium-potency enchantments, or the shared ingot alternative | Candidate: Gold Ingots, Diamonds or one Iron/Gold piece, with optional low-potency Basic enchantments |
| Master | One Diamond or Netherite piece with some high-potency enchantments. Enchanted Iron, Gold or Diamond Horse Armor is a candidate pending functional testing. | Same pool as Expert, excluding the option selected at Expert |

All four body slots are eligible for the Journeyman sale, regardless of the earlier sale draws.

**Approved purchase rule:** Through Expert, exclude purchase options already selected for that Armorer at any earlier level. Iron Ingots selected at Novice or Apprentice are excluded at Journeyman. Gold Ingots selected at Journeyman are excluded at Expert. Master uses the exclusion specified in its row.

The Armorer follows the [shared enchantment progression](trading_design_directions.md#artisan-equipment-enchantments). Swift Sneak (Basic) is eligible on leggings and Soul Speed (Situational) is eligible on boots starting at Journeyman, within the potency band for the stage. Horse Armor requires functional validation before it can enter the pool.




## Weaponsmith

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | One unenchanted Copper/Iron Sword and one unenchanted Copper/Iron Spear | Fixed Flint and one of Coal or Charcoal |
| Apprentice | One unenchanted Copper/Iron Sword or Spear in a different material from the Novice offer in that family | One draw from the remaining fuel, Copper Ingots and Iron Ingots |
| Journeyman | One Copper, Iron or Gold Sword or Spear with a few low-potency enchantments | Iron/Gold Ingots or one unenchanted Copper/Iron Sword or Spear. Exclude Iron Ingots if selected at Apprentice. |
| Expert | One Iron, Gold or Diamond Sword or Spear with some medium-potency enchantments, or the shared ingot alternative | Gold Ingots, Diamonds or one Iron/Gold Sword or Spear, with optional low-potency Basic enchantments |
| Master | One Diamond or Netherite Sword or Spear with some high-potency enchantments | Same pool as Expert, excluding only the contract selected at Expert |

Swords and Spears have equal weight when both families are eligible. Buy equipment only at full durability. A Master purchase may still use the same family or material as the Expert purchase if the contract differs. Apply the shared enchantment progression to equipment sales.

Preserve native incompatibilities such as Sharpness, Smite and Bane of Arthropods. The Master Sword pool has only one eligible Treasure, Mending. Reduce its inclusion chance, with the percentage pending. Apply the same rule to Fletcher crossbows and roll Treasure inclusion separately from selecting the effect.




## Fletcher

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Fixed Arrows plus unenchanted Bow or Crossbow | Draw two distinct items from Feather, String, Flint and Stick |
| Apprentice | Remaining unenchanted weapon, Arrows of Slowness or Arrows of Weakness | Draw one item from the same pool, excluding the two selected at Novice |
| Journeyman | One Bow or Crossbow with a few low-potency enchantments, or Spectral, Slowness or Weakness arrows | One unenchanted Bow or Crossbow, or Spectral, Slowness or Weakness arrows |
| Expert | One Bow or Crossbow with some medium-potency enchantments, or Poison, Harming or eligible Journeyman arrows | One Bow or Crossbow with optional low-potency Basic enchantments, or Poison, Harming or eligible Journeyman arrows |
| Master | One Bow or Crossbow with some high-potency enchantments | Same pool as Expert, excluding the option selected at Expert |

Bows and Crossbows have equal weight when both are eligible for a weapon sale. At Apprentice, the remaining unenchanted weapon competes with the two arrow options. Buy weapons only at full durability. Use regular arrow effect variants without amplification or extended duration. Once an arrow offer is drawn, exclude that arrow from later draws in the same trade direction. Preserve Multishot/Piercing and Infinity/Mending incompatibilities. The reduced Mending chance for crossbows follows Weaponsmith's sword rule.




## Leatherworker

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Two unenchanted Leather armor pieces for different player armor slots | Two of Rotten Flesh, Leather, String and Rabbit Hide |
| Apprentice | One unenchanted Leather armor piece from a player armor slot not yet offered, one dye of an eligible color or one plain Bundle | One remaining initial material or one dye |
| Journeyman | One unenchanted Leather armor piece from a player armor slot not yet offered, Leather, Rabbit Hide or one dye of an eligible color not yet offered | Unselected initial materials, eligible equipment or one dye of a color not yet selected for purchase |
| Expert | One unenchanted Leather Horse Armor or Wolf Armor, Leather, Rabbit Hide or one dyed Bundle | One player leather armor piece at full durability, with optional low-potency Basic enchantments, or one dye of a color not yet selected for purchase |
| Master | One dye of an eligible color not yet offered, with the Master bonus, or one Leather Horse Armor or Wolf Armor with some high-potency enchantments, subject to functional validation of the enchanted armor | Same pool as Expert, excluding the option selected at Expert. Any dye color must be new to the purchase history. |

At Expert, draw dyed Bundles as one group, then select one color if the group is drawn. Both Bundle options compete for existing sale slots and use the shared sale history.

Player leather armor sells unenchanted. Metal Horse Armor belongs to Armorer. Use one shared sale history per Leatherworker across all levels. Before each draw, filter the level's eligible pool by removing each exact item already selected for sale. A later lot, price or enchantment variant does not make the item eligible again. Each dye color counts as its own item. When dyes are eligible for sale, draw them as one group, then choose from the eligible colors for that level. Prefer Leather and Rabbit Hide over the dye group in pools where they compete, with weights pending. Review the exact purchase contracts for each stage.

The Master dye sale pool is Brown, Green, Blue and Black. Apprentice and Journeyman dye sales use White, Orange, Magenta, Light Blue, Yellow, Lime, Pink, Gray, Light Gray, Cyan, Purple and Red. Earlier offers keep their original terms. Dye purchase draws from Journeyman onward exclude every color already selected for purchase by that Leatherworker, including the Apprentice purchase. When calibrating Master dye sales, include the dye purchases at all levels from Apprentice onward in the cross-merchant resale check.

For each eligible Master color, target 25–50% more units per emerald than its reference quote calculated under the ordinary retail rules. This quote is used for calibration only. Compare actual integer lots and payments, and fit the result in one output stack. Check retail floors and any reachable resale payout across merchants, including applicable trade modifiers. The ordinary positive resale margin must hold after rounding. Only include the Master offer if a representable quote meets both the bonus and resale checks.




## Animal armor validation

Enchantment components can be attached to these items. Effects on a horse or wolf wearing the armor are still unverified. Horse Armor has no durability. Exclude Unbreaking and Mending as repair benefits on that item. Protection IV, Thorns III and Feather Falling IV are candidates for functional testing. Test Wolf Armor absorption, durability and each proposed effect on a wolf.




## Other professions — candidates awaiting five-level review

Farmer starts with four sales and two purchases. Fisherman supplies fish and gear and buys inputs or qualified rods. Fish purchases are excluded. Butcher supplies meat and meals. Shepherd starts with a wool sale and can offer textile goods, Paintings and Happy Ghast Harnesses. Librarian offers three or four enchanted books by Master. Cartographer supplies navigation, Cleric supplies expedition and brewing resources, and Mason supplies bulk construction materials and early Flint.

The tables after Farmer preserve the previous candidates as input for redistribution. The Secret rows identify former special offers for review in Master and carry no current unlock or draw weights.




## Farmer

Keep separate sale and purchase histories for each Farmer. Before each draw, exclude exact items already selected in the same direction, including earlier draws at the same level. An item can appear once as a sale and once as a purchase. For saplings, apply the exclusion to the specific species. Saplings compete for the same slots as other goods.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Four distinct offers from Wheat Seeds, Beetroot Seeds, Wheat, Apple, Carrot, Potato, a common sapling or a rare sapling | Two distinct offers from Apple, Wheat, Beetroot, Carrot, Potato, Bread, Pumpkin Seeds, Melon Seeds or a rare sapling |
| Apprentice | Two distinct new sales from Wheat, Apple, Carrot, Potato, a common sapling or a rare sapling | Two distinct new purchases from the Novice pool, excluding the purchases selected at Novice |
| Journeyman | One new sale from Pumpkin Seeds, Melon Seeds, Honey Bottle, Cocoa Beans, Pitcher Pod or a treasure sapling | One new purchase from Pumpkin Seeds, Melon Seeds, Cocoa Beans, Hay Block or a treasure sapling |
| Expert | One new sale from Pumpkin Seeds, Melon Seeds, Honey Bottle, Cocoa Beans, Pitcher Pod or a treasure sapling | One new purchase from Hay Block, Cake, Pumpkin Pie, Pitcher Pod, Torchflower Seeds or a treasure sapling |
| Master | One new sale from Golden Apple, Golden Carrot, Honey Bottle or Torchflower Seeds | One new purchase from Cake, Pumpkin Pie, Pitcher Pod or Torchflower Seeds |

Common saplings are Oak, Birch and Spruce. Rare saplings are Acacia, Jungle and Dark Oak. Treasure saplings are Cherry, Pale Oak and Mangrove Propagule. Check for profitable resale between Farmers when calibrating prices and lots for items that can be both bought and sold.




## Butcher

The Butcher sells raw cuts, Bone, Leather and Rabbit Hide. Prepared foods become eligible at Expert. Fish sales belong to Fisherman.

Proposed progression: draw two distinct sales and two distinct purchases at Novice, then one new sale and one new purchase at each later level. Keep separate purchase and sale histories per Butcher and exclude exact items previously selected in the same direction, including earlier draws at the same level. Raw and cooked cuts are distinct items.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Two distinct offers from raw Chicken, Porkchop, Beef or Mutton | Two distinct offers from Wheat, Wheat Seeds, Carrot, Potato, Beetroot or Iron Axe |
| Apprentice | One new sale from raw Chicken, Porkchop, Beef, Mutton, Bone, Leather or Rabbit Hide | One new purchase from the Novice pool, Paper or String |
| Journeyman | One new sale from the Apprentice sale pool | One new purchase from Bread, Apple, Honey Bottle, Egg, Milk Bucket, Coal, Charcoal, Paper or String |
| Expert | One new sale from Cooked Chicken, Cooked Mutton or Cooked Rabbit | One new purchase from the Journeyman purchase pool |
| Master | One new sale from Steak, Cooked Porkchop or Rabbit Stew | One new purchase from the Journeyman purchase pool |

The Iron Axe contract's durability and enchantment eligibility remain open. A Milk Bucket quote includes the bucket consumed by the trade. Check resale paths during calibration, including Leather and Rabbit Hide sold to a Leatherworker and Iron Axes bought from a Toolsmith and sold to a Butcher.




## Fisherman

Fisherman supplies raw and cooked fish and fishing equipment. Fish are sale-only. Following the Butcher progression, cooked food is first eligible at Expert. This proposal uses two distinct sales and two distinct purchases at Novice, then one sale and one purchase at each later level. Exclude exact items already selected in the same direction, including earlier draws at the same level. Identify fishing rod contracts by their item and enchantment conditions.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Cod and Salmon | String and Stick |
| Apprentice | One new sale from Tropical Fish, Pufferfish or an unenchanted Fishing Rod | Coal or Charcoal |
| Journeyman | One new sale from the Apprentice sale pool or Bucket | The remaining option from Coal or Charcoal, or Glass Bottle |
| Expert | One new sale from Cooked Cod, Tropical Fish Bucket or Pufferfish Bucket | One new purchase from the Journeyman purchase pool |
| Master | Cooked Salmon or one Fishing Rod with a high-potency Lure or Luck of the Sea enchantment | One Fishing Rod at full durability with optional low-potency Basic enchantments |

Mending on sold Master rods remains under review.




## Shepherd

Start with one sale and one purchase at Novice. Add one new sale and one new purchase at each later level. Keep separate sale and purchase histories per Shepherd and exclude items already selected in the same direction. For colored goods, apply the exclusion to the exact item and color. Beds, Carpets and Banners are excluded from both trade directions.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | One offer from common wool or Shears | One offer from String, Leather, Beeswax, an uncommon dye, Wheat or Shears |
| Apprentice | One new sale from common wool, a common dye or Shears | One new purchase from the Novice purchase pool |
| Journeyman | One new sale from common or uncommon wool, a common or uncommon dye, Painting or Shears | One new purchase from Leather, Beeswax, a common or uncommon dye, Wheat, Hay Block or Shears |
| Expert | One new sale from uncommon wool, an uncommon dye, Painting, Shears or a common-color Happy Ghast Harness | One new purchase from a common or uncommon dye, Hay Block or Painting |
| Master | One new sale from uncommon wool, an uncommon dye or an uncommon-color Happy Ghast Harness | One new purchase from the Expert purchase pool |

Wool, dyes and Happy Ghast Harnesses share two color groups. Common colors are White, Orange, Magenta, Light Blue, Yellow, Lime, Pink, Gray, Light Gray, Cyan, Purple and Red. Uncommon colors are Brown, Green, Blue and Black. Draw each eligible colored item category as one group when it competes with other goods, then choose an eligible color not yet selected for that item category and trade direction. If common wool is drawn at Novice, White Wool has a 50% chance and the other common colors share the remaining 50%. Wool, dye and harness of the same color count as distinct items.

When calibrating prices and lots, check direct resale and recipes that convert sold inputs into purchased goods, especially Wool into String or Painting.




## Librarian

Draw distinct offers within each trade direction and exclude items already selected in that direction. For Enchanted Books, identify the offer by its enchantment and level. For Music Discs, identify the offer by the individual disc. Natural loot remains a separate access route.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | One offer from Paper or Book, and one from Ink Sac or Black Dye | Two distinct offers from Paper, Book, Feather, Ink Sac, Glow Ink Sac, Black Dye or Leather |
| Apprentice | Two distinct new sales from Paper, Book, Name Tag, Clock, Compass, a common or uncommon Music Disc, or Bottle o’ Enchanting | One new purchase from the Novice purchase pool |
| Journeyman | One Enchanted Book with a low-potency Basic enchantment or a low- or medium-potency Situational enchantment | One new purchase from Leather, Lapis Lazuli, Gold Nugget or Amethyst Shard |
| Expert | One Enchanted Book with a high-potency Basic, Advanced or Situational enchantment | One new purchase from Leather, Lapis Lazuli, Gold Nugget, Amethyst Shard or Echo Shard |
| Master | Two sales: first draw one of the two Master book candidates, then draw from the remaining book candidate, one rare Music Disc or Echo Shard | One new purchase from the Expert purchase pool |

The two Master book candidates are one Enchanted Book with a high-potency Basic, Advanced or Situational enchantment and one Enchanted Book with a medium- or high-potency Treasure enchantment chosen by biome. The second sale uses the book candidate left over from the first draw. Use the [experimental vanilla Librarian rebalance](https://feedback.minecraft.net/hc/en-us/articles/18619031671821-Minecraft-Java-Edition-Snapshot-23w31a) as the reference for the Treasure book. An eligible single-level enchantment uses its only available level. Mending retains its natural loot route.

Iota Master Treasure book map, by villager type:

| Villager type | Treasure enchantment | Eligible levels |
| --- | --- | --- |
| Desert | Infinity | I |
| Jungle | Feather Falling | II–IV |
| Plains | Channeling | I |
| Savanna | Lunge | II–III |
| Snow | Frost Walker | I–II |
| Swamp | Mending | I |
| Taiga | Silk Touch | I |

When generating the Master Treasure book candidate, select the villager type's specialty with 75% probability. With the remaining 25%, draw from the full shared Treasure category excluding that specialty. Apply the same medium- or high-potency rule to either result. This draw determines which Treasure book competes for the Master sale slots.

Proposed Music Disc pools for Java 1.21.11, grouped by acquisition route:

| Rarity | Sale stage | Discs |
| --- | --- | --- |
| Common | Apprentice | 13, Cat, Blocks, Chirp, Far, Mall, Mellohi, Stal, Strad, Ward, 11 and Wait |
| Uncommon | Apprentice | Otherside, Relic, Precipice and Lava Chicken |
| Rare | Master | 5, Pigstep, Creator, Creator (Music Box) and Tears |

Draw Music Discs as one item category in the eligible sale slot. Check same-item resale and conversion routes at calibration, including Ink Sac into Black Dye and Paper plus Leather into Book.




## Cartographer

Retain navigation focus and useful map destinations, one draw per level. Recovery Compass always one unit; chain repriced coherently. Map service still requires real map generation.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Map OR Compass; Map OR Compass | Paper OR Glass Pane; Glass Pane OR Paper |
| Apprentice | Spyglass OR Filled Map -> Village | Ink Sac OR Amethyst Shard |
| Journeyman | Filled Map -> Shipwreck OR Filled Map -> Ruined Portal | Map OR Compass |
| Expert | Filled Map -> Ocean Monument OR Filled Map -> Trial Chambers | Spyglass OR Clock |
| Master | Filled Map -> Woodland Mansion OR Recovery Compass | Recovery Compass |
| Secret | Filled Map -> Ancient City | No addition |




## Cleric

Candidate items for the next review, with buy and sell directions still open: Redstone Dust, Lapis Lazuli, Glowstone Dust, Gunpowder (tentative), Sugar, Glow Berries, Lantern, Candle, String, Beeswax, Paper, Feather, Bone, Black Dye, Ink Sac, Potions, Wither Rose, Nether Wart, Blaze Powder, Blaze Rod, Ender Pearl, Eye of Ender, Wither Skeleton Skull and Skeleton Skull.

Reagents and brewing services; Secret only selected Wind Charge/Ghast Tear candidates. No implicit Breeze Rod, Heavy Core or Nether Star offer.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Redstone OR Lapis Lazuli; Redstone OR Lapis Lazuli | Rotten Flesh OR Nether Wart; Nether Wart OR Rotten Flesh |
| Apprentice | Glowstone Dust OR Quartz | Glass Bottle OR Red Mushroom OR Brown Mushroom |
| Journeyman | Experience Bottle OR Ender Pearl | Spider Eye OR Blaze Powder |
| Expert | Potion [Fire Resistance] OR Potion [Strong Healing] | Magma Cream OR Phantom Membrane |
| Master | Potion [Slow Falling] OR Potion [Strong Regeneration] | Ghast Tear |
| Secret | Wind Charge OR Ghast Tear | No addition |




## Mason

Retain bulk builder supply and early Flint. One regional complement can supply omitted palettes; do not turn the Stonecutter into a trade-only item.

| Stage | Sells | Buys |
| --- | --- | --- |
| Novice | Flint OR Stone; Stone OR Flint | Cobblestone OR Gravel; Gravel OR Cobblestone |
| Apprentice | Clay Ball OR Brick | Sand OR Clay Ball |
| Journeyman | Terracotta OR Quartz Block | Sandstone OR Glass |
| Expert | Stone Bricks OR Chiseled Stone Bricks | Terracotta OR Stone Bricks |
| Master | Prismarine OR Sea Lantern | Quartz Block |
| Secret | Calcite OR Amethyst Block OR Purpur Block | No addition |




## Decision history

The [22 November snapshot](../research_index.md#backups-anteriores) preserves prior artisan tables and economy references. Generated catalogs and native evidence are in the [20 November execution output](../research/outputs/trading_execution-2026-11-20/).
