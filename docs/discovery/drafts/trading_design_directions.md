# Trading — Design Directions

Target: Minecraft Java 1.21.11. Current working decisions: 2026-11-22.

The shipped Iota still uses vanilla villager trading. The candidate catalogs,
prices and regional model are research/design artifacts, not installed trades.
User-selected rules are binding. Numerical choices and pool allocations made
under delegated authority remain explicitly reviewable in the task workbook.

Trading coordinates Economy, Progression, Exploration and Quality decisions
across modules. Trades owns merchant behavior. Its experimental identity slice is separate
from the base; the complete trading runtime is not implemented. Tools owns repair/anvil changes; Drops owns metal loot changes.

See the [prototype README](../../../modules/experimental/trades/readme.md) and the [test checklist](../../release_checklist.md#trading-redesign--checks-still-needed) for runtime scope and validation.




## Design tenets — approved

1. **Plug & play:** install the ZIP and load the world. No external dependencies,
   manual experiment activation or setup commands in the final release.
2. **Be intentional:** coherent, elegant decisions serving a clear vision.
3. **Show, don't tell:** minimize uncertainty, explanatory text and interface.
4. **Trust & recycle:** modify as little vanilla functionality as possible.
5. **Work for it:** emphasize the journey toward rewards.
6. **Less is more:** avoid excessive options, value and repetition.
7. **We all lift together:** worthwhile commercial opportunities across resource
   sources and playstyles.
8. **Different is good:** no single correct sandbox playstyle or mandatory loop.
9. Encourage exploration.
10. Encourage community building.
11. Encourage infrastructure building.
12. Encourage personalization and personification of villages and villagers.

Essential workstations must not become trade-exclusive to force participation.
Commercial income should let farmers, miners, explorers and manufacturers
exchange the products of their different activities.




## Economic criteria — approved

- **Tier coherence:** broadly, a villager should offer goods of a tier equal
  to or above the goods it purchases. Preserve earlier lower-tier offers;
  their continued presence does not violate the principle. Compare the eligible
  tier ranges at each stage, not each individual's random outcome. Buying Iron
  while a tool sale rolls Copper is acceptable. Buying Gold while retail still
  uses only Copper/Iron instead of Iron/Gold is the problematic progression.
  Do not force a higher retail result merely because a purchase draw is higher.
  The current catalog uses the material progression order,
  not a claim that Gold is mechanically superior to Iron in every tool stat.

- Renewable/farmable goods should generally have lower unit value than
  harder-earned finite goods. Rarity alone does not determine the price.
- Useful processing and better constituent materials should increase value.
  Count effort, risk, fuel, XP, infrastructure, utility and alternatives;
  repeated crafting clicks alone do not justify unlimited added value.
- Compare wealth opportunities at similar development stages, including volume,
  investment, active work and passive output. No identical unit-price rule or
  exact emeralds/hour target has been selected.
- Profitable specialized production, including enchanted equipment assembly
  lines, is intended gameplay. Buying some inputs does not make a production
  chain an exploit.
- **Shop margin — requested direction:** for the same item and equivalent
  durability/enchantments/components, the villager's retail unit price should
  be slightly higher than its purchase unit price. The shop keeps a positive
  margin; exact percentages and profession exceptions remain open. Compare
  per-unit effective prices after quantities, discounts and integer rounding,
  including cross-vendor routes. Ordinary/local buying and immediate reselling of an unchanged
  item must not generate guaranteed profit. Regional import purchases are the
  approved exception described below. This does not remove compensation
  for useful crafting or enchanting work.
- Prevent ordinary/local immediate buy/resell profit and profit from endlessly
  repeating reversible conversions. Check Iota recipes, salvage, discounts,
  other vendors, enchanting and repair routes together.
- Paid prices for enchanted crafts must justify materials, processing and
  enchanting investment. Do not exclude goods merely because a player could
  be sentimentally attached to them; selling is the player's choice.
- Do not reward mass villager confinement as the default route to useful
  capacity. Keep direct gathering, crafting and exploration credible options.

Use the contemporary reasoning behind the 2012 Quick Fix proposal, not its old
prices or assumptions about modern farms.




## Ordinary and regional slots

| Stage | New sales | New purchases | Cumulative ordinary offers |
| --- | ---: | ---: | ---: |
| Novice | 2 | 2 | 4 |
| Apprentice | 1 | 1 | 6 |
| Journeyman | 1 | 1 | 8 |
| Expert | 1 | 1 | 10 |
| Master | 1 | 1 | 12 |

Leatherworker receives two Apprentice sales in place of the ordinary one, giving it 13 ordinary offers by Master. Keep earlier offers, avoid duplicates and list sales first. Regional offers have their own budget, with 1–2 local sales and 1–2 import purchases where supported. Exact counts and unlocks depend on regional review.

The redesign uses five career levels. The validated profession catalogs specify the placement of former Secret rewards.




## Master smith sale draw

Armorer, Toolsmith and Weaponsmith each draw one Master sale: Netherite Scrap (5%), Diamond (15%) or equipment (80%). When player equipment is selected, roll its material separately: Diamond (95%) or Netherite (5%).

Within the Armorer equipment branch, draw player armor (70%), unenchanted Horse Armor (15%) or unenchanted Nautilus Armor (15%). Both animal armor categories use the approved Golden or Diamond pool. The 95%/5% material roll applies to player armor only.

## Profession rules and catalogs

See the [Toolsmith template](trading_toolsmith_template.md) and [profession catalogs](trading_profession_catalog_draft.md) for profession-specific rules and working offers.




## Identity and offer state

Commit a career and a full valid offer plan at the first adult profession. No
jobsite, interface, save/load or restock rerolls. Keep ordinary workstation AI,
allow same-profession rebinding and preserve player names. Assign a random
personal name once at Apprentice if unnamed. Do not commit babies or nitwits.

Group complete sale records before complete purchase records, preserving uses,
demand, prices and experience. Do not reorder offer indices during a transaction
or reset live offers from pristine snapshots. Native1.21.11 trade pools are code,
not editable loot tables or the newer data-driven trade registry.




### Explorer map integration

The Cartographer catalog references one loot table and structure tag per destination. In a seeded Java 1.21.11 world, all eight loot tables returned filled maps with a map ID and a marker matching the coordinates returned by the structure locator. The Ancient City table returned an empty map in the Nether. Validate both components and draw only from located destinations in the approved pool. If the game finds no eligible destination for a map slot, leave that slot pending. Existing map identity and price are part of the committed offer.

## Enchanted equipment purchases

Buy equipment only at full durability. Expert equipment contracts use Basic enchantments up to level II, so I and II are eligible. Plain equipment has no gameplay enchantments. Decide whether equipment with eligible effects plus higher-level or other effects qualifies, and which effects the payout values.

Where Master reuses an Expert purchase pool, remove the selected option before the second draw. Confirm where this excludes the entire equipment branch or only the selected contract. Preserve item data and protect rejected items from consumption.




## Working price and stock calibration

The Expert sale slot for Toolsmith and Weaponsmith may offer Copper, Iron or Gold Ingots instead of equipment. The Armorer includes those ingots as alternatives to player armor in its single Journeyman sale slot. Exclude metals already offered for sale.

Use 1 VU = 1 emerald provisionally. The initial 95% payout and 105% retail targets are starting points; manufacturing floors and resale checks can raise prices. Then
validate the actual integer lots. Ordinary purchase inputs use one item stack,
not1+remainder. Payouts above64 use the approved nearest safe multiple of9;
retail payments fit the two input slots. Whole-unit rounding can create a much
larger spread than the nominal target. Current prices also apply a manufacturing floor and a positive ordinary resale margin. Keep Hero of the Village discounts. For every reachable ordinary or local direct resale route, including across merchants, require the resale payout to be strictly below the acquisition cost for equivalent quantities. Check actual integer lots and effective trade terms, including Hero V and applicable trade modifiers. Keep the approved regional import exception. For crafting routes, prevent profitable repeatable cycles through reversible conversions and allow compensation for useful crafting work.

### T01/E03 calibration checks

Replayed selected direct resale routes present in the validated pools using the historical quotes, Hero V rounding on the first input, and historical uses per refill. With Hero V, Mason Clay Balls return 6 emeralds from a 3-emerald purchase (6 balls left), Toolsmith Gold Ingots resold to Weaponsmith return 122 from 66, and Weaponsmith Iron Ingots resold to Armorer return 248 from 132 (4 ingots left). All three have a strict margin at base prices.

At the historical prices and purchase contracts, test smaller sale lots as candidates: 28 Clay Balls for 5 emeralds, 8 Gold Ingots for 6 emeralds plus 7 emerald blocks, and 15 Iron Ingots for the same payment. For these specific route pairs, all six Hero states (off and I–V) satisfy the strict per-unit margin after integer rounding. Recheck stock capacity separately and check each quote against every compatible purchase contract before adopting it.

Clay is a reversible route: crafting uses four Clay Balls per Clay Block and breaking without Silk Touch returns four. For the tested Mason contract at Hero V (29 balls for 3 emeralds), a retail lot of B Clay Blocks needs an effective price strictly above 12B/29 emeralds for this route. The historical catalog has no comparable retail quote for Clay Blocks. The historical data also lacks the new Fisherman purchase of Cooked Cod and the Cleric purchase of Eye of Ender. Price those offers before auditing the cooking and Eye of Ender routes.

### Candidate quotes for the validated pools

Use these quotes for the listed contracts wherever the validated pools include them. They supersede the trial sale lots above for these items. Quantities are per transaction. Payments are in emeralds unless blocks are specified. Stock is separate.

| Merchant | Merchant sells | Merchant buys |
| --- | --- | --- |
| Armorer, Toolsmith, Weaponsmith | 8 Iron Ingots for 5 emeralds plus 4 emerald blocks | 32 Iron Ingots for 62 |
| Armorer, Toolsmith, Weaponsmith | 8 Gold Ingots for 9 emeralds plus 7 emerald blocks | Preserve candidate Gold Ingot purchases of 16 for 61 (Weaponsmith) and 64 for 243 (Armorer and Toolsmith, payout in emerald blocks) |
| Armorer, Toolsmith, Weaponsmith | 1 Diamond for 34 or 1 Netherite Scrap for 5 emeralds plus 7 emerald blocks, in their approved Master draw | 1 Diamond for 15 |
| Mason | 28 Clay Balls for 5 or 4 Clay Blocks for 5 | 64 Clay Balls for 3 |
| Fisherman | 4 raw Cod or Salmon for 3 | 1 Cooked Cod or Salmon for 1 |
| Cleric | 1 Ender Pearl for 5 or 1 Blaze Powder for 3 | 4 Ender Pearls for 5, 8 Blaze Powder for 7, or 1 Eye of Ender for 9 |

The direct comparisons above and the Clay Block-to-Clay Ball conversion have a strict unit margin with Hero off and at levels I–V using first-slot discounts and integer rounding. Cooking and Eye of Ender crafting use irreversible recipes and earn a manufacturing margin. At base quotes, four fish cost 3 and return 4 after cooking, and the Eye of Ender uses 8 emeralds in purchased ingredients and returns 9. With Hero V, the four fish cost 2 and return 4 across four purchase uses, and the Eye uses 5 in ingredients and returns 9. Test those uses against replenishment, and compare with other routes and applicable modifiers before treating the quotes as validated.

Iron and gold quotes remain provisional until the Iron Golem farm and piglin gold farm balance is settled. Recalibrate ingots, nuggets and affected equipment prices against measured output using the final Iota drops, then rerun direct resale and conversion checks with Hero. The current quotes serve as candidates for C02 previews.

### Shared candidate quotes for overlapping offers

Use the applicable sale or purchase column only where the corresponding item occurs in an approved profession pool. These are transaction terms. Stack limits, stock and offer eligibility still follow the catalog and runtime rules. Each listed retail price exceeds the listed purchase rate at all six Hero states after rounding.

| Item | Retail lot | Retail payment | Purchase lot | Purchase payout |
| --- | ---: | --- | ---: | ---: |
| Flint | 16 | 18 | 48 | 12 |
| Copper Ingot | 8 | 21 | 32 | 17 |
| Iron Nugget | 16 | 16 | 32 | 7 |
| Copper Nugget | 16 | 5 | 64 | 3 |
| Gold Nugget | 8 | 16 | 32 | 13 |
| Paper | 16 | 5 | 64 | 4 |
| Book | 4 | 9 | 16 | 9 |
| Leather | 8 | 9 | 32 | 9 |
| Rabbit Hide | 16 | 5 | 64 | 4 |
| String | 16 | 7 | 48 | 5 |
| Ink Sac | 8 | 18 | 32 | 13 |
| Black Dye | 8 | 23 | 32 | 15 |
| Glass Bottle | 16 | 5 | 48 | 4 |
| Prismarine Shard | 8 | 7 | 32 | 7 |
| Prismarine Crystals | 8 | 18 | 32 | 15 |
| Echo Shard | 1 | 2 emeralds + 7 blocks | 1 | 30 |
| Turtle Scute | 1 | 16 | 1 | 7 |
| Nautilus Shell | 1 | 16 | 1 | 7 |
| Turtle Egg | 1 | 7 | 4 | 7 |
| Heart of the Sea | 1 | 2 emeralds + 7 blocks | 1 | 60 |
| Ghast Tear | 1 | 16 | 1 | 7 |
| Wither Skeleton Skull | 1 | 2 emeralds + 7 blocks | 1 | 60 |
| Phantom Membrane | 1 | 16 | 1 | 7 |
| Nether Quartz | 8 | 7 | 32 | 7 |
| Magma Cream | 1 | 9 | 4 | 6 |
| Redstone Dust | 16 | 7 | 48 | 5 |
| Gunpowder | 8 | 7 | 32 | 7 |
| Spider Eye | 8 | 18 | 32 | 15 |
| Slimeball | 8 | 18 | 32 | 15 |

Checked the reversible nine-to-one ingot/nugget routes in both directions for Copper, Iron and Gold. Also checked Ink Sac to Black Dye and Rabbit Hide to Leather. Book crafting from purchased Paper and Leather does not pay for the purchased inputs at these rates. This covers the stated quotes and conversions. Alternate retail inputs, other recipe chains, offer access, and native modifiers need separate checks.

### Candidate farm, textile and supply quotes

Each quote applies wherever the corresponding buy or sell contract exists in the validated pools. A dash marks a direction without a quote here. Hay Block has a purchase quote and remains absent from the validated retail pools.

| Item | Retail lot | Retail payment | Purchase lot | Purchase payout |
| --- | ---: | ---: | ---: | ---: |
| Wheat | 16 | 9 | 48 | 5 |
| Wheat Seeds | 32 | 3 | 64 | 1 |
| Beetroot Seeds | 32 | 2 | — | — |
| Apple | 8 | 18 | 32 | 15 |
| Carrot | 16 | 5 | 64 | 4 |
| Potato | 16 | 5 | 64 | 4 |
| Beetroot | — | — | 48 | 5 |
| Bread | — | — | 32 | 13 |
| Pumpkin Seeds | 16 | 5 | 64 | 4 |
| Melon Seeds | 16 | 5 | 64 | 5 |
| Honey Bottle | 4 | 12 | 16 | 11 |
| Cocoa Beans | 16 | 7 | 48 | 5 |
| Pitcher Pod | 1 | 16 | 1 | 7 |
| Torchflower Seeds | 1 | 16 | 1 | 7 |
| Hay Block | — | — | 16 | 17 |
| Cake | — | — | 1 | 2 |
| Pumpkin Pie | — | — | 32 | 16 |
| Wool, any eligible color | 4 | 16 | — | — |
| Painting | 4 | 16 | 16 | 14 |
| Stick | — | — | 64 | 3 |
| Shears | 1 | 9 | 1 | 4 |
| Kelp | 16 | 5 | 64 | 4 |
| Seagrass | 16 | 7 | 48 | 5 |
| Bucket | 1 | 12 | 1 | 5 |
| Bone | 8 | 9 | 32 | 7 |
| Dye, any eligible color except Black | 8 | 9 | 64 | 5 |

Black Dye uses its shared quote for ordinary sales and purchases. The Leatherworker's Master reference for Brown, Green and Blue is 8 units for 9 emeralds. For Black, use the shared ordinary quote of 8 for 23 emeralds as the reference. The Master quote is 10 units for 9 emeralds for Brown, Green and Blue, or 10 for 23 for Black. These are 25% more units at the same price as the corresponding reference. The Black Dye purchase remains 32 for 15 emeralds.

### Candidate equipment and navigation quotes

The lot is one item for each contract shown. Use these prices for the corresponding approved sale and purchase contracts. For the Axe, Shovel and Boots, the purchase payout also serves as the worst-case compatible bid while the open eligibility details are being resolved. Properties already specified by the catalogs apply unchanged.

| Item | Plain retail payment | Purchase payout |
| --- | ---: | ---: |
| Iron Axe | 19 | 8 |
| Iron Shovel | 9 | 4 |
| Leather Boots | 7 | 3 |
| Bow | 5 | 2 |
| Crossbow | 12 | 5 |
| Fishing Rod | 4 | — |
| Clock | 37 | 16 |
| Compass | 19 | 8 |
| Spyglass | 7 | 3 |
| Empty Map | 11 | — |
| Name Tag | 9 | — |
| Lead | 2 | — |
| Bundle | 3 | — |
| Saddle | 5 | — |
| Leather Horse Armor | 4 | — |
| Wolf Armor | 5 | — |
| Happy Ghast Harness, any eligible color | 4 | — |

For the five equipment families above with a purchase payout, use the same payout for the listed plain contract and any approved low-potency Basic contract until pricing of qualifying equipment is validated. On sale, use the listed plain price as a floor for enchanted offers of the same item. This preserves the tested resale margin even if an enchanted offer matches a purchase contract.

The Iron Axe and Iron Shovel prices also pass against melting each into one Iron Nugget and selling the nuggets at the shared candidate purchase rate, even before accounting for fuel. A crafted Compass uses four Iron Ingots and one Redstone Dust. Its payout is below the cost of the iron alone when the inputs come from the tested smith retail quotes. A Clock uses four Gold Ingots and one Redstone Dust, and passes the equivalent comparison against the cost of gold alone. These checks cover the stated ingredient routes. Equipment variants, enchantment premiums, brewing conversions and native trade modifiers still require calibration.

### Candidate food, ammunition and container quotes

Apply each direction only to contracts present in the validated pools. Express payments and payouts in emeralds. The tipped-arrow quote covers only the approved regular effect variants, with independent offer history for each effect.

| Item | Retail lot | Retail payment | Purchase lot | Purchase payout |
| --- | ---: | ---: | ---: | ---: |
| Raw Chicken, Porkchop, Beef or Mutton | 4 | 5 | — | — |
| Cooked Chicken, Cooked Mutton, Cooked Rabbit, Steak or Cooked Porkchop | 4 | 6 | — | — |
| Rabbit Stew | 1 | 3 | — | — |
| Egg | — | — | 16 | 2 |
| Milk Bucket | — | — | 1 | 5 |
| Cod Bucket or Salmon Bucket | 1 | 17 | — | — |
| Pufferfish Bucket or Tropical Fish Bucket | 1 | 21 | — | — |
| Axolotl Bucket | 1 | 27 | — | — |
| Arrow | 16 | 4 | — | — |
| Spectral Arrow | 8 | 27 | 8 | 4 |
| Tipped Arrow | 8 | 23 | 8 | 5 |
| Glowstone Dust | 8 | 8 | — | — |
| Coal | — | — | 32 | 15 |
| Charcoal | — | — | 32 | 9 |
| Beeswax (Honeycomb) | — | — | 32 | 15 |
| Feather | — | — | 48 | 5 |
| Rotten Flesh | — | — | 32 | 7 |
| Sugar | 16 | 4 | — | — |
| Candle | 4 | 4 | — | — |
| Lantern | 4 | 10 | — | — |
| Glow Ink Sac | — | — | 16 | 11 |

The Milk Bucket payout stays below the cost of a purchased Bucket even with free milk. An aquatic bucket costs more than the payout for its recovered Bucket and, for Cod and Salmon, the additional payout after cooking the fish. A Honey Bottle costs more than the payout for the Glass Bottle returned after drinking or crafting. The Spectral Arrow recipe uses one Arrow and four Glowstone Dust for two outputs. At the candidate prices its input cost is above resale at every Hero level. Tipped-arrow brewing, alternative potion sources and depleted container cases still need review.

### Candidate Mason specialty quotes

Use these quotes only for the approved Mason groups and levels. Color and variant draws follow the validated offers. Retain the earlier Flint, Clay Ball, Clay Block, Lantern and shared purchase quotes.

| Item or family | Retail lot | Retail payment |
| --- | ---: | ---: |
| Sand | 32 | 12 |
| Gravel | 16 | 18 |
| Brick or Nether Brick | 16 | 7 |
| Flower Pot | 4 | 6 |
| Decorated Pot | 1 | 37 |
| Stone or Smooth Stone | 32 | 7 |
| Sandstone or Mud Bricks | 16 | 6 |
| Bricks or Nether Bricks | 16 | 12 |
| Polished Andesite, Diorite, Granite, Deepslate or Tuff | 32 | 8 |
| Calcite | 16 | 8 |
| Smooth Quartz | 8 | 16 |
| End Stone or Blackstone | 16 | 10 |
| Prismarine | 4 | 10 |
| Dark Prismarine | 4 | 20 |
| Obsidian | 4 | 9 |
| Glass family, Terracotta family, Glazed Terracotta or Concrete | 16 | 10 |
| Copper Lantern or Soul Lantern | 4 | 10 |
| Redstone Lamp | 4 | 11 |
| Froglight, any eligible color | 4 | 12 |

Purchase one Pottery Sherd for 4 emeralds. The Decorated Pot quote is conservatively priced above four sherd payouts even under Hero V. Verify the generated pot components in C02 before refining that quote.

Gravel is priced above Flint resale even with the guaranteed Fortune III yield of one Flint per Gravel. The Iota clay recipe provides another route to recover four Clay Balls per block. The retained Clay Block quote passes for both crafting recovery and mining without Silk Touch. The Iota Honey Bottle plus Green Dye recipe also passes when the Slimeball and returned Glass Bottle are both credited at their purchase rates.

### Multi-step conversion audit

A three-pass scan of effective vanilla and Iota recipes reached 26 purchase items from the audited subset of merchant retail inputs. With Hero off and at Hero V, the profitable routes in that scan were cooking Cod or Salmon and crafting Eye of Ender. Both are already covered by the manufacturing stock candidates. The scan used amortized costs, excluded fuel, and expanded only the equipment and wool ingredient tags.

A separate check expanded the smelts_to_glass tag. Sand at the initial quote allowed a Hero V player to buy 32 for 3 emeralds, smelt the sand, and sell 22 crafted Glass Bottles for 4 emeralds, with enough materials left for eight more bottles and two glass blocks. Raise the 32-Sand quote from 5 to 12 emeralds. After first-slot discounts, the amortized cost of Sand-to-Glass-to-Glass Bottle stays above the Glass Bottle payout at every Hero level, even before fuel. The direct Glass-to-Glass Bottle route also passes.

The [reproducible conversion audit](../tests/audit-trading-conversions.mjs) extends this scan to 1,646 supported crafting, cooking and stonecutting recipes and 199 item tags. It follows the cheapest paths from the candidate retail inputs until the estimated costs stop changing. It reaches 82 distinct purchase items at all six Hero states. This is a unit-rate stress test with candidate quotes, before fuel, stock and per-merchant accessibility.

The expanded scan found two additional adjustments under Hero V. Raise eight Bone from 7 to 9 emeralds so Bone Meal converted to White Dye stays below the resale threshold. Reduce the payout for the base four-Magma Cream lot from 9 to 6 so the payout stays below the cost of Blaze Powder and Slimeball. Retain the small manufacturing margin on Leather Boots from purchased Leather, along with the modeled margins on cooked fish and Eye of Ender. After these adjustments, the scan reports no unexpected equal-cost or profitable routes.

The scan does not model component-sensitive contracts such as tipped arrows and decorated pots, or all non-recipe routes, such as brewing, block drops and container recovery. The separate checks above cover examples of those routes. Rerun against generated contracts in C02 to cover the specific variants and their eligibility, and check actual stock and modifiers in integration.

### Tipped-arrow manufacturing margin

Eight regular Arrows and one matching Lingering Potion produce eight Tipped Arrows. At the candidate prices, a full batch returns 5 emeralds with Hero off and 10 at Hero V, where the Fletcher accepts four arrows per use and at least two uses are available. Eight Arrows cost 2 or 1 emeralds respectively on a per-unit basis, so the break-even cost for the potion and other costs is 3 or 9 emeralds per batch. This is the ceiling before a loss on purchased inputs, and any lower cost leaves a manufacturing margin. Use one Gunpowder and one Dragon's Breath per three bottles. For regular Weakness, start with a Fermented Spider Eye in water. For Slowness, corrupt regular Swiftness. For Poison, add Spider Eye to an Awkward Potion. For Harming, corrupt regular Poison. The [Java brewing definitions](https://raw.githubusercontent.com/mahtomedi/minecraft/main/src/main/java/net/minecraft/world/item/alchemy/PotionBrewing.java) provide the recipe paths. Recheck the regular effect components in Java 1.21.11 at C02.

The table estimates one Lingering Potion from a full three-bottle batch. Use provisional Dragon's Breath and Brown Mushroom values of 8 and 0.125 emerald equivalents from the discovery matrix, merchant prices for other inputs, and one twentieth of a Blaze Powder per brewing step. Count the incoming bottles and give no recovery credit. Values exclude collection time, setup and stock limits. They are model estimates for inputs collected outside the approved trades.

| Effect | Brewing steps | Cost per potion, no Hero | Cost per potion, Hero V | Margin per eight arrows, no Hero | Margin per eight arrows, Hero V |
| --- | ---: | ---: | ---: | ---: | ---: |
| Weakness | 3 | 4.30 | 3.58 | -1.30 | 5.42 |
| Slowness | 5 | 4.65 | 3.77 | -1.65 | 5.23 |
| Poison | 4 | 4.39 | 3.61 | -1.39 | 5.39 |
| Harming | 5 | 5.31 | 4.10 | -2.31 | 4.90 |

Keep these provisional manufacturing margins for throughput review. A full three-bottle batch makes 24 tipped arrows. At Hero V, selling all 24 takes six purchase uses per effect. The candidate cap below limits sales to eight arrows per stocked offer under Hero V.

### Candidate exploration and Librarian quotes

Use these one-item retail prices in the approved pools. Maps require a valid located destination. Keep each approved slot, destination option and rarity roll.

| Contract | Payment in emeralds |
| --- | ---: |
| Village or Shipwreck map | 12 |
| Ruined Portal or Buried Treasure map | 16 |
| Ocean Monument or Trial Chambers map | 24 |
| Woodland Mansion or Ancient City map | 32 |
| Common, uncommon or rare Music Disc | 24, 32 or 40 respectively |
| Bottle o' Enchanting | 5 |
| Enchanted Book at Journeyman | 8 plus 4 per enchantment level |
| Ordinary Master or Expert Enchanted Book | 12 plus 5 per enchantment level |
| Master Treasure Enchanted Book | 24 plus 6 per enchantment level |
| Golden Apple | 8 emeralds plus 7 emerald blocks |
| Golden Carrot | 7 |
| Sniffer Egg | 5 emeralds plus 7 emerald blocks |

Use these other candidate terms where present in the validated offers: sell 8 Nether Wart for 4 emeralds or 8 Lily Pads for 4. Buy 32 Amethyst Shards or 32 Lapis Lazuli for 4 emeralds, or 16 Chorus Fruit for 7.

For Farmer sapling sales, use lots of four for 6 emeralds (common), 10 (rare) or 16 (treasure). For eligible Farmer purchases, pay 4 emeralds for eight rare saplings or 7 for eight treasure saplings. Apply terms to each species within its approved group.

### Candidate prices for equipment variants

Use one item per transaction. The explicit quotes above supply the starting terms for their items, subject to the manufacturing and resale floors below. For the remaining approved equipment variants, use the per-item reference value V from the [archived item matrix](../research/outputs/trading_economy-discovery-2026-11-19/items.json). Use the value of the actual item and material. These are candidate prices derived from the existing reference, with manufacturing costs still subject to route review.

- For a purchase, pay floor(0.95 × V), with a minimum of one emerald. Apply only to eligible purchase contracts. Use the same payout for additional enchantments, as approved in D05.
- For a sale, start at ceil(1.05 × V). Add one emerald per enchantment level summed across the item's enchantments, plus four emeralds if the item has a Treasure enchantment. For the explicitly quoted equipment, add the same amounts to its listed plain retail price.
- For a sale that can match any approved purchase contract, raise the candidate total as needed so every modified retail payment stays strictly above the highest compatible payout. When contract eligibility is open, use the highest bid for that item as a conservative bound. This pricing guard leaves the eligibility decision open.
- Encode payments of up to 64 as emeralds. Above 64, use emeralds in the first slot and emerald blocks in the second. Use as many whole blocks as fit while keeping at least one emerald in the first slot and at most 64 items in either slot. Recompute the effective total after first-slot rounding, and check purchasing and sale eligibility separately.

### Equipment manufacturing floors

For the audited craftable equipment, take the lower available ingredient estimate per unit between the candidate retail quote and the archived acquisition reference. Use the effective Iota recipe and count its yields. Set the provisional manufacturing floor to ceil(ingredient estimate + 1 emerald). Apply it to both the retail base and any approved craftable equipment purchase payout, including explicit quotes. Then reapply the retail discount margin against the updated bid. The 1-emerald increment is a candidate craft allowance. The reference represents independently acquired materials, so buying all inputs at retail can still result in a loss.

| Product | Inputs at discovery references | Inputs using available merchant sale quotes, with references for the rest | Revised purchase payout, where eligible | Minimum effective retail payment |
| --- | ---: | ---: | ---: | ---: |
| Iron Axe | 6.26 | 15.48 | 8 | 9 |
| Iron Shovel | 2.15 | 5.23 | 4 | 5 |
| Leather Boots | 1.21 | 4.50 | 3 | 4 |
| Bow | 0.53 | 1.47 | 2 | 3 |
| Crossbow | 3.57 | 7.27 | 5 | 6 |
| Diamond Chestplate | 128.00 | 272.00 | — | 129 before enchantment premiums |

The Iron Shovel sale base rises from 7 to 9 so the Hero V payment stays above the revised payout of 4. The Iron Axe sale base rises from 17 to 19 so the Hero V payment rises from 8 to 9. The purchase eligibility of these items continues to follow their profession contracts.

The Netherite Chestplate route consumes a Diamond Chestplate, a Netherite Ingot and a Netherite Upgrade Smithing Template. For a player who already has a template, vanilla duplication prices the replacement at seven diamonds plus one Netherrack. This gives an estimated ingredient cost of 512.45 emerald equivalents at reference values, or 818.04 when the diamonds, Netherite Scraps and Gold Ingots use candidate merchant quotes and Netherrack uses its reference. These are alternate acquisition scenarios. The costs of the initial template and any enchanting work are separate.

The stock figures below remain the capacity targets. Eight-ingot retail lots yield two uses for Armorer, four for Toolsmith and eight for Weaponsmith. Candidate stock for a Master Diamond or Netherite Scrap sale is one use per refill. Keep ordinary equipment at two uses pending replenishment checks.

| Smith | Metal units bought per refill | Metal units sold per refill |
| --- | ---: | ---: |
| Armorer | 128 | 16 |
| Toolsmith | 64 | 32 |
| Weaponsmith | 32 | 64 |

### Candidate manufacturing stock and native trade checks

| Purchase contract | Candidate uses per refill | Units accepted per refill, no Hero | Units accepted per refill, Hero V | Maximum emerald payout per refill |
| --- | ---: | ---: | ---: | ---: |
| Cooked Cod or Cooked Salmon | 4 | 4 | 4 | 4 |
| Eye of Ender | 2 | 2 | 2 | 18 |
| Regular Tipped Arrow, per eligible effect | 2 | 16 | 8 | 10 |

The limits apply per drawn contract. A single retail lot of four raw fish can use a full cooked-fish purchase refill. Two Eye of Ender uses allow up to 8 emeralds of modeled manufacturing margin under Hero V when both ingredients are bought at the tested prices. Two tipped-arrow purchase uses cover one potion's eight-arrow output under Hero V. Selling a full three-potion batch then needs two replenishments after using a fully stocked buyer, or multiple buyers. This limits throughput while preserving the approved offers and payments.

An isolated Java 1.21.11 server confirmed four injected offers through the native merchant menu under Hero V with demand set to 12 and priceMultiplier set to zero. The eight-ingot Gold Ingot sale accepted five emeralds plus seven emerald blocks. The bulk Gold Ingot purchase accepted 29 ingots and paid 27 emerald blocks. Cooked Cod accepted one fish per use and exhausted all four uses. The regular Weakness Tipped Arrow purchase accepted four arrows per use and stopped after two uses despite a supply of 24. These probes validate native transactions and per-offer limits. The generated catalogs, other modifiers and the Iota replenishment schedule still require integration checks.

Stock and transaction lots are separate. The table and ordinary gear stock of two are working estimates. The ordinary replenishment candidate uses 60 loaded minutes with work access. One completed local sleep may credit 30 minutes after 15 loaded minutes, once per cycle, with a 30-minute overall minimum. Special Master stock and timing need review. Restocking preserves enchantments. Test with World enabled and disabled. Shared demand, absent-time banking, repeated-nap refill and jobsite replenishment are excluded.

Candidate market Echo Shard reference4VU. Recovery Compass uses8shards plus
Compass and the original craft allowance, and is sold one at a time. Reprice its
purchase as well. The independent item-value matrix remains unchanged.




## Reputation and maintenance access

The former post-Master unlock used 450 cumulative merchant XP, reputation of at least 20 and either local raid defense or curing that villager. Those conditions belong to the former Secret design. The five-level trade progression uses career levels. Preserve discovery as an access route for Mending and review its availability across professions and rewards.




## Regional economy

The initial matrix has11resource regions and 149profession/product associations.
Preferences describe item types and local palettes, not certified origin or
permanent exclusivity. Local cultivation and teleportation remain valid supply.
Unclassified biomes and Nether/End careers stay ordinary-only for this prototype.

Draw regional counts and unlocks independently, once. Exclude ordinary and
regional duplicates before committing a full plan. Where fewer valid candidates
exist, limit the allowed draw BEFORE selection; do not silently discard a slot.
Current concrete palettes cover Mason, Farmer, Shepherd, Butcher, Fisherman,
Cleric and Leatherworker. The other professions await useful specialties.

Initial settlement model: a stable first-workstation anchor, nearest same-region
anchor within64 horizontal/32 vertical blocks, ties by persistent ID. Regional
offers remain tied to that identity and require the current workstation inside
its original bounds and region. Moving a merchant never redraws its catalog;
ordinary offers persist. This is a design model, not vanilla village detection.

Imports may pay above origin retail: candidate premium25%, at least+1 emerald
per lot after encoding. Stock up to16 units per loaded hour, no sleep bonus.
Require a priced source sale; six unpriced candidates are excluded from the
current experiment. Profit after travel is not guaranteed. No shared demand.




## Research evidence

The six-level benchmark, native ItemCost and qualification tests, identity tests, economic simulations and biome samples are indexed in [Research](../research_index.md). See the [evidence summary](../../release_checklist.md#automated-research-evidence--2026-11-20) for scope and the [checklist](../../release_checklist.md#trading-redesign--checks-still-needed) for remaining checks.




## Artisan equipment enchantments

Use the [shared Iota classification](../../design_directions.md#shared-enchantment-classification).

The reference averages the maximum useful, mutually compatible enchantment count per family, excluding curses and giving material variants no extra weight. The 12 families are Sword, Spear, Axe, Pickaxe, Shovel, Hoe, Helmet, Chestplate, Leggings, Boots, Bow and Crossbow. The mean is 5.1667 and the median is 5. The commercial cap is floor(1.20 × mean) = 6. Animal armor is sold unenchanted in the validated catalogs and is omitted from the reference. See the [research output](../research/outputs/enchantment-reference-2026-11-22/reference.md) for the per-family data. The calculator and saved evidence retain a historical note about a Master guarantee. The progression below supersedes that note.

| Quantity | Range |
| --- | --- |
| Few | 1–2 |
| Some | 2–4 |
| Many | 4–6 |

Use the smaller of the drawn count and the offer's capacity for useful, compatible enchantments. Check the equipment, profession, eligible categories and incompatibilities together. A small pool may yield a complete combination. Do not compensate with Treasure or forced maximum levels.

| Maximum | Low potency | Medium potency | High potency |
| --- | --- | --- | --- |
| I | I | I | I |
| II | I | I–II | II |
| III | I | II | III |
| IV | I–II | II–III | III–IV |
| V | I–II | II–IV | IV–V |

These potency bands are the working reference. Single-level effects still follow category access rules.

| Tool stage | Materials | Quantity and potency | Categories |
| --- | --- | --- | --- |
| Journeyman | Copper, Iron, Gold | Few, low | Basic and/or Situational |
| Expert | Iron, Gold, Diamond | Some, medium | Basic, Advanced and/or Situational |
| Master | Diamond, Netherite | Some, high | Basic, Advanced and/or Treasure. Situational may accompany other categories. |

For enchanted equipment sold by Toolsmith, Weaponsmith, Armorer and Fletcher, use Few at Journeyman and Some at both Expert and Master. Potency is low, medium and high, respectively. With the commercial cap of 6, Few draws from 1 to ceil(6/3), and Some draws from ceil(6/3) to ceil(2×6/3). Apply the offer's compatible capacity limit after the draw.

Master equipment sales have no separate maximum-level or Treasure guarantee. Each piece sold may have at most one Treasure enchantment.

See the [profession catalog](trading_profession_catalog_draft.md) for the shared sword/crossbow chance rule.




## Equipment purchase contracts

For equipment purchase contracts with a qualifying low-potency Basic enchantment, accept pieces with additional enchantments. Pay the same amount specified by the contract regardless of those additional effects.
## Open decisions

- Calibrate the remaining material-group weights, discounts, prices, lots and stock.




## Decision history

The [22 November snapshot](../research_index.md#backups-anteriores) preserves the six-level catalog, old unlock and draw rules, the fixed three-to-four count, the 65% reference and the withdrawn Master guarantees. The [November 20 execution output](../research/outputs/trading_execution-2026-11-20/) preserves the generated candidates and native evidence. See [Future Directions](../../future_directions.md) for deferred proposals, including enchantment redraw on restock.
