# Economy discovery — Iota Java 1.21.11

Status: **initial research; no approved trade prices or profession changes**. Prepared 2026-11-19 against the current Iota base 1.0.34 source. Tool Mastery and Magical Discovery remain frozen optional expansions, outside the base recipe graph. This document is intentionally separate from Trading Design Directions and Design Directions.

## Read this first

The deliverable is an auditable starting matrix, not a claim that every playstyle is already balanced. It covers **1505 item IDs**, proposes **1383 base values**, explicitly excludes **122 technical/unobtainable or special-identity IDs**, and traces **1664 effective recipe definitions**. There are **319 additional component variants**, **39 illustrative activity scenarios**, and **351 mechanical sensitivity cases**.

Recipe definitions, stack limits, enchantment caps and native components come from source data. **All monetary anchors, production rates, capital estimates, labour allowances and enchantment premiums are research hypotheses. No production rate was measured for this initial matrix. Later farm measurements and simulations are documented separately in the research reports.** The comparable incomes in some scenarios partly result from deliberately calibrated assumptions; they are not independent evidence of balance.

The central result is structural: a single unlimited unit-price list cannot give equal income to both hand gathering and arbitrarily scaled automation. A useful next audit must compare investment, active effort, elapsed time, risk and market absorption together. Renewable does not automatically mean cheap to obtain; nonrenewable does not automatically mean difficult to collect in bulk.

## Files and workbook

- The Excel workbook contains Overview, Items, Activities, Parameters, Baskets, Recipes, Variants, Sensitivity, Quotes, PricePressure, Acquisition, Audit and Sources.
- `item-values.csv`: every registry ID, proposed value, group, acquisition/recipe basis, confidence, stack size, component flag, durability and repair reference.
- `recipe-paths.csv` / `recipes.json`: every effective definition, ingredient alternatives, selected inputs, yield, processing allowance and reversible-route flag.
- `component-variants.csv`: 128 enchantment-level book variants, potion forms/effects, and seven example enchanted tools. This does not enumerate infinitely many possible item component combinations.
- `activities.csv` and `activity-baskets.csv`: throughput, inputs, outputs, capital, wear, XP opportunity cost and both income measures.
- `sensitivity.csv` and `sensitivity-summary.csv`: explicit stress scenarios; not confidence intervals.
- `activity-price-pressure.csv`: the primary-output value that would meet the active-income target if every other price, cost and rate stayed fixed. This is a linked-price audit starting point, not a set of independent prices ready to adopt.
- `integer-quotes.csv` and `denomination-audit.json`: denomination/stack diagnostics, not a configured trade catalog.
- `audit-findings.csv`: route losses, dynamic recipes, activity gaps and currency rounding issues.
- `item-source-coverage.csv` and `loot-source-occurrences.csv`: a structural acquisition index spanning 1337 effective loot tables, 2593 item occurrences and 1234 item IDs with at least one indexed occurrence. The other 271 IDs are not thereby unobtainable: recipes, growing, interactions, native trades and implicit drop paths are separate. Conditions and local pool weights are retained, not flattened into false unconditional probabilities.
- `validation.json`, `workbook-validation.json` in the workbook output directory, and `runtime-source-manifest.json`: scope checks, formula tests and reproducibility references.

In Excel, yellow cells are proposed editable inputs. Activity baskets and income calculations respond to item/variant values. Recipe selection, derived item values and the Audit sheet are a **frozen snapshot**: changing an input does not rerun the recipe optimizer or rebuild audit flags. Rebuild the research to propagate alternative recipe choices. Sensitivity changes hold activity time and capital fixed; a doubled throughput may be physically impossible.

## Units and comparison targets

**VU** means research value unit. The workbook starts with 1 VU per Emerald solely as an illustrative denomination. **This is not a recommendation that 480 Emeralds per hour should be the intended income.** Changing the exchange scale changes nominal Emerald prices; it does not solve relative-value problems. The Emerald item follows that definition in the workbook. Rebuilding the recipe graph is needed to propagate currency changes into any recipe involving Emeralds.

The comparison target is 480 VU per active hour for an established setup, with explicit stage factors: Early 0.5×, Established 1×, Advanced 2×, Industrial 4×. These factors represent a hypothesis that investment should have a return; they are not approved progression gates or a required playstyle. The review band 0.67–1.5× is only a way to find mismatches, not a selected final tolerance.

Two measures are necessary:

1. **Net/world-hour:** revenue minus input opportunity value, wear, capital allowance and XP cost in one real elapsed hour of operation.
2. **Net/active-hour:** that net divided by the fraction of the hour spent actively operating, collecting or maintaining the setup.

