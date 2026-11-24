# Iota — Design Directions

Minecraft Java 1.21.11. Distributed builds are **Iota 1.0.35**, **Tool Mastery 0.0.1** and **Magical Discovery 0.0.1**. Tool Mastery **0.0.2** is staged in source.

| Document | Main reference for |
| --- | --- |
| This guide | Base and expansion behavior, staged changes, shared enchantment classification and repository layout |
| [Trading design](discovery/drafts/trading_design_directions.md) | Approved redesign, calibration candidates, catalog links and open decisions |
| [Future directions](future_directions.md) | Deferred proposals |
| [Test checklist](release_checklist.md) | Verification steps, development commands and test evidence |
| [Changelog](release_changelog.md) | Release history and milestones |
| [Research index](discovery/research_index.md) | Studies, datasets and historical snapshots |
| [Project next steps](discovery/drafts/project_next_steps.md) | Workstream handoff and next steps |
| [Project task status](discovery/drafts/project_task_status.md) | Task status and links to decisions |

Use lowercase names for documents and directories. Prefix research paths specific to Trading or its economy with `trading_`.

Persistent item fields and scoreboards retain their compatibility identifiers. Removing the released expansions leaves stored progress in item data.




## Design tags — cross-module context

Implementation modules identify where behavior is maintained and distributed.
Design tags identify the coordinated objective, independently of module, status
or packaging. A decision may have multiple tags. Tags are documentation
metadata, not native Minecraft resource tags or new installation dependencies.

| Approved tag | Scope |
| --- | --- |
| Progression | Lasting capability, knowledge, equipment investment and merchant/village development |
| Economy | Obtaining, producing, consuming and exchanging resources; maintenance, prices, supply and stock |
| Exploration | Reasons to seek places, sources, structures, merchants and discoveries |
| Quality | Quality-of-life improvements, practical alternative recipes and less repetitive friction |
| Survival | Health, death, recovery, rest and environmental rhythm |

Equipment attachment is part of Progression. Village-identity features are
classified by what they do: promotion names support Progression, regional
relationships may support Exploration, and population-based commercial capacity
also concerns Economy. Randomness or a timer alone does not imply Exploration.

