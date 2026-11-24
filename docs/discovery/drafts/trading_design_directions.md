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

The redesign uses five career levels. Former Secret rewards move into the Master review. Redistribution of earlier Journeyman goods and final placement by profession are open.




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




## Enchanted equipment purchases

Buy equipment only at full durability. Expert equipment contracts use Basic enchantments up to level II, so I and II are eligible. Plain equipment has no gameplay enchantments. Decide whether equipment with eligible effects plus higher-level or other effects qualifies, and which effects the payout values.

Where Master reuses an Expert purchase pool, remove the selected option before the second draw. Confirm where this excludes the entire equipment branch or only the selected contract. Preserve item data and protect rejected items from consumption.




## Working price and stock calibration

The Expert sale slot for Toolsmith, Armorer and Weaponsmith may offer Copper, Iron or Gold Ingots instead of equipment. Exclude metals already offered for sale.

Use 1 VU = 1 emerald provisionally. The initial 95% payout and 105% retail targets are starting points; manufacturing floors and resale checks can raise prices. Then
validate the actual integer lots. Ordinary purchase inputs use one item stack,
not1+remainder. Payouts above64 use the approved nearest safe multiple of9;
retail payments fit the two input slots. Whole-unit rounding can create a much
larger spread than the nominal target. Current prices also apply a manufacturing floor and a positive ordinary resale margin. Hero discounts remain a reviewable exception; they can permit profitable resale within stock limits.

| Smith | Metal units bought per refill | Metal units sold per refill |
| --- | ---: | ---: |
| Armorer | 128 | 16 |
| Toolsmith | 64 | 32 |
| Weaponsmith | 32 | 64 |

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

The reference averages the maximum useful, mutually compatible enchantment count per family, excluding curses and giving material variants no extra weight. The 12 families are Sword, Spear, Axe, Pickaxe, Shovel, Hoe, Helmet, Chestplate, Leggings, Boots, Bow and Crossbow. The mean is 5.1667 and the median is 5. The commercial cap is floor(1.20 × mean) = 6. Animal armor awaits functional validation and is omitted from the reference. See the [research output](../research/outputs/enchantment-reference-2026-11-22/reference.md) for the per-family data. The calculator and saved evidence retain a historical note about a Master guarantee. The progression below supersedes that note.

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

Review how this progression maps to each profession, especially ranged weapons, leather and animal armor. Master has no separate maximum-level or Treasure guarantee. Keep the earlier at-most-one-Treasure limit as a working constraint pending confirmation. The [archived artisan rules](../research_index.md#backups-anteriores) record the prior limit. Netherite draw weights remain open.

See the [profession catalog](trading_profession_catalog_draft.md) for the shared sword/crossbow chance rule and animal armor validation.




## Open decisions

- Set eligibility and payout for equipment with mixed enchantments. The older minimum/OR POC accepted higher and additional effects, while the current Expert design specifies Basic I–II. Decide whether Master excludes only the selected offer or its entire equipment branch.
- Confirm the single-Treasure limit and animal armor eligibility after testing effects. Set Netherite, Mending and material-group weights along with discounts, prices, lots and stock.




## Decision history

The [22 November snapshot](../research_index.md#backups-anteriores) preserves the six-level catalog, old unlock and draw rules, the fixed three-to-four count, the 65% reference and the withdrawn Master guarantees. The [November 20 execution output](../research/outputs/trading_execution-2026-11-20/) preserves the generated candidates and native evidence. See [Future Directions](../../future_directions.md) for deferred proposals, including enchantment redraw on restock.