An automated farm requiring ten active minutes is not six times faster in world time merely because its active-hour return is multiplied by six. Idle waiting, loaded chunks, server capacity and the possibility of running several farms concurrently remain separate constraints. Capital is charged as an explicit allowance over an assumed number of operating hours; it is not a measured depreciation law. Resale value, construction labour and location scarcity are not fully priced.

## How base values were derived

1. Read the official 1.21.11 item registry and all vanilla recipes. Apply current base-module resource filters and recipe overrides, then include Iota additions.
2. Resolve item-tag alternatives using official tags and current base overlays. The captured graph has zero unresolved ingredient tags. A validator independently reconstructs the effective recipe set and compares every definition.
3. Propose low-confidence acquisition anchors for items obtained through the world, entities, exploration or special systems. These anchors are explicit design inputs, not market observations.
4. Relax recipe routes toward the cheapest resolved input combination, plus stated active handling and fuel allowances. A more expensive alternative route does not raise the reference when a cheaper route exists.
5. Detect strongly connected single-input transformation groups and suppress intrinsic work premiums on reversible commodity conversions. Validate important Iota slab/stair, wool/string, leather/hide and ice round trips.
6. Supplement ordinary recipes with manual world transformations such as stripping, concrete hardening, bucket filling/capture and copper oxidation. Passive oxidation receives no automatic time premium. These transformations are incomplete and flagged as manual assumptions.

The graph contains 1,634 fixed-output routes and 30 dynamic/manual definitions. Dynamic crafting, copying, trimming and component-sensitive operations require separate rules. The single-input connectivity analysis and bounded recipe checks are **not a mathematical proof against every possible multi-input, loot or world-mechanic arbitrage cycle**.

Active-work allowances are 0.4 seconds per bulk crafting operation, six seconds per nonstackable craft, 0.15 seconds per stonecutting operation, 0.2 active seconds per smelted item, and ten seconds per smithing operation. Fuel allowance is 0.025 VU per smelt. These are deliberately exposed assumptions. Parallel furnace time is not charged as though the player personally works through every furnace tick. Recipe-grid steps alone do not earn a proportional markup.

Returned containers are credited where represented: bucket remainders for consumed milk/water/lava buckets, and glass bottles for consumed honey/dragon-breath containers. Filled containers, captured creatures, bees, map destinations, written contents and storage inventories need identity-aware rules. Their empty base ID is not a sufficient quote.

## Representative base references

Values below are rounded for reading; the workbook keeps more precision for arithmetic. Extra decimals do not imply measured certainty. Full equipment durability is assumed. Component premiums are additional.

