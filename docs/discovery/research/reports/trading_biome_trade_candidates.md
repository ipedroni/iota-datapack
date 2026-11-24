# Regional trade candidates for Minecraft Java 1.21.11

Regional trade works best as a reason to visit and develop different settlements,
not as a mandatory route to basic tools or workstations. The strongest candidates
are distinctive building materials, plants, live aquatic collections and regional
craft/enchantment specializations. Ordinary ingots and undifferentiated meat are
weak candidates for claims of geographical origin.

This is research and a set of proposals. It does not alter the working
[Toolsmith template](../../drafts/trading_toolsmith_template.md), the
[other-profession draft](../../drafts/trading_profession_catalog_draft.md), prices or datapack code.
Every suggested specialization below is a design inference, not a vanilla trade.
The additive regional-pool/import-premium FRAMEWORK was approved on2026-11-20;
the individual goods, counts, levels and prices below remain proposals.
Target version is 1.21.11; later Minecraft additions are outside scope.

## What regional means

| Classification | Meaning | Example | What it does not prove |
|---|---|---|---|
| Natural source | Wild generation/spawning has a meaningful regional connection | Cherry wood, Pale Oak, coral | The item cannot be farmed, moved, crafted or obtained by another route |
| Availability bias | More abundant or more likely in some regions | Extra Badlands Gold, Dripstone Copper, climate-biased wool colors | Exclusivity or an identifiable origin on the resulting item |
| Cultural specialization | A useful local craft or response to local conditions | Cold-weather Leather Boots, maritime Respiration books | A vanilla biome restriction on crafting/enchanting |
| Structure/dimension source | The journey concerns a structure or dimension | Prismarine, Echo Shards, Nether reagents | A biome rule or an appropriate unrestricted merchant supply |

Do not label an item biome-exclusive merely because its best-known source is
regional. The current price/candidate files do not track where items were mined,
grown or crafted. Region of the ITEM, villager appearance/type, current biome,
and the settlement/workstation location are four different things.

## Confirmed anchors

