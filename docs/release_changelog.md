# Iota — changelog

Release history for the base pack and optional expansions. Staged changes are not released ZIPs.

## Documentation — 2026-11-22

Consolidated the [Trading redesign](discovery/drafts/trading_design_directions.md), the [shared enchantment classification](design_directions.md#shared-enchantment-classification) and the [task notes](discovery/drafts/project_task_status.md). Previous drafts are preserved in the [dated snapshot](discovery/research_index.md#backups-anteriores).

Editorial follow-up linked current rule owners and clarified published, staged and experimental behavior.

## Base release history

### Iota 1.0.35

- World: initializes `minecraft:mob_griefing` to `false` once per world. Endermen stop picking up blocks and Creeper explosions leave terrain intact. Administrators can change the rule after initialization.

- Tools: curse acquisition filters now also exist in the base, vanilla curse
  effects are inert and carried curses are removed while preserving other data.
  Native direct cleanup and player-context cases passed within the [recorded scope](release_checklist.md#automated-research-evidence--2026-11-20).
- Tool Mastery source: moved the proven opt-in Broken pickaxe fixture out of
  Tools. General tools/weapons/armor preservation is staged in Tool Mastery 0.0.2 and still requires final regression checks;
  the distributed Tool Mastery ZIP remains 0.0.1.
- Trading design: completed the Toolsmith working template, generated integer
  price/lot tables, bounded sleep credit and supply calculations. No trades added.

- Drops: Iron Golems drop 3–5 Iron Nuggets with Looting quantity bonuses and
  have a fixed 25% one-ingot roll with vanilla player-kill credit. Zombified
  Piglin nugget/ingot rolls are calibrated to match Iron's relative direct-metal
  reduction at no-player-credit and Looting 0–III contexts. Equipment salvage,
  XP, poppies and Rotten Flesh are unchanged. Later [native sampling](release_checklist.md#automated-research-evidence--2026-11-20) also covered command-attributed player credit with Looting.
- Source layout: optional expansions moved to modules/expansions; the archived
  Orb moved to modules/experimental/mastery_orb_experimental. Research outputs
  and fixtures moved to research/outputs and research/tests. tools and vendor
  remain at the project root. Generators and references follow the new paths.
- Documentation: Trading Design Guidelines renamed Trading Design Directions.
  Consolidates current Hearts/Discovery behavior, removes stale Efficiency-only
  POC commands and duplicate guide sections, and separates staged changes from
  the shipped 1.0.34 baseline. No new Trading gameplay is implemented.

### Iota 1.0.34 — Minecraft Java 1.21.11

- Removes automatic XP-orb death/respawn chat announcements; manual diagnostics
  remain available.
- Consolidates repair-cost evidence into research/reports/anvil_behavior.md and repository layout
  into design_directions.md; removes their redundant standalone documents.

- Tool Mastery 0.0.1 feedback revision: every level emits the same 12 blue
  particles; III, IV and V additionally emit 32 enchantment particles.
  Removes per-level gold/End Rod effects and the extra purple Treasure burst.
  Bigorna sound is 0.40, followed eighteen ticks later by level-up at 0.40;
  level-up and reward action-bar messages are removed.

- Development-command audit removes the duplicate Drops container loot helper;
  keeps useful Hearts, XP and broken-tool fixtures. See [tests](release_checklist.md).
- Refreshed optional expansions 0.0.1: removes four legacy Discovery
  Efficiency-only/manual-enchant functions; fixes personal reset/status coverage
  to all 41 registered enchantments and updates help/diagnoses. Mastery levels,
  rewards and automatic Discovery behavior remain frozen.

- Increases the ongoing lost-heart aura from 5 to 20 particles per second
  (12 red and 8 gray), preserving its size, cadence and campfire substitution.

- Delays lost-heart respawn particles by ten live player ticks (0.5 seconds
  at normal tick rate), following the player's current position. A new death
  restarts the delay; the existing respawn sound remains immediate.

- Hearts recovery timer appears immediately while sneaking and clears once
  when standing. It no longer continuously occupies the action bar.
- Lost maximum hearts produce a restrained red/gray dust aura once per second;
  near a lit campfire the existing green accelerated-recovery effect takes over.
  All ongoing recovery particles stop when maximum hearts are restored.

- Strengthens the XP orb's green/gold aura. Its head remains at maximum
  display brightness without changing world lighting.
- Successful owner recovery triggers a larger green/gold particle burst,
  happy-villager sparks, XP pickup sound and a soft amethyst chime.

- Names the recovery display, hitbox and rendered head `Experience Orb`;
  existing loaded recovery entities receive the name automatically.

- Hearts stores 25% of total spendable XP points per Survival death in one
  owner-only recoverable orb. New deaths forfeit the prior unrecovered amount.
  Zero-XP deaths invalidate old orbs too; successful claims pay only once.
- Safe grounded deaths use the death location; airborne/void and unsafe sites
  fall back to actual respawn. Deferred creation, generation checks and cleanup
  avoid forced chunks and stale payouts across reloads and dimension changes.
- XP-head display, green/yellow dust and click hitbox require no resource pack;
  neither ordinary Player Heads nor the archived Mastery Orb are involved.
- Adds xp/test_setup, xp/diagnose, automated XP checks and an in-game checklist
  in the [archived Hearts study](discovery/research_index.md#pesquisas-arquivadas). Live behavior remains pending user validation.

- Broken prototype items show a red `Broken` lore line. Repair removes only
  lines carrying the Iota broken-status marker; other lore and names remain.
- Entering broken state plays the vanilla item-break sound with a small burst
  of crit and smoke particles for the owner, once per transition.
- The item model stays unchanged. No resource pack or expansion update.

Historical entries describe their releases, not necessarily current behavior.
Trading prototypes 1.0.27–1.0.28 were discarded in 1.0.29. See [expansion history](#expansions) for distribution and freeze milestones.

### Iota 1.0.19 — Minecraft Java 1.21.11

- Stonecutter-exclusive finishing: audited bricks, polished blocks, chiseled
  blocks and pillars. Moss addition, waxing and ingredient assembly stay at
  the crafting table; the Stonecutter recipe is unchanged.
- Slabs, stairs and walls remain craftable at both stations. Stair crafting
  yields 12 from six blocks, with mirrored matching; all Stonecutter stair
  routes yield two, including raw-copper shortcuts (formerly four).
- Adds 26 wooden Stonecutter recipes and 203 recovery recipes with unlocks:
  vertical slab pairs, horizontal/vertical stair pairs, and six-wall batches.
- Adds wheat-to-seed, reverse ice conversions, log-to-chest crafting, and
  alternative dispenser, repeater and redstone lamp recipes.
- Short/tall grass wheat seed probability is 8%.
- Heart-loss sound uses beacon deactivation instead of the descending bass
  sequence. Existing heart-loss particles remain.
- Integrated packaging merges module resource filters. Documentation is
  consolidated and the repeatable recipe validator checks material cycles.

Validation is static. Loading and gameplay testing remain manual.


### Iota 1.0.20 — Minecraft Java 1.21.11

- Distinct release filename to distinguish the updated recipes from earlier 1.0.19 copies.
- Wooden spear: three sticks diagonally. Stone spear: one flint tip and two sticks diagonally.
- Repeater: sticks in upper corners, redstone across the middle, stone across the bottom.
- Redstone lamp: alternating glowstone/redstone ring, center empty; either dust may occupy the corners.
- Automated validation now explicitly checks all twelve wooden/stone equipment recipes for forbidden ingredients.
- Includes the building and recovery changes from 1.0.19. No other gameplay changes.


### Iota 1.0.21 — Minecraft Java 1.21.11

Consolidates the recipe adjustments manually validated by the user.

- Wooden sword: five sticks in a cross, including the center.
- Wooden spear: three sticks diagonally; stone spear: flint tip and two sticks.
- Repeater: R R / SRS / BBB.
- Comparator: TTT / BQB, with an empty top row allowed; alternative RRR / SSS / BQB.
- Lamp: alternating redstone and glowstone ring, empty center, either arrangement.
- R = redstone dust, S = stick, B = stone, Q = quartz, T = redstone torch.
- Retains building and reclaiming changes from 1.0.19.

Validation: user confirmed the requested recipe tests. Static checks passed;
424 normalized explicit-ingredient shaped patterns had no different-output
collisions, including horizontal mirroring and shifted grid placement.
This collision check excludes tags, ingredient alternatives and shapeless recipes.
No Minecraft server load test was run.


### Iota 1.0.22

- Recipes: one leather crafts into four rabbit hide, reversing vanilla leather assembly.

- Six-module base, with two separately installable optional expansions.
- Iota Expanded: Tool Mastery uses namespace iota_exp_tool_mastery.
- Iota Expanded: Magical Discovery uses namespace iota_exp_magical_discovery.
- Source folders moved to expansions/; generators and hooks updated.
- Persistent scores, item fields and legacy storage/lore IDs retained.
- No changes to recipe balance or enchantment availability.

Remove the former integral ZIP before installing the base and desired expansions.
New command examples: /function iota_exp_tool_mastery:status and
/function iota_exp_magical_discovery:status.

- Hearts: heart-loss feedback now uses 24 damage-indicator particles around the torso, replacing faint ash. Sound unchanged.


### Iota 1.0.23

- Hearts: lit campfires and soul campfires within four block-grid units grant 2x recovery speed; no stacking, one-second proximity refresh.
- Magical Discovery: automatic non-destructive scanning of direct inventory enchantments, including stored book enchantments, armor and offhand.
- Shared discovery records include all non-curse enchantments and maximum levels. Approved initial enchantments are initialized at level I.
- Nested containers excluded; native enchanting offers remain unchanged pending a separate prototype.
- No dependencies installed.


### Iota 1.0.24

- Hearts: campfire recovery increases from 2x to 5x. Five minutes of recovery finish in approximately one minute beside a lit fire.
- Eight happy-villager particles around the player each second while campfire recovery is active.
- Radius, lit-fire requirement and no-stacking rule unchanged.
- No expansion gameplay changes.


### Iota 1.0.25

- Hearts: recognize the saved iota_life_death:death_penalty modifier from before the namespace rename.
- Applying or recovering health removes all three known Iota death-penalty IDs before rebuilding the current modifier, preventing stacked legacy penalties.
- Existing loss count and timer are retained during migration. Other max-health modifiers and base health are untouched.
- Expansions remain frozen at 0.0.1.


### Iota 1.0.26

- Hearts checks persisted penalty modifiers before clearing scores, and reconstructs missing loss state from known modifiers. Missing timers are initialized.
- Known legacy penalty IDs are normalized before recovery. Unrelated health attributes are untouched.
- Campfire countdown shows estimated real remaining time at current speed: 1:00 at the beginning, rather than five accelerated minutes.
- Display updates once per second independently of accelerated timer increments.
- Adds /function iota_hearts:diagnose for total/base health, saved attributes and timer scores.
- Unknown penalties/base-health changes require diagnosis; this patch does not overwrite max-health base or remove unrelated modifiers.


### Iota 1.0.27

- Adds Trading, covering all thirteen employed villager professions.
- Replaces emerald-paying purchases with 41 themed offers; preserves other sales.
- Butchers buy eggs, carrots, potatoes, beetroot and milk; sell cooked meat. Milk payment includes the consumed bucket.
- Purchases unlock at levels 1–3 and have eight uses per restock; stock is also refreshed on profession/level transitions.
- Original offer backup retained per villager. Existing villagers are updated as loaded.
- Wandering Traders, unemployed villagers and nitwits unchanged.
- Expansions remain frozen at 0.0.1.


### Iota 1.0.28

- Replaces Armorer, Toolsmith and Weaponsmith sales with five cumulative offers each.
- Eleven multi-item kits open by holding use for 0.8 seconds; four single-item sales deliver equipment directly.
- Kits use non-stackable named paper and item-consumption events, preserving unrelated items; overflow uses vanilla /give drops.
- Diamond/netherite equipment removed from these three sale catalogs. Purchases unchanged.
- Existing merchants update once using catalog revision 2; original backups retained. Other professions' sales unchanged.
- No custom texture/resource pack required; expansions stay frozen at 0.0.1.


### Iota 1.0.29

- Removes the Trading prototype, purchase overrides and equipment kits.
- Discards all earlier Trading design decisions; future study starts from vanilla.
- Base returns to six modules. Other modules unchanged; expansions remain frozen.

### Iota 1.0.30

- Moves 43 enchantment anvil-cost definitions from Tool Mastery to base Tools without changing values.
- Refreshes Tool Mastery 0.0.1 packaging only to remove these definitions.
- Audits repair materials and XP penalties; no new repair-material or prior-work changes.

### Iota 1.0.31

- Tools assigns dedicated repair ingredients to wood/stone/netherite pickaxes, axes, shovels, hoes, swords and spears in either hand: Stick, Flint, Netherite Scrap.
- Other item components, crafting/smithing ingredient tags and armor repair materials are unchanged.
- Native quarter-durability repair, XP cost growth and level cap remain; full repair and broken-item retention are not implemented.

### Iota 1.0.32

- Tools clears repair_cost on 42 managed vanilla tools/weapons across accessible player slots. Other item data is untouched.
- Adds an opt-in broken diamond-pickaxe state fixture; ordinary tools still follow native breakage.
- Hard anvil limit, 25% material-repair amount and armor remain unchanged. Expansions remain frozen.

### Iota 1.0.33

- Opt-in broken-tool prototype now intercepts native wear on marked test pickaxes using a technical item_damage enchantment and two-point reserve.
- Mining/attacks lead into broken state; native repair restores function, retaining the guard for later cycles.
- Adds Unbreaking test variant and fixes missing .mcfunction extension on the test command.
- Normal tools, repair fractions and frozen expansions unchanged.


## Expansions

Both expansions retain distributed 0.0.1 ZIPs. Magical Discovery progression remains paused. Tool Mastery source added [staged Broken preservation](design_directions.md#broken-equipment--staged-for-002). See the [checklist](release_checklist.md) for verification.

### Native enchanting interface boundary

Approved feedback revision on 2026-11-18: all five mastery level-ups share
12 blue particles. Levels III–V add 32 enchantment particles. There are no
extra gold, End Rod or Treasure-purple effects. Progression/reward rules remain
frozen; replace the Tool Mastery 0.0.1 ZIP to receive this visual adjustment.
The anvil sound plays at 0.40, then player level-up at 0.40 eighteen live ticks
later (900 ms at normal tick rate). Death cancels the pending sound. No mastery
level-up or reward messages are sent to the action bar.

Timing evidence: official 1.21.11 asset index 29, `random/anvil_use.ogg`
(SHA-1 f789417f40eee40b4d8ae6422d78f0ce06a94211). The Vorbis stream has
55,126 samples at 44,100 Hz: 1.250023 seconds at pitch 1, or 1.000018 seconds
at the configured pitch 1.25. Eighteen ticks starts level-up about 0.1 seconds
before the anvil file ends at normal game speed. Actual mixing/tail audibility
can vary with the client; no decoder software was installed to measure this.

Command maintenance on 2026-11-18 refreshes both 0.0.1 ZIPs without resuming
feature development. Legacy Efficiency-only register/application POC functions
are removed. Personal status/reset now cover all 41 scanner enchantments;
shared discoveries remain untouched. See [Test Commands](release_checklist.md).

The discovery register does not filter native offers. Static registry/tag files
are not dynamically rewritten by scoreboards; globally selecting enchantment
IDs also does not independently cap each level just for table offers. Changing
vanilla max_level would alter global definitions. Custom interaction or external
support would require a future separate prototype; development remains frozen.
Do not grant an enchantment and strip it afterward as a substitute for gating.

### Anvil behavior

See the [anvil study](discovery/research/reports/anvil_behavior.md) for verified resource changes, vanilla persistence findings
and limits. Enchantment anvil-cost overrides were relocated to base Tools in 1.0.30.
The refreshed Tool Mastery 0.0.1 ZIP no longer includes those definitions;
its progression remains frozen. Replace older copies to avoid stale overrides.

### Unpackaged maintenance — 2026-11-21

Tool Mastery source corrects the two Broken offhand lore reads to equipment.offhand for 1.21.11. The current capture path preserves exact item data before natural destruction, including lore, enchantments and other-pack data; armor is unequipped on break. No new expansion ZIP was generated. The code still needs the final clean-server load test and uninstall-safety check before release.