| Item | Proposed VU | Selected basis / route | Scope |
|---|---:|---|---|
| Cobblestone | 0.031 | Proposed acquisition anchor | Base / full durability |
| Sand | 0.031 | Proposed acquisition anchor | Base / full durability |
| Oak Log | 0.25 | Proposed acquisition anchor | Base / full durability |
| Oak Planks | 0.076 | oak_planks | Base / full durability |
| Stick | 0.051 | stick | Base / full durability |
| Bamboo | 0.006 | Proposed acquisition anchor | Base / full durability |
| Sugar Cane | 0.063 | Proposed acquisition anchor | Base / full durability |
| Wheat | 0.125 | Proposed acquisition anchor | Base / full durability |
| Carrot | 0.063 | Proposed acquisition anchor | Base / full durability |
| Potato | 0.063 | Proposed acquisition anchor | Base / full durability |
| Coal | 0.5 | Proposed acquisition anchor | Base / full durability |
| Charcoal | 0.302 | charcoal | Base / full durability |
| Flint | 0.25 | Proposed acquisition anchor | Base / full durability |
| Raw Copper | 0.5 | Proposed acquisition anchor | Base / full durability |
| Copper Ingot | 0.552 | copper_ingot_from_blasting_raw_copper | Base / full durability |
| Raw Iron | 2 | Proposed acquisition anchor | Base / full durability |
| Iron Ingot | 2.052 | iron_ingot_from_blasting_raw_iron | Base / full durability |
| Raw Gold | 4 | Proposed acquisition anchor | Base / full durability |
| Gold Ingot | 4.052 | gold_ingot_from_blasting_nether_gold_ore | Base / full durability |
| Diamond | 16 | Proposed acquisition anchor | Base / full durability |
| Ancient Debris | 64 | Proposed acquisition anchor | Base / full durability |
| Netherite Scrap | 64.052 | netherite_scrap | Base / full durability |
| Netherite Ingot | 272.467 | netherite_ingot | Base / full durability |
| Leather | 0.302 | iota_recipes:rotten_flesh_leather | Base / full durability |
| Rabbit Hide | 0.075 | iota_recipes:rabbit_hide_from_leather | Base / full durability |
| Rotten Flesh | 0.25 | Proposed acquisition anchor | Base / full durability |
| White Wool | 0.5 | Proposed acquisition anchor | Base / full durability |
| String | 0.125 | iota_recipes:wool_to_string | Base / full durability |
| Paper | 0.08 | paper | Base / full durability |
| Book | 0.596 | book | Base / full durability |
| Glass | 0.083 | glass | Base / full durability |
| Glass Bottle | 0.101 | glass_bottle | Base / full durability |
| Chest | 0.513 | iota_recipes:chest_from_logs | Base / full durability |
| Hopper | 10.825 | hopper | Base / full durability |
| Repeater | 0.625 | iota_recipes:repeater_from_parts | Base / full durability |
| Comparator | 1.145 | iota_recipes:comparator_from_parts | Base / full durability |
| Dispenser | 0.979 | iota_recipes:dispenser_from_dropper | Base / full durability |
| Observer | 0.991 | observer | Base / full durability |
| Redstone Lamp | 1.553 | iota_recipes:redstone_lamp_from_dust | Base / full durability |
| Iron Pickaxe | 7.058 | iron_pickaxe | Base / full durability |
| Golden Pickaxe | 13.058 | golden_pickaxe | Base / full durability |
| Diamond Pickaxe | 48.903 | diamond_pickaxe | Base / full durability |
| Netherite Pickaxe | 434.796 | netherite_pickaxe_smithing | Base / full durability |
| Copper Spear | 1.454 | copper_spear | Base / full durability |
| Iron Spear | 2.954 | iron_spear | Base / full durability |
| Diamond Spear | 16.903 | diamond_spear | Base / full durability |
| Shield | 3.307 | shield | Base / full durability |
| Iron Chestplate | 16.413 | iron_chestplate | Base / full durability |
| Diamond Chestplate | 128.8 | diamond_chestplate | Base / full durability |
| Netherite Chestplate | 514.693 | netherite_chestplate_smithing | Base / full durability |
| Ice | 0.125 | Proposed acquisition anchor | Base / full durability |
| Packed Ice | 1.125 | packed_ice | Base / full durability |
| Blue Ice | 10.125 | blue_ice | Base / full durability |
| Elytra | 384 | Proposed acquisition anchor | Base / full durability |
| Trident | 96 | Proposed acquisition anchor | Base / full durability |
| Mace | 264.8 | mace | Base / full durability |
| Enchanted Golden Apple | 256 | Proposed acquisition anchor | Base / full durability |
| Shulker Shell | 8 | Proposed acquisition anchor | Base / full durability |
| Bundle | 1.227 | bundle | Base item only |

The explicit original anchor and selected route are both retained. Leather begins with an acquisition anchor of 1 VU, but Iota's Rotten Flesh route lowers its selected reference to approximately 0.302 VU. String similarly drops from a 0.25 VU acquisition anchor to 0.125 VU through wool recovery. Ignoring those alternatives would overpay the same commodity depending on how it was produced.

## Representative crafting paths

- **Repeater:** 3 redstone + 2 stick + 3 stone → 1 item(s). Batch input 0.571 VU + active-work allowance 0.053 VU + fuel 0 VU. Selected unit reference **0.625 VU**. Route: `iota_recipes:repeater_from_parts`.
- **Comparator:** 3 redstone + 3 stick + 2 stone + 1 quartz → 1 item(s). Batch input 1.091 VU + active-work allowance 0.053 VU + fuel 0 VU. Selected unit reference **1.145 VU**. Route: `iota_recipes:comparator_from_parts`.
- **Dispenser:** 1 dropper + 3 stick + 3 string → 1 item(s). Batch input 0.926 VU + active-work allowance 0.053 VU + fuel 0 VU. Selected unit reference **0.979 VU**. Route: `iota_recipes:dispenser_from_dropper`.
- **Leather:** 1 rotten_flesh → 1 item(s). Batch input 0.25 VU + active-work allowance 0.027 VU + fuel 0.025 VU. Selected unit reference **0.302 VU**. Route: `iota_recipes:rotten_flesh_leather`.
- **Bundle:** 1 string + 1 leather → 1 item(s). Batch input 0.427 VU + active-work allowance 0.8 VU + fuel 0 VU. Selected unit reference **1.227 VU**. Route: `minecraft:bundle`.
- **Diamond Pickaxe:** 3 diamond + 2 stick → 1 item(s). Batch input 48.103 VU + active-work allowance 0.8 VU + fuel 0 VU. Selected unit reference **48.903 VU**. Route: `minecraft:diamond_pickaxe`.
- **Netherite Pickaxe:** 1 netherite_upgrade_smithing_template + 1 diamond_pickaxe + 1 netherite_ingot → 1 item(s). Batch input 433.463 VU + active-work allowance 1.333 VU + fuel 0 VU. Selected unit reference **434.796 VU**. Route: `minecraft:netherite_pickaxe_smithing`.