- Java 1.21.5 introduced distinct Blue/Brown Eggs and climate-linked farm-animal
  variants. Sheep also have climate-biased natural wool colors: usually white
  in temperate, black in cold and brown in warm regions. Those wool colors are
  not exclusive. Cartographer map assortments already depend on village type in
  non-experimental Java releases from 1.21.5 onward. The librarian biome-book
  experiment must not be confused with that released cartographer behavior.
  [Official 1.21.5 release notes](https://feedback.minecraft.net/hc/en-us/articles/35298208390797-Minecraft-Java-Edition-1-21-5-Spring-to-Life)
- Dripstone Caves have additional Copper; Badlands have additional Gold. These
  are abundance relationships, not regional ingot IDs. Lush Caves have their own
  plant/material palette. [Official 1.18 release notes](https://feedback.minecraft.net/hc/en-us/articles/4415128577293-Minecraft-Java-Edition-1-18)
- Mangrove vegetation and naturally abundant Mud provide a coherent wetland
  palette. Mud can also be manufactured, and Clay has a renewable route; neither
  should receive an unqualified scarcity premium.
  [Official 1.19 release notes](https://feedback.minecraft.net/hc/en-us/articles/6731464524941-Minecraft-Java-Edition-1-19)
- Pale Garden resources include Pale Oak, Pale Moss, Eyeblossoms and Resin-related
  production. Resin can be produced through Creaking Hearts, so a new forest
  journey does not imply permanently finite supply.
  [Official 1.21.4 release notes](https://feedback.minecraft.net/hc/en-us/articles/32385811139085-Minecraft-Java-Edition-1-21-4-The-Garden-Awakens)

Local version-specific checks use the existing generated 1.21.11 data:

- `vendor/generated/data/minecraft/worldgen/biome`: actual feature/spawner lists;
  for example `badlands.json` includes `ore_gold_extra`, `dripstone_caves.json`
  includes `ore_copper_large`, and Cherry/Pale Garden have named vegetation.
- `vendor/generated/data/minecraft/chicken_variant` and
  `tags/worldgen/biome/spawns_*_variant_farm_animals`: actual animal regions.
- `loot_table/entities/stray.json` and `bogged.json`: Slowness/Poison arrow output.
- `loot_table/gameplay/fishing*`: fishing-source distinctions; a plain fish item
  is not reliable evidence that it came from its mob's natural spawning habitat.
- `reports/items.json`: proposed item IDs are present in this target version.

## Resource regions worth distinguishing

| Region | Strong resource identity | Renewable/alternative-source caution |
|---|---|---|
| Desert / Badlands | Cactus and its flowers, Sand/Red Sand, Sandstone/Red Sandstone, Terracotta; Badlands Gold bias | Cactus is farmable; Terracotta craft/smelting is an alternative; Gold has farms |
| Taiga / snowy climates | Spruce, Sweet Berries, naturally common black wool in cold climates, Blue Eggs; selected Ice types | Trees, berries and hens can be moved; wool can be dyed; ice can be farmed |
| Savanna / warm climates | Acacia, Brown Eggs, naturally common brown wool | These are not permanent geographical locks after breeding/plant transport |
| Jungle / Bamboo Jungle | Jungle wood, Bamboo, Cocoa, Vines | First acquisition supports exploration; later cultivation can happen elsewhere |
| Swamp / Mangrove Swamp | Lily Pads, Mangrove wood/roots, Mud, wetland plants; Bogged-related arrows | Slime has other sources; Mud is manufacturable; live organisms can be moved |
| Cherry Grove / flower-rich areas | Cherry wood, Pink Petals, regional flowers and dye palettes | Planting/bonemeal can relocate production; dyes themselves do not prove origin |
| Pale Garden | Pale Oak, Pale Moss/Hanging Moss, Eyeblossoms, Resin | Tree/Heart transport and Resin farming matter more than wild rarity alone |
| Warm/lukewarm sea | Coral palette, live tropical fish collections; maritime materials | Lush Caves also have tropical fish; plain fish can come from fishing loot |
| River / colder water | Salmon-oriented local supply, winter aquatic imagery | Fish items are not exclusive to those regions; do not infer catch provenance |
| Lush Caves | Glow Berries, Azalea, Moss, Dripleaves, Spore Blossoms, Clay, aquatic collections | Some plants reproduce readily; not every Lush Cave item has the same renewability |
| Dripstone / mountains | Pointed Dripstone, Dripstone Blocks, Calcite-related geology, Copper/altitude resource identities | Calcite also has geode sources; high-altitude Iron is not exclusive to a biome |
| Mushroom Fields | Mycelium/Mushroom palette and themed foods | Mushrooms/stew have other sources; do not equate every mushroom with that biome |
| Deep Dark / Ancient Cities | Sculk palette, Echo Shards, Swift Sneak-related knowledge | City loot and Sculk production are different supply systems; protect discovery value |
| Nether frontier | Crimson/Warped wood, Quartz, Blackstone, Basalt, Soul materials and brewing reagents | Dimension identity, not a naturally generated villager skin/village type |
| End frontier | End Stone, Purpur, Chorus-derived supplies | Dimension/structure progression; not a substitute for the first End journey |

The resource table is a candidate palette, not a declaration that every listed
item naturally generates exclusively throughout that whole combined region.
In particular, temperature classes and named village types are not identical.

## Candidates by profession

The sale column is a possible local specialty. The import column proposes
complementary player-to-villager purchases, to be reviewed against the current
catalog and material tier. It does not automatically add an offer slot.

| Profession | Local sales/specialization candidates | Import-purchase candidates | Priority and qualification |
|---|---|---|---|
| Toolsmith | Dripstone-oriented Copper tool/material supply; mountain Iron specialization; Badlands Gold tools | Complementary tier-appropriate ingots, fuel and qualifying crafted tools | Medium. Real ore abundance, but ordinary ingots have no origin and farms weaken regional scarcity. Keep the approved tier staircase |
| Armorer | Cold-region Leather Boots; mountain Feather Falling gear; maritime Respiration/Depth Strider gear | Leather/selected dyes in cold regions; compatible crafted armor and allowed materials | Medium. These are functional/cultural choices, not region-exclusive enchantments. Do not make ordinary Protection or repair materials travel-only |
| Weaponsmith | Cold undead-hunting Smite; coastal Impaling/Riptide/Loyalty books or appropriately compatible spear/sword variants | Approved weapon materials and qualified crafted weapons from other production regions | Medium/low initially. Book/craft style is thematic; Trident itself should not become an unrestricted supply shortcut. Check which enchantment supports each weapon |
| Fletcher | Cold-region Slowness arrows; wetland Poison arrows; Jungle/Bamboo archery theme | Feather, String, Flint and complementary crafted Bow/Crossbow | High. Stray/Bogged provide an actual regional threat/output link. Bamboo does NOT become a bow/arrow ingredient without a separately approved recipe |
| Leatherworker | Cold-weather leather sets; locally dyed leather armor; regional horse-armor colors | String, Leather/Rabbit Hide, dyes absent from the local palette, compatible enchanted leather crafts | Medium. No biome-specific Leather item exists. The base's alternative Leather/Hide recipes remain valid sources |
| Farmer | Taiga Sweet Berries, Jungle Cocoa, Lush Cave Glow Berries, local flowers/seeds; complementary prepared foods | A small selection of nonlocal produce or seed stocks | High for discovery and crop diversity. Seed/plant transport eventually removes geographical production scarcity; avoid claiming permanent import dependency |
| Butcher | Warm Brown Eggs / cold Blue Eggs in the local food-supply palette; regional prepared meals | Complementary Eggs/Milk/crops and, if the separate draft is approved, raw fish supplied to the food processor | High for identifiable Egg variants, low for meat origin. Keep milk/egg purchases and passive-animal alternatives; variant cows/pigs do not create unique regional meat/leather IDs |
| Fisherman | Live aquatic bucket collections near appropriate waters; local raw/prepared fish assortment; cold/maritime rod specialties | String, fuel, buckets/gear inputs, crafted Fishing Rods | High for sales and local identity. NEVER buy fish, including a regional fish-import contract. Raw Tropical Fish is not proof of a tropical journey; buckets are a different collection route |
| Shepherd | Climate-linked black/brown/white wool palettes; local flower-derived dyes, beds, carpets and banner designs | Selected contrasting colors/dyes and crafted textiles | High for identity, modest for scarcity. Natural color probability is regional; dyeing/breeding defeats exclusivity. Do not pay an origin premium for a dyed color |
| Librarian | Maritime, mountain, desert, forest or wetland knowledge themes; biome-book experiment as an optional reference | Paper/Ink/Book supplies and the existing bounded book contracts | Medium, sensitive to progression. Do not turn essential enchantments into compulsory biome gates, add curses, implement teaching, or automatically replace the current Mending proposal |
| Cartographer | Local knowledge pointing to OTHER regions/structures; route chains between unlike settlements | Survey/compass/map supplies, selected observation equipment | Highest. Directly promotes exploration and infrastructure without selling the destination's treasures. Keep native village-type behavior separate from a new workplace-biome rule |
| Cleric | Wetland Slime-related reagents; flower/stew palettes; coastal Prismarine reagents; Pale Garden plants; frontier brewing specialties | Complementary plants and expedition reagents absent locally | Medium/high. Slime, dyes and Resin have renewable/alternative routes. These are brewing/trade themes, not invented potion effects for new ingredients |
| Mason | Desert Sandstone/Red Sand/Terracotta; wetland Mud Bricks; Cherry/Pale wood finishing; Lush Cave Clay; Dripstone/Calcite; maritime Prismarine; frontier Blackstone/Basalt/Purpur | Contrasting building materials such as Clay, Sand, stone families and selected finished products | Highest. Distinct bulk palettes fit the approved builder-supply role. Preserve affordable volumes and the Stonecutter's role; apply the actual Iota recipe yields |

## Best first regional families

1. **Mason material palettes:** clear icons and useful bulk output. Start with
   Desert/Badlands, wetlands, mountain/cave and maritime families.
2. **Farmer crops and Shepherd colors:** strong identity without locking tools.
   Expect production to become local after players move plants/animals.
3. **Cartographer route networks:** sell directions to nonlocal places, with
   useful destinations rather than a required chain of merchant upgrades.
4. **Butcher Egg variants and Fisherman bucket collections:** actual distinct
   item/collection identities, while preserving Fisherman's no-fish-buying rule.
5. **Fletcher regional ammunition:** a concise early test of natural sources
   versus crafted equivalents; no new ingredient recipes are implied.

Add equipment/enchantment cultures later. Do not start by distributing ordinary
Iron/Gold buys across biomes; that is a weaker exploration incentive and a much
stronger invitation to multiply automated-farm buyers.

Trident enchantments such as Riptide, Loyalty and Impaling do not transfer to
Spears or Swords. Those are book-supply themes requiring a separately selected
catalog slot; a Spear could instead use its native Lunge where appropriate.
Validate concrete equipment/enchantment pairs against the 1.21.11 data.

## Stock and price implications

Do not change current prices from this research alone. The selected framework
ADDS1–2 local sales and 1–2 foreign purchases per applicable merchant region.
Do not replace ordinary slots automatically. Preserve fixed essential offers,
filter duplicate goods, and select the exact count/unlock stages with the user.

For future import experiments, test premiums of 0%, 5% and 10% as hypotheses,
with per-villager limits and no shared demand. These are NOT selected prices.
Recalculate after emerald/block rounding; a theoretical 5% change can disappear
or become a much bigger jump. Compare transport work, loading time, teleportation
and buyer multiplication before interpreting income.

The present draft forbids immediate unchanged-item buy/resell profit across
shops. The user has now approved an explicit interregional import-profit exception,
requiring achievable route costs and actual whole-lot prices; it cannot be silently called
an arbitrage bug in one document and a reward in another. Moving two merchants
or producing the crop beside the importer may remove that route cost entirely.

## Location and provenance decisions to resolve before implementation

- Prefer the biome of a stable settlement/workstation for a future regional
  economy, not the player's biome or the villager's clothing. A new Iota region
  classifier can include Cherry/Pale/Mangrove regions beyond the seven native
  villager types. Native type-based map behavior remains a separate baseline.
- Do not reroll a career/catalog by moving its jobsite. Decide whether regional
  specialization is fixed at first career or whether only a price/stock modifier
  depends on current location. The latter must preserve the same selected offers.
- Fixed origin makes portable merchant collections powerful; current-location
  modifiers invite boundary manipulation. Neither is solved by naming a biome.
- Crop/wood/egg/color IDs can match resource types, not prove a journey. Source
  certification would require new tracking and compatibility work; it is not
  included in current item data or this proposal.
- Nether/End settlements are player-built frontier cases. They are not generated
  native village types and should not block the ordinary progression.

## Recommended next review

Review Mason, Farmer, Shepherd, Cartographer and Fisherman regional palettes
first. Select a small test set, choose supply/preference versus certified origin,
then simulate bounded imports including teleportation and relocated villagers.
Keep these proposals separate from the priced base-profession catalogs until
the user selects their scope. No biome-specific catalog was added to the preview.