The [archived decision audit](discovery/research_index.md#pesquisas-arquivadas) maps implemented,
staged, prototype, active-design and future decisions. Recovery recipes and
crafting-station changes use **Quality**. Alternative Leather/Rabbit Hide and
similar convenience recipes use **Quality**. Keep multiple tags only when a
change directly serves distinct objectives, not merely because it affects
resource values downstream.

Building is retired. **Survival** is approved for health, death, recovery and rest. Quality is not a catch-all for those mechanics.

| Decision | Implementation owner | Design tags | State |
| --- | --- | --- | --- |
| D-001: reduce golem/piglin direct metal yields | Drops | Economy | Staged for 1.0.35; ZIP deferred |
| [D-002: ordinary shop margin](discovery/drafts/trading_design_directions.md#economic-criteria--approved) | Future Trades | Economy | Requested direction; exact margins open |
| D-003: remove managed-tool prior-work repair costs | Tools | Progression, Economy | Shipped |
| D-004: shared discovery register | Magical Discovery, optional Mastery hook | Progression, Exploration | Frozen shipped register; native-table filtering remains future |
| [D-005: shared demand](discovery/drafts/trading_design_directions.md#working-price-and-stock-calibration) | Future Trades | Economy | Not selected; shared demand rejected |

For each decision, retain tags, implementation owner(s), status, rationale and
evidence. Sharing a tag does not approve every associated proposal. Trading is
an area of design spanning modules; Trades is the proposed implementation
module for villager offers. Crafting recipes remain in Recipes.




## Hands Off

Mining is 80% slower when the main hand is empty or holds an item outside
the recognized mining tool and exemption tags.




## Tools

Wooden and stone pickaxes, axes, shovels and hoes mine 50% slower than
vanilla. Their netherite counterparts mine about 11% faster. Gold tools can harvest blocks at the same tier as iron tools.

The following durability and enchantability values apply to vanilla
pickaxes, axes, shovels, hoes and swords when held in the main hand.

| Material | Durability | Enchantability |
| --- | ---: | ---: |
| Wood | 16 | 4 |
| Stone | 64 | 4 |
| Copper | 248 | 8 |
| Iron | 456 | 8 |
| Gold | 64 | 24 |
| Diamond | 1,560 | 12 |
| Netherite | 2,032 | 16 |

Tools also halves enchantment anvil_cost values, rounded up with a minimum of
one. This affects the enchantment contribution, not the whole operation price.
Wood/stone/netherite handheld tools and weapons (including spears) use Stick,
Flint and Netherite Scrap for anvil repair after being held in either hand.
Armor is unchanged. The repair fraction remains vanilla. Prior-work penalties are cleared on
managed tools/weapons in accessible player slots as of 1.0.32.
The managed repair-cost tag covers 42 vanilla tools/weapons, including spears,
across hotbar, inventory, offhand, cursor and personal crafting slots. Armor,
bows, crossbows, tridents and closed-container contents are outside that scope.
Anvil input slots are not directly accessible, so equipment must pass through a
managed player slot. The hard 40-level ceiling remains.


### Curse suppression — staged for 1.0.35

Base Tools filters Curse of Binding and Curse of Vanishing from random loot, tradeable and Treasure tags, disables their vanilla effects and removes them from carried gear and books while preserving other data. Items inside containers are cleaned when carried. Magical Discovery retains its standalone filters. The 1.0.34 base still has active vanilla curse effects.

The 1.0.34 base includes an opt-in Broken pickaxe fixture in Tools. See the [Broken checklist](release_checklist.md#broken-state-fixture-regression).




## Recipes


### Tools

Replaces the vanilla recipes for wooden and stone pickaxes, axes, shovels,
hoes, swords and spears. Wooden tools use sticks in place of planks. Stone tools
use flint in place of cobblestone.

Wooden spears use three sticks diagonally. Stone spears use a flint tip and
two sticks diagonally. Both patterns support horizontal mirroring.
The wooden sword uses five sticks in a cross, including the center; the wooden
shovel uses three sticks vertically. Shields retain their vanilla planks-and-iron recipe.


### Materials

| Ingredients | Result |
| --- | --- |
| Smelt rotten flesh | 1 leather |
| Leather | 4 rabbit hide |
| Charcoal and bone meal | 1 ink sac |
| Ink sac and glowstone dust | 1 glow ink sac |
| Cobweb | 2 string |
| Wool of any color | 4 string |
| Wheat | 1 wheat seed |
| Honey bottle and green dye | 1 slimeball |


### Storage

| Ingredients | Result |
| --- | --- |
| 8 logs in a ring | 4 chests |
| 4 amethyst shards, 4 turtle scutes and 1 echo shard | 2 shulker shells |


### Automation

| Ingredients | Result |
| --- | --- |
| Dropper, 3 sticks and 3 string | 1 dispenser |
| Redstone in the upper corners and center, sticks at the middle sides, stone across the bottom | 1 repeater |
| Three redstone torches in a row above stone–quartz–stone | 1 comparator |
| Three redstone dust above three sticks above stone–quartz–stone | 1 comparator |
| Alternating glowstone/redstone dust around an empty center; either dust may occupy the corners | 1 redstone lamp |


### Building

Finished variants (bricks, chiseled blocks, pillars and polished blocks) are
made in the Stonecutter. Wax application, moss addition, material assembly and
Chiseled Bookshelves remain at the crafting table. The Stonecutter recipe is
unchanged. All 254 vanilla cutting routes remain, with 26 wooden cutting routes
added. Shape production remains available at BOTH stations:

| Shape | Crafting table | Stonecutter |
| --- | --- | --- |
| Slabs | 3 blocks → 6 slabs | 1 block → 2 slabs |
| Stairs | 6 blocks → 12 stairs, mirrored pattern supported | 1 block → 2 stairs |
| Walls | 6 blocks → 6 walls | 1 block → 1 wall |

Raw copper shortcuts also yield two stairs; cutting into Cut Copper first
provides a higher yield. Recovery returns the final material, not the shortcut's
original input. Oxidation, wax, moss and wood species are preserved.


### Reclaiming

| Ingredients | Result |
| --- | --- |
| Two identical slabs, vertically | 1 corresponding block |
| Two identical stairs, horizontally or vertically | 1 corresponding block |
| Six identical walls, two rows of three | 6 corresponding blocks |
| Packed ice | 9 ice |
| Blue ice | 9 packed ice |




## Drops

- Selected leaves can drop string and have adjusted stick drops. Short
  and tall grass have an 8% wheat seed drop chance and can also drop flint,
  sticks, feathers and string.
- Gravel has a higher chance to drop flint at lower Fortune levels. Mining
  stone and selected rock blocks with a pickaxe can yield extra flint.

Selected structure loot tables also roll for themed bundles. Each chest
listed below also has a separate 2.5% chance to contain an empty bundle.

| Source | Bundle | Chance |
| --- | --- | ---: |
| Village house chests | Forager | 3% |
| Village toolsmith chests | Primitive | 5% |
| Shipwreck supply chests | Explorer | 4% |
| Ancient city and woodland mansion chests | Adventurer | 1% |
| Trail Ruins archaeology | Abandoned | 3% |


### Staged metal drops — not yet packaged

Design decision: **D-001**. Design tags: **Economy, Progression, Exploration**.
Implementation owner: **Drops**.

Selected Iron Golem and Zombified Piglin changes belong to Drops. Golems use
3–5 Iron Nuggets plus the standard Looting quantity bonus, and a fixed 25%
one-ingot roll with vanilla player-kill credit. Piglin nugget and ingot chances
are calibrated to match Iron's relative direct-metal reduction: about 89%
without player credit and 79–83% with credit at Looting 0–III. Non-metal loot,
equipment salvage and XP are unchanged. See the [native test summary](release_checklist.md#automated-research-evidence--2026-11-20). The 1.0.34 ZIP uses vanilla Iron Golem and Zombified Piglin loot tables.




## World

The Overworld has one hour of day and one hour of night at 20 TPS. Beds
work at either time with vanilla safety checks. When enough players complete
sleep, the weather clears. Daytime sleep advances the clock three Minecraft
hours. Nighttime sleep advances to dawn.

The first load with Iota 1.0.35 sets `minecraft:mob_griefing` to `false` to prevent Endermen from picking up blocks and Creeper explosions from breaking terrain. This global rule also changes other mob actions, including villager farming. Later loads preserve administrator changes to this rule.




## Hearts

Players keep their inventory on death. In Survival, each death removes one
heart of maximum health, up to five lost hearts, and restarts a five-minute
recovery timer. All lost hearts return together. A lit Campfire or Soul
Campfire within four block-grid units accelerates recovery fivefold, giving
approximately 60 seconds of recovery while remaining nearby. Detection refreshes
each second; multiple fires do not stack.

The action bar shows `Full recovery in m:ss` only while sneaking. During
recovery, 20 red/gray dust particles appear around the torso each second; nearby
lit campfires substitute eight green Happy Villager particles. Ordinary missing
current health does not trigger recovery feedback. Full recovery plays a sound
and particle burst, and stops the ongoing aura.

The lost-heart burst uses 24 Damage Indicator particles ten live ticks after
respawn; its beacon-deactivation sound plays immediately. Feedback also plays
at the five-heart cap. Dying while already at the cap applies Hunger III for
60 seconds; subsequent deaths refresh it without increasing its strength.
This hinders natural healing through hunger, rather than directly changing a
regeneration-rate attribute. Eating can compensate.

A Survival death also stores 25% of current total XP points, rounded down, in a
personal floating orb and preserves the remainder. Only the owner can recover
it, once. Another death forfeits the old amount, including a new death with no
XP. Grounded safe deaths use the death location; airborne, void or unsafe cases
fall back to the resolved respawn location. UUID/generation checks reject stale
or other players' orbs. No chunks are force-loaded. The XP-themed head, dust,
interaction hitbox and recovery sounds require no resource pack; there is no
automatic death/respawn XP chat announcement.

See [archived Hearts XP Recovery study](discovery/research_index.md#pesquisas-arquivadas) for lifecycle details and
[the checklist](release_checklist.md) for targeted in-game verification.




## Iota Expanded: Tool Mastery


### Design goal

Tool Mastery gives players a reason to grow attached
to equipment they craft and use. Encountering a new item should prompt a
choice. A player might replace a trusted tool with accumulated bonuses,
keep using it after finding alternatives, or save it as a keepsake.


### Current behavior

New gear starts Unranked. Eligible uses grant 1 XP plus 0.25 XP per point of
durability consumed. Armor gains XP from hostile hits with a two-second
cooldown and a gain adjusted for the piece's durability. Shields earn XP from
blocks in either hand, including blocks with zero wear. XP stays with the
item. Its tooltip shows only the rank. Use the status command to inspect XP. On the vanilla anvil, put the item whose progress you want to keep in
the left slot. Base anvil-cost changes belong to Tools, not this expansion.

| Rank | Handheld gear XP | Armor and shield XP | Mining speed at the threshold |
| --- | ---: | ---: | ---: |
| Unranked | 0 | 0 | 0% |
| Rookie | 5 | 5 | 0% |
| Apprentice | 400 | 100 | +2% |
| Adept | 1,600 | 300 | +8% |
| Expert | 4,000 | 700 | +20% |
| Masterwork | 8,000 | 1,500 | +40% |

The mining speed bonus grows with XP from Apprentice to Masterwork while
the tool is held in the main hand. Expert and Masterwork shields reduce the
disable cooldown by 10% and 20%, respectively.

Adept, Expert and Masterwork can grant compatible enchantment upgrades.
Masterwork rolls for Treasure at 5% in Tier A and 0.5% in Tier B. If the rare
roll misses, an eligible common upgrade can still be granted. The milestone
ends without a reward if no eligible common upgrade remains. Bow, crossbow
and trident use Tier A odds. Shields use Tier B odds.

Level-ups use 12 blue particles at every rank, plus 32 enchantment particles
at ranks III–V. Anvil audio plays at 0.40, followed eighteen ticks later by player
level-up at 0.40. Death cancels the delayed sound. No level-up/reward action-bar message is displayed.


### Broken equipment — staged for 0.0.2

Tool Mastery owns the approved preservation of 76 supported mining, combat and armor items. At the breaking point, supported equipment keeps one durability point and receives the red `Broken` lore line. Broken tools and weapons lose mining and combat effectiveness. Broken armor unequips, including when inventory is full. Native anvil repair restores the item and removes the marked status lore. The opt-in fixture moves out of base Tools with this source change.

See the [prototype evidence](discovery/research/prototypes/broken_tool_prototype.md) and [release checks](release_checklist.md#broken-state-fixture-regression).




## Iota Expanded: Magical Discovery


### Design goal

Encourage exploration and engagement with enchanting systems. The intended
future Enchanting Table begins with basic enchantments and levels; discovering
books or equipment expands a shared world pool. Single-player is the priority;
any future native-table filtering would be shared in multiplayer.


### Current behavior — frozen at 0.0.1

Once per second, direct inventory entries, including armor and offhand, are
scanned for regular and stored enchantments. Existing carried equipment is
registered automatically; items are preserved. Closed bundles and shulkers are
not scanned internally. Non-curse maximum levels accumulate in the shared world
register, and higher levels imply lower levels. The approved eight starting
enchantments are seeded at level I.

Tool Mastery rewards update this register immediately when both expansions are
installed; Tool Mastery also works independently. Personal status/reset is
separate from the shared register. A personal reset does not erase world
knowledge, and carried items can immediately be rediscovered.

**Native Enchanting Table offers are not filtered by these discoveries.** Pool
refresh and native level gating remain unimplemented. Legacy Efficiency-only
book registration/application commands have been removed. Curse of Binding and
Curse of Vanishing are excluded from the expansion's vanilla random-loot,
tradeable-enchantment and Treasure tag overrides.

Progression and discovery-register integration remain frozen. See
[Expansion Status](release_changelog.md#expansions) for the milestone and
native-interface limitations.




## Verification and commands

See the [checklist and command catalog](release_checklist.md).




## Future directions

Future proposals, selected deferred directions and unresolved design questions
are centralized in [Future Directions](future_directions.md). Groups follow
qualitative similarity, not implementation priority. Completed behavior stays
in this guide; active Trading choices stay in Trading Design Directions.




## Trading — design in progress

Published Iota uses vanilla villager trading. See the [five-level redesign](discovery/drafts/trading_design_directions.md).




## Repository layout and development

- modules/: six base modules, plus expansions/ and experimental/ source groups.
- modules/expansions/tool_mastery/: Iota Expanded: Tool Mastery.
- modules/expansions/magical_discovery/: Iota Expanded: Magical Discovery.
- modules/experimental/mastery_orb_experimental/: archived Mastery Orb POC;
  excluded from the base and optional-expansion distributions.
- tools/: generators, validators and packaging.
- dist/: separately installable ZIPs.
- [Research index](discovery/research_index.md) links to active studies, datasets and archived material.
- docs/discovery/tests/: anvil persistence fixtures and isolated farm benchmarks.
- docs/discovery/research/outputs/: economic workbooks and research delivery artifacts.
- vendor/: existing portable development tools and official registry data.

Build using tools/build-integrated.ps1 with -Distribution base, tool_mastery,
or magical_discovery. Default is base. Generate mastery from
tools/build-mastery-progress.mjs; it writes into modules/expansions/.

Legacy storage iota_tool_mastery:progress, scoreboards, item custom_data and
legacy lore markers are intentionally retained for save compatibility.




## Shared enchantment classification

The approved classification applies to every level of each vanilla Java 1.21.11 enchantment. Trading and Magical Discovery use these Iota categories for design. Vanilla Treasure tags serve a separate technical purpose.

| Iota category | Definition | Approved enchantments |
|---|---|---|
| Basic | Modify simple mechanics without creating new interactions. | Efficiency, Unbreaking, Sharpness, Power, Protection, Quick Charge, Lure, Swift Sneak |
| Advanced | Modify mechanics creatively or create new interactions. The approved list also includes resource-yield improvements. | Knockback, Punch, Sweeping Edge, Fire Aspect, Flame, Thorns, Multishot, Piercing, Density, Breach, Fortune, Looting, Luck of the Sea |
| Situational | Need a specific condition to be useful; equipment eligibility alone is not enough. | Smite, Bane of Arthropods, Impaling, Fire Protection, Blast Protection, Projectile Protection, Aqua Affinity, Respiration, Depth Strider, Soul Speed |
| Treasure | Extensively change the gameplay loop or introduce complex mechanics. | Mending, Infinity, Silk Touch, Feather Falling, Loyalty, Frost Walker, Wind Burst, Riptide, Lunge, Channeling |
| Excluded | Curses excluded from Iota. | Curse of Binding, Curse of Vanishing |

All 43 vanilla enchantments are covered once: 8 Basic, 13 Advanced, 10 Situational, 10 Treasure and 2 excluded. Categories represent Iota design and are independent of vanilla technical Treasure tags. No enchantment is split into different categories by level.

Review vanilla loot, enchanting-table access, fishing, technical tags, Discovery unlocks and mastery rewards before changing their distribution.