The selected ingredient alternative is a snapshot, not a requirement that a player must use that material. Raw input opportunity cost is charged even when the player collected it themselves. Otherwise gathering plus crafting would be credited twice and crafting would appear artificially profitable.

## Equipment, repairs and components

Equipment values include materials and proposed handling. Wear uses current Iota handheld durability where applicable; native durability is kept elsewhere. The activity model uses the cheaper provisional replacement/material-repair cost per durability point, **excluding repair XP, repair handling and partial-repair waste**. It is therefore an optimistic operating-cost estimate, not the final cost of maintaining a named enchanted tool.

Tools changes relevant here include wooden/stone recipe inputs, Stick/Flint repair ingredients, Netherite Scrap repair for managed Netherite tools, clearing prior-work penalties for the managed scope, and the reduced enchantment application costs. **A repair unit still restores the vanilla quarter-durability amount**, not a full repair. Armor, bows and other items must not silently inherit the managed-tool repair rules. Netherite remains a useful maintenance sensitivity case; Mending or reusable enchantment retention changes lifetime economics without changing the base crafting bill.

For an arbitrary enchanted item, start from the appropriate base equipment, then examine supported enchantments, actual levels, exclusivity and source costs. The sample book schedule doubles premiums per level as an initial hypothesis; it is not validated acquisition economics. Mending has a proposed 128 VU premium, Silk Touch 64 VU, and Efficiency/Unbreaking start at 8 VU. Curse premiums are zero in this first pass; no collector market is assumed. Seven equipment examples add an 8 VU application allowance. Multiple enchantments must not automatically add every premium if a cheaper combined-book or table route exists. Incompatible or unobtainable combinations are not valid ordinary market stock.

Potions use a manually reconstructed three-bottle brewing model, Blaze Powder fuel allocation, reagent cost and proposed handling. Luck variants remain unpriced. Potion effects, duration, strength, splash/lingering form and tipped-arrow output require component-aware matching. This supplement needs an in-game route audit; it is not extracted from the ordinary recipe registry.

Other required future valuation rules include contents of bundles/shulkers, written books, exploration maps, firework effects, trims, dyed items, banners, Ominous Bottle levels, bee contents, captured mobs and damaged equipment. Tool Mastery XP, history and player sentimental value are not fungible commodity premiums in this discovery. Free mastery rewards and the availability of discovered enchantments would need a separate optional-expansion scenario before applying these premiums to a world using those expansions.

## Activity comparisons

Every rate below is a **synthetic scenario**, including exceptionally high industrial throughput. These figures describe what the assumptions imply, not what was observed in a world. They assume all output finds a buyer at reference value. Actual market demand and available working capital can sharply reduce realizable income.

