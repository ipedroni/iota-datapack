# Iota — tests and commands

Minecraft Java 1.21.11. Manual checks and development commands are grouped below. Automated evidence retains its recorded scope.

## Iota — current manual verification

Use the [published baseline](design_directions.md) unless a check explicitly targets staged source or a prototype. This is a regression checklist, not a claim
that every item remains untested. The user confirmed the recent Hearts fixes
and the requested recipe adjustments. Retest relevant cases after changes.

### Installation

- [ ] Enable only one Iota base ZIP. Expansions are optional, separate 0.0.1 ZIPs.
- [ ] Trading is vanilla; no old Iota kits or trade overrides are installed.
### Recipes and Drops

- [ ] Craft the [tool recipes](design_directions.md#tools-1), including both spear orientations and the wooden sword and shovel.
- [ ] Exercise each [materials, storage and automation recipe](design_directions.md#recipes), including both lamp arrangements, both comparator recipes and the vanilla Rabbit Hide-to-Leather reverse route.
- [ ] Compare [shape production](design_directions.md#building) in both stations, including mirrored crafting, wood and the two copper routes.
- [ ] Test [reclaiming](design_directions.md#reclaiming), including both stair orientations and both ice conversions.
- [ ] Species, moss, wax and oxidation survive recovery. Mixed materials do not match. Test shift-click and repeated cycles.
- [ ] Audited polished, brick, pillar and chiseled finishes are Stonecutter-only; moss addition, waxing, material assembly and Chiseled Bookshelf stay on the table.
- [ ] Recovery recipe unlocks work; test limited crafting if used.
- [ ] Grass seed drops are 8% (statistical check); vegetation and bundle loot remain appropriate.

### World and Hearts

- [ ] On a fresh world and on a world upgraded from 1.0.34, verify that `minecraft:mob_griefing` initializes to `false`. Set it back to `true` and verify that reload and restart preserve the change.
- [ ] With the rule disabled, verify that Endermen leave eligible blocks untouched and that Creeper explosions damage nearby entities while leaving terrain intact.

- [ ] Daytime sleep advances three game hours; night sleep reaches dawn; both clear rain.
- [ ] Death preserves inventory and removes one maximum heart, capped at five; every death resets five-minute recovery.
- [ ] Death at the cap refreshes Hunger III for sixty seconds, without further heart loss.
- [ ] Recovery restores all maximum-heart slots together, stops its timer and plays feedback.
- [ ] Relog with lost hearts; test legacy penalty migration and missing saved counters.
- [ ] A lit campfire or soul campfire within four block-grid units accelerates recovery to one minute, with green particles. Multiple fires do not stack.
- [ ] Countdown shows real estimated waiting time; leaving/extinguishing the fire switches to normal rate within one second.
- [ ] Check /function iota_hearts:recover_in_10s and :diagnose when troubleshooting. Maximum-health restoration does not instantly fill empty hearts.

### Published optional expansions

Use the published [Mastery](design_directions.md#iota-expanded-tool-mastery) and [Discovery](design_directions.md#iota-expanded-magical-discovery) behavior as the reference.

- [ ] Test existing mastery XP/rank and discoveries when migrating to the new expansion namespaces.
- [ ] Use all five level-up fixtures to test rewards, particles, sounds and the absence of reward action-bar messages. Die during the delayed sound. Check armor and shield XP and verify anvil use does not duplicate rewards.
- [ ] Check the refreshed help and personal Discovery reset/status for all 41 entries. Verify rediscovery and shared world preservation.
- [ ] Anvil repair, rename and combination keep left-item mastery/custom data; right XP is not added.
- [ ] Base Tools supplies enchantment anvil-cost reductions; installing Tool
  Mastery must not change those definitions. Total operation cost is not uniformly halved.
- [ ] Direct inventory books/equipment register discoveries; closed container contents are excluded.
- [ ] A mastery reward immediately updates shared world_status; lower discoveries do not reduce the recorded maximum.
- [ ] Each expansion works without the other. Native Enchanting Table offers remain unchanged.

### Automated verification

Run node tools/validate-recipes.mjs and build using tools/build-integrated.ps1.
These validate static resources, recipe invariants and packaging, not Minecraft
loading, UI behavior or every possible interaction.

### Anvil ownership migration

- [ ] Base alone applies the reduced enchantment cost definitions.
- [ ] Refreshed Tool Mastery 0.0.1 has no enchantment overrides.
- [ ] Managed netherite tools/weapons repair with Scrap; armor repair remains vanilla.

### Repair ingredients — 1.0.31

- [ ] Hold existing/new wooden, stone and netherite equipment in either hand before using the anvil; test all six families including spears.
- [ ] Stick repairs wood; Flint repairs stone; Netherite Scrap repairs netherite. Old materials no longer match these tools.
- [ ] Item names, enchantments, mastery and unrelated custom data survive repair-property assignment.
- [ ] Armor and netherite smithing upgrades remain vanilla; scrap cannot replace the upgrade ingot.
- [ ] Each unit still repairs up to 25%; the full-repair proposal is not shipped.

### Tools 1.0.32

- [ ] Give a managed item repair_cost=31, name/enchantments/custom data; verify only repair_cost becomes zero, including after an anvil operation.
- [ ] Repeat across hotbar, inventory, offhand and cursor in Survival.
- [ ] Armor/modded items and nested-container contents remain unchanged.

### Hearts recoverable XP — revised 1.0.34

See [Hearts](design_directions.md#hearts) for expected timing and XP behavior.

- [x] User confirmed orb replacement after a subsequent death on 2026-11-18;
  the initially reported missing orb was present.
- [ ] Death feedback particles appear once, ten live ticks after respawn,
  including at five lost hearts; moving before they appear follows the player.

- [ ] While maximum hearts are lost, verify subtle red/gray particles once per
  second; campfire proximity substitutes the existing green recovery particles.
- [ ] Crouching immediately shows Full recovery in m:ss; standing clears it.
  Check accelerated campfire time, crouch toggles and full recovery while crouched.
- [ ] With maximum hearts restored, no timer/aura should appear, even if normal
  current health is below full. Recovery completion feedback remains visible.

- [ ] Check the Hearts XP recovery cycle: 1,000 → 750 + 250 → 1,000; repeated death
  without recovery leaves 563 + a new 187-point orb, forfeiting the old 250.
- [ ] Verify owner-only single claim, zero-XP invalidation, offline/reload state,
  unloaded chunks, all three vanilla dimensions and respawn fallbacks.
- [ ] Confirm texture, dust, pickup sound and existing Hearts/broken behavior.

### Broken-state fixture regression

Use base 1.0.34 for the published pickaxe fixture, and staged Tool Mastery 0.0.2 for [expanded coverage](design_directions.md#broken-equipment--staged-for-002). See the [fixture procedure](discovery/research/prototypes/broken_tool_prototype.md).

- [x] User confirmed on 2026-11-18 that normal and enchanted test pickaxes survive and enter broken state. Other scenarios below remain separate checks.

- [ ] Exhaust a newly issued test pickaxe by mining and by attacks; repair and repeat.
- [ ] Repeat with Unbreaking, fast actions, swaps and relogs.
- [ ] No normal item gains the technical guard; no fixture duplicates or loses data.

- [ ] On staged source, repeat natural break and repair across supported families, including both hands, armor and a full inventory. Check item identity, lore, enchantments and unrelated custom data through swaps, relogs and grinding. Verify repeated capture safety, clean native loading and safe removal of the expansion.

### Staged base 1.0.35

- [ ] Verify [curse suppression](design_directions.md#curse-suppression--staged-for-1035) in player inventory, on equipped gear and after withdrawal or trade. Verify unrelated enchantments and components survive.
- [ ] Spot-check [staged metal drops](design_directions.md#staged-metal-drops--not-yet-packaged) with natural player kills, without player credit and with Looting. Verify non-metal loot and salvage.

### Automated research evidence — 2026-11-20

The [execution directory](discovery/research/outputs/trading_execution-2026-11-20/) records the tested builds and fixtures.

- Staged metal drops passed 16,000 native deaths with controlled player attribution and Looting. Natural last-hit edge cases and farm throughput are outside that result.
- Staged curse cleanup passed native [inventory, equipment and pickup checks](discovery/research/outputs/trading_execution-2026-11-20/player-curse-results.json). Separate [native GUI cases](discovery/research/outputs/trading_execution-2026-11-20/native-merchant-gui-results.json) verified a chest withdrawal and a villager book purchase with a protocol client.
- Historical Trading checks covered 52 six-level plans, 762 candidate options, 320 native enchantment-support checks and 540 undiscounted resale comparisons. The candidate price audit found 434 profitable Hero V resale pairs even with `priceMultiplier=0`. Native ItemCost matched exact damage and component values, including exact custom-data compounds. The separate qualification experiment tested minimum/OR eligibility.
- The [archived economic studies](discovery/research_index.md#medições-de-farm-e-simulações-arquivadas) include 200,000 abstract 24-hour journeys under explicit sleep, transport, stock and Hero assumptions. They carry no measured human setup or travel times. In one sampled seed, 46 biome searches included a Desert/Jungle pair about 195 blocks apart. That sample supplies no general distance guarantee.

- Native qualification:18GUI cases and5lifecycle cases across six equipment groups. Metadata, unrelated Player Heads, invalid-item rejection, cursor/reload, actual chest withdrawal, actual drop/foreign pickup and optional guard compatibility pass.
- Experimental Trades identity:5native cases including real Hard-mode zombification and shortened conversion. Identity, names and native offer uses persist. Exact-target events work with overlapping villagers; separate player UUIDs each receive3commercial XP and zero-delta replay receives none. This prototype is excluded from the base and has a64-ID research channel bound.
- Broken offhand: explicit real expansion break/restore functions preserve lore, enchantments and unrelated data after the1.21.11data-path fix. Natural universal equipment protection remains unproven.
- Existing structural suites pass:857module JSON files,1664effective recipes,330active functions and807references; the optional Trades prototype adds its own checked functions. Currency arithmetic covers51200targets; Hearts XP arithmetic covers65590cases. These counts do not prove every Minecraft interaction.

Still manual or unresolved: human tooltip/feedback clarity, complete custom offer publication and promotion, native restock interference, World/sleep replenishment, regional identity and historical requirements still under review and universal Broken protection. Do not install research fixtures as a finished Trades release.


## Trading redesign — checks still needed

Use the [Trading design](discovery/drafts/trading_design_directions.md). Enable Villager Trade Rebalance explicitly only in comparison worlds that require it. Verify plug-and-play installation for the final ZIP.

- Verify the five-level offer counts, Leatherworker exception, retained offers, sale order, independent regional slots and persistent draws.
- Verify full durability, Basic I–II acceptance and item preservation after the mixed-enchantment rule is decided. Prior native eligibility tests used minimum/OR predicates.
- Verify restock preserves enchantments and respects work, sleep and live offer state.
- Test enchanted animal armor while equipped on horses and wolves. See the [animal armor cases](discovery/drafts/trading_profession_catalog_draft.md#animal-armor-validation). Component creation alone establishes item data only.
- Compare stock exhaustion and restock with World enabled and disabled, including daytime sleep, night skipping, loaded work time and equal real-time windows.
- Test effective prices and reversible routes across vendors with discounts, including Hero of the Village, and with integer lots. Exercise regional anchor, bounds and relocation cases.
- Verify promotion and sorting preserve live offer state and never change indices during a transaction. Cover reload, cure, bootstrap XP and player-chosen names. Retest clean isolated loading for the build being packaged.

## Development command audit — 2026-11-18

Applies to Iota base 1.0.34 and the two optional expansions 0.0.1. This is
command/test maintenance, not a restart of expansion feature development.
Use disposable worlds for item grants, XP overrides and discovery resets.
Commands are player-run `/function <ID>` unless otherwise indicated.

### Removed

| Function ID | Reason |
| --- | --- |
| `iota_exp_magical_discovery:register` | Obsolete Efficiency-III-only POC; inventory scanning now registers eligible books/equipment automatically. |
| `iota_exp_magical_discovery:apply_efficiency_3` | Obsolete manual enchanting entry point outside the frozen discovery-register scope. |
| `iota_exp_magical_discovery:apply_unlocked` | Internal helper used only by the removed manual enchanting command. |
| `iota_exp_magical_discovery:apply_paid` | Internal helper that spent three XP levels and applied Efficiency III; no current supported caller. |
| `iota_drops:test_structure_loot` | Redundant container-target version of the six preview loot rolls; keep the inventory-based test instead. |

Removed stale help instructions, misleading scratch-score diagnostic output
and unused `ed_levels`/`ed_success` objective declarations. Existing world
scoreboards are not deleted. Compatibility fields and stored discoveries remain.

### Iota base — retained

| Function ID | Purpose / side effect |
| --- | --- |
| `iota_drops:test_bundles` | Grants five themed bundle samples. Inventory space required. |
| `iota_drops:test_structure_loot_all` | Rolls six structure-preview bundle loot tables into inventory. Random; an empty roll is not a failure. Does not inspect naturally generated chests. |
| `iota_exp_tool_mastery:test/broken_pickaxe` | Grants the opt-in nearly worn prototype pickaxe. Ordinary equipment remains outside the prototype. |
| `iota_exp_tool_mastery:test/broken_pickaxe_unbreaking` | Separate Unbreaking fixture; tests enchantment interaction, not a duplicate. |
| `iota_exp_tool_mastery:test/broken_status` | Reads held-item components without modifying them. |
| `iota_hearts:diagnose` | Reads maximum-health attributes, loss count and recovery timer. |
| `iota_hearts:recover_in_10s` | Advances active heart recovery to at most ten normal-rate seconds remaining; campfires accelerate it further. |
| `iota_hearts:recover` | Instant recovery of tracked maximum-heart loss and timer cleanup. Does not fill ordinary missing current health. Existing gameplay function, also useful manually. |
| `iota_hearts:xp/diagnose` | Reads current reconstructed XP and personal recovery record. |
| `iota_hearts:xp/test_setup` | **Replaces current XP with 1,000 points.** For controlled death tests only; does not reset an existing orb. |

Both Hearts diagnoses are needed: health recovery and recoverable XP use
different state. Confirmed scenarios remain useful regressions after changes.

### Tool Mastery — retained

Requires the expansion installed. Each fixture grants a diamond pickaxe just
below a distinct level threshold. Hold it in the main hand in Survival and mine
one stone block. The five commands are intentionally retained:

```mcfunction
/function iota_exp_tool_mastery:test/level_up_i
/function iota_exp_tool_mastery:test/level_up_ii
/function iota_exp_tool_mastery:test/level_up_iii
/function iota_exp_tool_mastery:test/level_up_iv
/function iota_exp_tool_mastery:test/level_up_v
```

They test Rookie, Apprentice, Adept, Expert and Masterwork transitions,
notifications and eligible milestone rewards. A fixture grant is not a full
armor/ranged/shield progression test or proof that every random reward occurs.
Keep `iota_exp_tool_mastery:status` for held-item XP and `:help` for guidance.
Help now accurately distinguishes the visible rank from command-inspected XP.

### Magical Discovery — retained and corrected

| Function ID | Purpose |
| --- | --- |
| `iota_exp_magical_discovery:status` | Public shorthand for the shared world list; retained for compatibility. |
| `iota_exp_magical_discovery:world_status` | Explicit shared-world list, including initial unlocked entries. |
| `iota_exp_magical_discovery:mastery_status` | Personal discoveries; name retained for compatibility. Now correctly labeled and includes all 41 scanner enchantments, not only mastery reward candidates. |
| `iota_exp_magical_discovery:diagnose` | Inspects the held item's enchantment components; no longer presents the temporary `ed_found` value as meaningful discovery status. |
| `iota_exp_magical_discovery:reset` | Clears all 41 personal enchantment counters, including seven previously omitted. Keeps the world register. Carried items are automatically rediscovered. |
| `iota_exp_magical_discovery:help` | Describes automatic scanning, the above commands and unchanged native table offers. |

The generator now preserves scanner objectives beyond the reward pool when
rebuilt, including the scan clock, and generates complete personal lists/resets.
This avoids reintroducing the incomplete command coverage. Progression and
reward probabilities are unchanged. Reset is a manual utility, not gameplay.

### Separate and archived tests

Keep `docs/discovery/tests/anvil-persistence/` and `tools/build-anvil-tests.mjs` as reproducible
vanilla anvil regression evidence. The test-only pack is not included in base
or expansion ZIPs. Four setup/verify pairs cover repair, combine, reversed
inputs and rename; user-validated custom-data persistence is distinct from
the current broken-tool and repair-property tests.

The archived Mastery Orb POC is outside this cleanup. Its standalone code and
debug functions remain archived; no `anvil_poc` or `iota_test` namespace is
introduced into current playable distributions.

### Validation and manual follow-up

Static checks cover retained command existence, removed-function absence,
function references in active code/help/tags, complete Discovery personal
status/reset coverage, JSON parsing and distribution boundaries. They do not
load Minecraft. Recheck updated help, personal reset/re-discovery, held-item
diagnoses and all five level-up fixtures in a disposable world after installing
the refreshed ZIPs. Expansion versions remain 0.0.1; replace old copies.
