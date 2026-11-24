# Anvil behavior — released rules and repair research

## Current answer

Tools reduces the enchantment contribution to anvil costs and clears prior-work
penalties on 42 managed tools and weapons. Each repair ingredient still restores
up to one quarter of durability. The 40-level ceiling remains.

The user's tests confirmed that native anvil operations preserve the left item's
mastery data. They do not transfer mastery XP from the right item. General Broken
preservation is staged in Tool Mastery and still needs final checks. One-unit
full repair was demonstrated in a separate Smithing Table experiment; it is not
an implemented Anvil rule.

Audit target: Minecraft Java 1.21.11, base 1.0.34 and expansions 0.0.1.

## Active changes

The Iota base Tools module owns the enchantment anvil-cost overrides. Magical
Discovery adds no anvil behavior. Tool Mastery no longer owns these resources.

Tools overrides all 43 vanilla enchantment definitions
under modules/tools/data/minecraft/enchantment/. The cost adjustment changes
anvil_cost. Curse overrides are a separate change, so the earlier single-field
comparison does not describe every current Tools override. The cost rule is:

`max(1, ceil(vanilla anvil_cost / 2))`

Examples of definition values (not complete operation prices):

| Enchantment | Vanilla | Tools |
| --- | ---: | ---: |
| Efficiency | 1 | 1 |
| Sharpness | 1 | 1 |
| Unbreaking | 2 | 1 |
| Fortune | 4 | 2 |
| Mending | 4 | 2 |
| Silk Touch | 8 | 4 |
| Thorns | 8 | 4 |

This lowers the enchantment contribution to anvil operations. It does not
uniformly halve the final XP-level cost: vanilla still computes the complete
operation, including book-specific rules, repair, renaming and prior work.
Existing value-one definitions remain one.

## Verified native persistence, not a custom merge feature

In the user's Java 1.21.11 tests, vanilla repair, renaming and combination kept
the mastery XP and unrelated custom data from the LEFT input. Reversing the
inputs changed which progress survived. This uses native item persistence;
Iota does not add the secondary item's mastery XP to the primary item.

Normal vanilla enchantment compatibility, maximum levels and equal-level
combination remain under vanilla anvil rules. No anvil override changes them.

## Limits and exclusions

- No removal of the Too Expensive limit.
- Prior-work penalties are now reset on the 42 managed tools/weapons in accessible player slots by Tools; this does not remove the hard operation ceiling.
- No free repairs or renaming, and no guaranteed fixed total operation price.
- No mastery-XP transfer or addition from the right input.
- No change to the anvil's physical wear, breaking or falling behavior.
- No custom anvil screen or new anvil crafting recipe.

## Separate archived experiment

modules/experimental/mastery_orb_experimental/ contains the old Mastery Orb POC. Its station
has a separate 25% mastery-XP-transfer experiment. It is excluded from the base
and both active expansion ZIPs and is not a vanilla anvil behavior change.
The archived README records its limitations; do not treat it as a completed
implementation of all former 3.8.8 requirements.

## Evidence and reproducibility

Compare the Tools enchantment JSON files with
vendor/generated/data/minecraft/enchantment/. The only altered field should be
anvil_cost and every value should satisfy the formula above. Persistence test
fixtures are in docs/discovery/tests/anvil-persistence/; their in-game results were confirmed
by the user. Static JSON comparisons alone do not establish UI-level prices.

The material/XP comparison and historical alternatives are consolidated below.

As of 1.0.32 Tools resets repair_cost to zero on managed player-held inventory
items. This suppresses repeated-work growth on those items but does not change
the native cost of a current operation. See design_directions.md for scope.

## Material repair audit and historical alternatives

The material comparison originated in 1.0.31. Current baseline is 1.0.34:
Scrap/Stick/Flint ingredients and managed repair_cost clearing are implemented.
The marked broken-pickaxe prototype has user-validated preservation; full
one-unit Anvil repair remains unimplemented. General equipment preservation
has since been staged in Tool Mastery; see the current answer above.