| Activity | Stage | Active min / world h | Net VU / world h | Net VU / active h | Active target ratio |
|---|---|---:|---:|---:|---:|
| Manual timber and replanting | Established | 60 | 422 | 422 | 0.88× |
| Stone mining with iron equipment | Established | 60 | 60.8 | 60.8 | 0.13× |
| Sand extraction | Established | 60 | 108.4 | 108.4 | 0.23× |
| Mixed ore caving | Established | 60 | 458.6 | 458.6 | 0.96× |
| Iron-focused mining and smelting | Established | 60 | 451 | 451 | 0.94× |
| Diamond expedition with developed equipment | Advanced | 60 | 836.1 | 836.1 | 0.87× |
| Ancient Debris expedition | Advanced | 60 | 620.9 | 620.9 | 0.65× |
| Nether quartz gathering | Established | 60 | 456.6 | 456.6 | 0.95× |
| Grass and flower foraging | Early | 60 | 92 | 92 | 0.38× |
| Established wheat agriculture | Established | 60 | 504.3 | 504.3 | 1.05× |
| Established carrot agriculture | Established | 60 | 474.3 | 474.3 | 0.99× |
| Established potato agriculture | Established | 60 | 476.3 | 476.3 | 0.99× |
| Cocoa production | Established | 60 | 475.3 | 475.3 | 0.99× |
| Sugar cane collection | Established | 60 | 474.3 | 474.3 | 0.99× |
| Wool production and shearing | Established | 60 | 463.9 | 463.9 | 0.97× |
| Animal-food production | Established | 60 | 308.8 | 308.8 | 0.64× |
| Manual fishing with ordinary equipment | Early | 60 | 136.3 | 136.3 | 0.57× |
| Archaeology expedition | Established | 60 | 274.4 | 274.4 | 0.57× |
| Ancient City loot expedition | Advanced | 60 | 745.3 | 745.3 | 0.78× |
| End exploration | Advanced | 60 | 992.4 | 992.4 | 1.03× |
| Trial exploration and rewards | Advanced | 60 | 872.6 | 872.6 | 0.91× |
| Blaze combat production | Established | 60 | 501.4 | 501.4 | 1.04× |
| Mixed mob farm | Advanced | 15 | 646.1 | 2,584.6 | 2.69× |
| Established iron farm | Advanced | 10 | 1,478.3 | 8,870.1 | 9.24× |
| Large iron infrastructure | Industrial | 10 | 12,445.1 | 74,670.9 | 38.89× |
| Gold infrastructure | Industrial | 15 | 6,345.4 | 25,381.5 | 13.22× |
| Bamboo infrastructure | Advanced | 10 | 279.1 | 1,674.9 | 1.74× |
| Sugar cane infrastructure | Advanced | 10 | 969.1 | 5,814.9 | 6.06× |
| Gunpowder infrastructure | Industrial | 15 | 2,939.1 | 11,756.6 | 6.12× |
| Rotten Flesh leather processing | Established | 8 | 55.9 | 419.2 | 0.87× |
| Glass production | Established | 60 | 55.9 | 55.9 | 0.12× |
| Raw Iron smelting service | Established | 60 | 55.9 | 55.9 | 0.12× |
| Repeater manufacturing | Established | 8 | 54.3 | 407.1 | 0.85× |
| Dispenser manufacturing | Established | 4 | 22.3 | 334.3 | 0.7× |
| Iron Pickaxe manufacturing | Established | 60 | 470.3 | 470.3 | 0.98× |
| Diamond Pickaxe manufacturing | Established | 60 | 458.3 | 458.3 | 0.95× |
| Wooden-stair preparation | Established | 10 | -4.9 | -29.4 | -0.06× |
| Fire Resistance brewing | Established | 15 | 109 | 435.8 | 0.91× |
| Efficiency III book application | Established | 25 | 254.5 | 610.9 | 1.27× |

### What these scenarios suggest

- Manual timber, mixed caving, established crops, shearing and tool assembly can be placed in the same broad range under the chosen assumptions. This is a promising calibration direction, not proof of comparable effort.
- Stone extraction has substantial wear under the iron-tool assumption. A player using Unbreaking, a different material or a more efficient mining pattern changes the comparison. Sand, foraging, ordinary fishing and archaeology need better yield/risk inputs before adjusting their prices.
- For example, at the conservative unmeasured scenarios of 3,000 Stone blocks/h and 4,500 Sand/h, the current 0.03125 VU terrain reference underpays gathering. Holding other terms fixed, the pressure calculation suggests roughly 0.171 VU per Cobblestone and 0.114 VU per Sand to meet the established target. Those are candidate revisions for audit, not changes silently propagated into building costs. Better equipment and different yields would change both candidates.
- Exploration has uneven and finite jackpots. Average income alone hides long empty stretches, travel time and the shrinking local supply of unopened structures. Map knowledge and rare discovery rewards may have value beyond resale; no probability distribution is established here.
- Simple smelting and redstone assembly have small margins per elapsed hour when material input is already valued. Reclassifying waiting time as active labour creates a misleading comparison; measure batch loading, collection and transport separately. High input-markup stress can wipe out these margins.
- Producing 600 Diamond Pickaxes per hour implies 1,800 Diamonds of hourly input and 600 buyers. This is an arithmetic capacity scenario, not a plausible baseline supply or demand claim. Nonstackable storage and selling time are material bottlenecks.
- Reversible building shapes cannot receive a guaranteed positive intrinsic markup in both directions. Preparing stairs may be useful work, but the same block cannot become more valuable on every cut/recovery loop. Any later service compensation would be a separate mechanism, not an approval in this matrix.
- Large iron/gold farms dominate both elapsed and active income under unlimited purchasing. Capital allowances alone do not remove this scaling advantage. Limiting how much one buyer absorbs may help, but adding more buyers can recreate scale; that policy belongs in a later market audit, not in this profession-free matrix.
- Regional scarcity and transport may support a logistics playstyle, but biome premiums without actual transport constraints can collapse under cheap teleportation. No distance premium or regional price system is selected here.

## Currency, conversion and arbitrage diagnostics

The first-pass whole-Emerald illustration finds **122 base references** with more than 20% rounding distortion at the simple one-Emerald/one-item heuristic. Enumerating every valid item lot with a payment of at most 64 Emeralds reduces the unresolved rounding cases to **16 references**. Separately, **52 references** cost more than a single 64-Emerald payment stack. The optimized lot columns are a frozen snapshot, whereas the simple quote formulas recalculate in Excel. This does not mean every reference should become a trade, or that a one-stack failure is impossible with multiple payment slots or another denomination. Cheap nonstackables and high-priced treasures need deliberate lot/denomination handling. Two item-payment slots do not provide arbitrary fractional change.

The +15% input-price stress is a diagnostic, **not an approved trading spread**. A market would eventually need separate purchase and sale prices; otherwise any two-way commodity conversion can become free credit or an exploit after integer rounding. Test both directions and all cross-market loops after actual offers exist.

Important checked relationships:

- 1 Blue Ice = 9 Packed Ice = 81 Ice, with equal recoverable material reference value.
- 2 matching slabs or stairs recover their parent block without increasing reference value.
- Wool/String and Leather/Rabbit Hide conversions do not gain value on a round trip.
- The selected route for every priced fixed-output recipe is bounded by selected inputs plus the stated processing/fuel allowance. The audit currently has zero such arithmetic inconsistencies.

Piglin barter is also a source of multiple commodities. The official captured weighted table produces a model expected basket of **4.208 VU** per Gold Ingot valued at **4.052 VU**. The book/boot enchantment-level premium mixture is assumed uniform and has not been independently verified. Travel, safety, equipment and market absorption are omitted. This is an expected-value diagnostic, **not a confirmed profitable guaranteed loop**. Its sensitivity to enchantment premiums shows why isolated commodity prices are insufficient.

Further loops still require explicit testing: Fortune/Silk Touch block conversion; breaking crafted ore/mineral blocks; composting and bone-meal plant growth; mob loot with Looting; fuel selection and Lava Buckets; furnace XP; fishing treasure; villager discounts/cure/reputation; renewable shulker shells; raid output; duplication/copying special recipes; book combining; grindstone XP; enchantment-table outcomes; trial/vault restrictions and optional expansions. Renewable labels are coarse source notes, not a rigorously proven classification of every renewable path. For example, global accessibility through wandering trades is not the same thing as convenient local bulk production.

## World and Hearts interactions

World changes the sky clock, with one real hour each for day and night. **Do not multiply all crop or furnace rates by six:** random ticks and furnace ticks are separate from the visible day cycle. Villager work schedules, daily restock caps and daylight-dependent operations can be affected differently. The interaction between the prolonged cycle and trading restocking remains an explicit in-game measurement requirement.

Sleep skips clock time and clears weather; it does not mean the skipped hours automatically produce crops or items. Hearts' 25% XP death escrow is not a guaranteed permanent 25% loss on every expedition: recoverable XP remains recoverable until forfeited under its actual rules. Expected XP loss, detours and reduced maximum health are separate risk costs. None is silently included as a flat commodity surcharge.

## Next audit sequence

1. **Confirm scope and scale.** Audit the technical exclusions, component categories, VU denomination and the intended meaning of comparable income. Keep profession offers unchanged during this step.
2. **Measure five contrasting baselines.** Timber, mixed mining, crops, simple manufacturing and a modest automated farm; then add exploration and a large farm. Use the same real-time basis and record equipment, enchantments, Fortune/Silk, difficulty, seed/biome and loaded-chunk conditions.
3. **Separate setup and operation.** Record build/travel time, capital consumed, reusable capital, active operation, waiting, tool wear, food, fuel, XP and net output. Record unsold output rather than pretending everything was purchased.
4. **Repeat, then revise.** At least three sessions per benchmark, retaining all raw observations and median/range rather than only the best run. No fixed precision or confidence interval should be claimed before those observations exist.
5. **Audit transformations.** Expand world/loot/brewing/component routes, then run integer buy/sell-cycle checks with candidate spreads and demand. Re-audit optional-expansion scenarios separately.
6. **Only then map to professions.** Keep thematic eligible bands separate from individual RNG outcomes. This economic discovery does not override the approved Toolsmith design or its tier-coherence rule.