### Evidence

Official item defaults and recipes: vendor/generated/reports/items.json and
vendor/generated/data/minecraft/. Actual Iota durability: modules/tools/data/
iota_tools/item_modifier/. Anvil computation was inspected directly in the
existing official server JAR with the already-bundled javap executable:
vendor/anvil-menu-1.21.11-bytecode.txt (class dhm / AnvilMenu).
The external mapping page was used only to identify the class name. No software
was installed. Downloading the optional mapping text was blocked; it was not
needed for the bytecode inspection.

### Three separate costs

1. Material repair restores up to floor(max_damage / 4) damage per unit and
   charges one operation level per unit, before other applicable costs.
2. Combining two matching equipment items uses their remaining durability plus
   a 12% maximum-durability bonus, capped at the maximum. The sacrifice is used
   up. Enchantment transfer and previous-work costs can make this expensive.
3. Prior work grows by 2 * old_penalty + 1, producing 0, 1, 3, 7, 15, 31, 63.
   The ordinary Survival operation limit remains below 40 levels. Material-only
   repairs still encounter this limit eventually; cheaper enchantment constants
   do not remove it. Rename-only operations have special rules and must not be
   generalized from the repeated-repair calculation.

Four units usually restore approximately a full durability bar. Integer
rounding can require a fifth unit for the final few damage points when maximum
durability is not divisible by four. Required units are determined by current
damage, not simply by material tier or by the original crafting recipe.

### Current Iota handheld tools and swords

These values apply after Tools processes a vanilla item held in the main hand;
spears, armor and modded equipment do not receive this durability override.

| Material | Iota max damage | Repair per unit | Current repair ingredient |
| --- | ---: | ---: | --- |
| Wood | 16 | 4 | Stick |
| Stone | 64 | 16 | Flint |
| Copper | 248 | 62 | Copper tool materials |
| Iron | 456 | 114 | Iron tool materials |
| Gold | 64 | 16 | Gold tool materials |
| Diamond | 1,560 | 390 | Diamond |
| Netherite | 2,032 | 508 | Netherite Scrap |

As of 1.0.31, Tools changes repairable for the eighteen wood/stone/netherite
equipment types when held in either hand. Dedicated tags avoid changing
crafting/smithing material tags. Spears receive the repair override but retain
their vanilla durability. Armor repair remains unchanged.

### Findings from the pre-1.0.31 baseline

- Netherite: one ingot repairs at most a quarter of the durability bar. Four
  ingots contain 16 Netherite Scrap plus 16 Gold Ingots, while upgrading one
  existing diamond item consumes only one ingot plus its smithing template.
  Crafting a replacement is not free: its diamond equipment and template also
  matter, and replacing it need not preserve enchantments or mastery.
- Diamond shovels and hoes require one/two diamonds to craft, yet approximately
  four diamonds to repair a near-empty durability bar using material repair.
  Pickaxes and axes use three diamonds to craft. Armor has a different material
  budget, so a universal four-unit repair rule is not equally punitive for all
  equipment. XP/enchantments/item identity still distinguish repair from replacement.
- Wood and gold also have low durability relative to the amount consumed for
  repairs. A cheap material can still lead to frequent maintenance interactions.
- The prior-work ceiling prevents indefinite anvil-only upkeep even if material
  repair is cheap. Mending avoids both repair-material consumption and this
  repeated-anvil penalty; the pressure toward it has two independent causes.

### Historical ingredient options — selected option shipped in 1.0.31

| Netherite repair ingredient | Implication at vanilla per-unit repair rate |
| --- | --- |
| Netherite Scrap | About four scraps per full repair: one ingot's scrap content, without requiring gold |
| Diamond | Maintains an Overworld repair loop; netherite remains an initial upgrade investment |
| Scrap or Diamond | Player chooses an adventure/resource loop; the units are equal repair value |
| Keep ingots, improve repair amount | Less repetitive consumption but requires a custom mechanism; repairable alone cannot set a different fraction |