Recommended measurement record: session ID, real start/end, active seconds, game ticks/TPS, module set, location/route, equipment/components, start/end XP points, inputs consumed, outputs obtained, items unsold, durability spent, setup costs, travel, failures/deaths and observations. See `benchmark-session-template.csv`.

## Reproduction and checks

From the project root, use the existing Node runtime; no installation is required:

`node docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/build-discovery.mjs`

`node docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/analyse-discovery.mjs`

`node docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/validate-and-stress.mjs`

`node docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/index-loot-sources.mjs`

`node docs/discovery/research/outputs/trading_economy-discovery-2026-11-19/write-report.mjs`

The source capture `effective-recipes-raw.json` is frozen. The validator independently compares it against current source resources and will fail if they differ; refresh the capture before applying this model to a later Iota version. Rebuilding the workbook additionally requires the bundled spreadsheet runtime used in this session; no package installation was performed. Its local dependency junction is an environment detail, not included in the portable data package.

Automated checks cover exact item/recipe reconciliation, positive finite proposed prices, explicit null exclusions, ingredient tags, recipe cost bounds, activity accounting, key recovery loops and denomination checks. The workbook is recalculated; a test changes Iron Ingot value by 1 VU and checks the resulting 2,400 VU shift in the 2,400-ingot processing scenario, then restores it. Formula-error scanning and visual previews cover every sheet. A separate standard-library XLSX validator checks every exported item price/stack, activity net/ratio, sensitivity case, price-pressure result and simple/optimized quote against the model, and scans all sheets for cached Excel errors. These checks do not replace in-game measurements or prove final economy balance. No Minecraft loading test was run for this research.

## Sources

Primary data is the official generated 1.21.11 registry, recipes, item tags, enchantment definitions and Piglin barter loot table already available in the project, overlaid with current Iota base source. Hashes are recorded in `summary.json` and `runtime-source-manifest.json`. These define source contents, not empirical profitability.