Historical recommendation (now implemented): consider Scrap instead of whole ingots
as a conservative first reduction. Diamond is a broader choice about how often
players should revisit the Nether, not an automatically correct answer.

Do NOT add Scrap/Diamond indiscriminately to netherite_tool_materials: that tag
also participates in smithing upgrades, and doing so could cheapen the initial
upgrade unintentionally. Use a dedicated repair tag via repairable components.
Netherite armor uses a separate repairs_netherite_armor tag and requires an
explicit scope decision. Preserve existing item components when applying changes.

Any repair-cost reset/cap is another design decision. Do not wipe repair_cost
from all inventory items as an unnoticed side effect of moving the anvil files.
The audit itself did not change mechanics. Ingredient changes selected afterward
shipped in 1.0.31. The quarter-repair fraction remains; Tools clears prior work on managed items as of 1.0.32.

### Follow-up: shipped prototype versus unimplemented full repair

The user selected Netherite Scrap as sufficient for netherite repair. The
proposed uniform tool repair is one material unit restoring full durability:
ingot for metal tools, Diamond for diamond, Flint for stone, Stick for wood,
and Netherite Scrap for netherite. This supersedes the earlier tentative
ingredient discussion, and is implemented as an ingredient in 1.0.31. Full repair remains proposed;
the shipped quarter-repair rule is unchanged.

The user also asked about removing the 40-level ceiling and repeated-repair
cost escalation, and proposed retaining exhausted equipment in a broken state
with mining disabled until repaired. A safe opt-in diamond-pickaxe prototype shipped in 1.0.33 and was validated by the user. See the [Broken fixture notes](../prototypes/broken_tool_prototype.md); broader equipment scope remains pending.

Technical boundaries: repair_cost can be cleared on managed items; the native
40-level check and quarter-repair fraction are hardcoded. repairable selects
ingredients, not repair amount. A broken marker alone cannot stop native item
destruction; prevention must occur before the destructive use and handle more
than one durability lost at once. Do not recreate tools from stale snapshots
or treat tick sampling as guaranteed interception. Full repair, clearing the
broken state and restoration of original components require explicit logic.

### Manual checks

- Compare a damaged netherite pickaxe before and after Tools processes it.
- At Iota max_damage 2032, each Scrap should restore up to 508 damage.
- Compare repeated plain-material repairs with enchanted-item combinations;
  record the prior repair_cost and displayed level price separately.
- Check wood/stone repair ingredients against the changed crafting recipes.
- Verify left-item custom data/mastery preservation with active expansions.

### 1.0.32 update

Tools now clears prior-work repair_cost on managed tools/weapons in accessible
player slots. The repeated-cost findings above describe vanilla and the older
baseline; the hard operation cap and 25% repair fraction remain in Iota.
One-material full repair is not implemented. The opt-in diamond-pickaxe fixture uses a bounded native-wear guard and was
validated by the user for natural wear. This is not universal equipment
protection. See the [Broken fixture notes](../prototypes/broken_tool_prototype.md).

## New native repair evidence — 2026-11-20

An isolated SmithingTransformRecipe POC with an empty template fully repairs equipment using one material. Tests cover80 native item assemblies and actual GUI consumption of one Diamond for an enchanted pickaxe and helmet, including a Broken armor repair cycle. Enchantments, lore and unrelated custom data survive. This alternative is research only; it does not change the selected Anvil workflow or its native25%per-material repair.

### Decision history — superseded armor capture

The first armor interception POC lost items under command-context damage because
its function ran after destruction. That failure remains useful evidence. The
later capture method uses a synchronous loot reward to preserve fresh item data
before the queued function runs. General protection is staged, with final
regression checks still pending. The offhand fixes use equipment.offhand in
1.21.11. No revised expansion ZIP has been released.