- [Official Java 1.21.11 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-11): version boundary and technical context.
- [Official Java 1.21 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21): data-driven enchantment availability/exclusivity and component-aware source context.
- [Official 1.20.2 pre-release experiment notes](https://www.minecraft.net/en-us/article/minecraft-1-20-2-pre-release-1): experimental trading/loot alternatives are opt-in context, not assumed active in the captured base recipe graph.

No web source is used as evidence for the hypothetical item prices or hourly output rates.

## Group coverage appendix

These are descriptive buckets for sorting research, not approved modules or villager professions. Min/max values include only priced base IDs; specialized components are separate. Coarse groups and renewable labels need manual cleanup as the model matures.

| Group | Registry IDs | Priced IDs | Minimum VU | Maximum VU |
|---|---:|---:|---:|---:|
| Wood products | 168 | 168 | 0.076 | 8.157 |
| Tree products | 20 | 20 | 0.125 | 0.125 |
| Timber | 11 | 11 | 0.25 | 0.375 |
| Crafted utility and decoration | 215 | 215 | 0.036 | 264.438 |
| Building shapes | 129 | 129 | 0.016 | 1.281 |
| Automation | 20 | 20 | 0.136 | 22.683 |
| Excluded technical/unobtainable | 122 | 0 | — | — |
| Flowers | 21 | 21 | 0.25 | 2 |
| Mineral growth | 4 | 4 | 0.25 | 0.5 |
| Minerals | 5 | 5 | 0.063 | 0.5 |
| Nether progression | 1 | 1 | 64 | 64 |
| Common terrain | 11 | 11 | 0.016 | 0.031 |
| Archaeology | 23 | 23 | 8 | 8 |
| Food | 23 | 23 | 0.054 | 9.208 |
| Animal products | 7 | 7 | 0.125 | 8 |
| Mob products | 9 | 9 | 0.12 | 0.91 |
| Storage and containers | 46 | 46 | 0.513 | 18.623 |
| Vegetation | 35 | 35 | 0.063 | 0.5 |
| Fast crops | 1 | 1 | 0.006 | 0.006 |
| Stone and Nether terrain | 7 | 7 | 0.04 | 0.04 |
| Animal habitat | 1 | 1 | 4 | 4 |
| Animal food | 5 | 5 | 1 | 1 |
| Crops | 12 | 12 | 0.031 | 0.25 |
| Seeds | 2 | 2 | 0.031 | 0.031 |
| Village utility | 1 | 1 | 16 | 16 |
| Textiles | 66 | 66 | 0.101 | 6.481 |
| Building materials | 102 | 102 | 0.034 | 2.028 |
| Dyes and inks | 18 | 18 | 0.114 | 0.75 |
| Brewing | 4 | 4 | 0.794 | 4.147 |
| Adventure mob products | 6 | 6 | 2.58 | 8 |
| Smithing templates | 19 | 19 | 112.085 | 120.053 |
| Books and knowledge | 2 | 2 | 0.596 | 0.75 |
| Weapons and shields | 18 | 18 | 0.954 | 418.745 |
| Corals | 30 | 30 | 0.25 | 1 |
| Trial products | 1 | 1 | 8 | 8 |
| Fungi | 5 | 5 | 0.125 | 0.125 |
| Special terrain | 9 | 9 | 0.116 | 0.125 |
| Sculk | 6 | 6 | 0.5 | 8 |
| Found equipment | 12 | 12 | 8 | 96 |
| Metal products | 133 | 133 | 0.061 | 2,452.2 |
| End crops | 4 | 4 | 0.5 | 2 |
| Fuel | 1 | 1 | 0.5 | 0.5 |
| Ore blocks | 18 | 18 | 0.75 | 35.2 |
| Structure materials | 2 | 2 | 0.5 | 2 |
| Fish | 4 | 4 | 0.75 | 2 |
| Productive tools | 28 | 28 | 0.954 | 434.796 |
| Armor | 27 | 27 | 2.007 | 514.693 |
| Oxidation products | 1 | 1 | 6 | 6 |
| Mob trophies | 5 | 5 | 32 | 64 |
| Nether terrain | 4 | 4 | 0.125 | 0.125 |
| Hard terrain | 2 | 2 | 1 | 2 |
| Gems | 1 | 1 | 16 | 16 |
| Exploration treasures | 5 | 5 | 8 | 384 |
| Brewing treasures | 1 | 1 | 8 | 8 |
| Unique trophies | 1 | 1 | 512 | 512 |
| Nether treasures | 1 | 1 | 32 | 32 |
| Renewable minerals | 2 | 2 | 0.125 | 0.25 |
| Currency | 1 | 1 | 1 | 1 |
| XP consumables | 1 | 1 | 4 | 4 |
| Component-sensitive treasures | 2 | 2 | 32 | 32 |
| Component-sensitive fireworks | 1 | 1 | 1 | 1 |
| Tool inputs | 1 | 1 | 0.25 | 0.25 |
| Exploration patterns | 3 | 3 | 16 | 16 |
| Decoration patterns | 1 | 1 | 8 | 8 |
| Nether materials | 1 | 1 | 0.25 | 0.25 |
| Marine treasures | 4 | 4 | 8 | 64 |
| Trial treasures | 3 | 3 | 16 | 256 |
| Food and utility | 1 | 1 | 0.75 | 0.75 |
| Brewing components | 4 | 4 | 0.25 | 0.25 |
| Collectibles | 21 | 21 | 32 | 32 |
| Adventure utility | 1 | 1 | 8 | 8 |
| Boss products | 1 | 1 | 224.5 | 224.5 |
| Brewing crops | 1 | 1 | 0.25 | 0.25 |
| Nether crops | 3 | 3 | 0.125 | 0.5 |
| Mob-linked materials | 4 | 4 | 0.25 | 1 |
| Adventure variants | 1 | 1 | 16 | 16 |
| Exploration seeds | 2 | 2 | 8 | 8 |
| Crop byproducts | 1 | 1 | 0.063 | 0.063 |
| Marine products | 2 | 2 | 0.25 | 0.5 |
| Metals | 3 | 3 | 0.5 | 4 |
| Archaeology progression | 1 | 1 | 64 | 64 |
| Exploration vegetation | 1 | 1 | 8 | 8 |
| Food variants | 1 | 1 | 1 | 1 |
| Adventure equipment | 2 | 2 | 64 | 96 |

## Farmability and simulation addendum

The original matrix above remains a 1.0.34 reference snapshot. The new farmability workbook and the completed 200,000-journey prototype are documented in [the research addendum](../../../research_index.md#medições-de-farm-e-simulações-arquivadas). Original prices remain unchanged by default; candidate values are separate. Farm benchmark production, modeled material payback, synthetic costs and high-yield stress assumptions are explicitly distinguished.
