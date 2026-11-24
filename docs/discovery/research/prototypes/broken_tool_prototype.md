# Broken equipment — staged Tool Mastery maintenance

The shipped fixture and the staged implementation are different versions. The
current source targets Tool Mastery 0.0.2; no new expansion ZIP is released yet.

## Current implementation and remaining checks

The capture prototype covers 76 mining tools, weapons and armor items. It
captures current item data before destruction, marks the replacement Broken,
and removes broken armor from equipment slots. A one-point durability reserve
allows the disabled-item components to work. Native anvil repair restores the
saved components while retaining item identity and unrelated data.

The earlier 76-item test predates the latest reserve and integration changes.
Do not treat it as a complete regression test of the current source. Final
checks include full lifecycle regression, repeated capture after grinding,
uninstall safety, and overflow with a full inventory. Hardcoded right-click
utilities and unusual offhand or modded interactions are not fully covered.

Brushes, shears, fishing rods, elytra, animal armor and other utility items are
outside this 76-item scope. The source does not prove protection for every
damageable item in Minecraft.

See the [prototype index](../../prototype_index.md) for native capture,
equipment and lifecycle results and their reproduction scripts.

## Decision history — original pickaxe fixture

The following describes the earlier opt-in fixture and its original tests.
Its two-point reserve and rollout limitations do not describe the newer source.


The published base 1.0.34 fixture uses the corresponding `iota_tools:test/…`
commands. The examples below use the staged Tool Mastery source namespace.

To issue the opt-in fixture from staged Tool Mastery, run:
/function iota_exp_tool_mastery:test/broken_pickaxe
Or test Unbreaking II:
/function iota_exp_tool_mastery:test/broken_pickaxe_unbreaking
Inspect the held item:
/function iota_exp_tool_mastery:test/broken_status

Each newly issued diamond pickaxe starts with four durability remaining at
max_damage 1560 and has the technical Iota Durability Guard enchantment. The
guard is not in table, loot or trade tags. Its item_damage effect sets wear to
zero when an enabled test item has at most two durability remaining. This
executes inside the native wear calculation, before the item can be destroyed.
Unbreaking can reduce wear further; it cannot turn the zeroed damage positive.

The two-point reserve covers the tested pickaxe's normal one-point mining and
two-point attack wear. A later tick changes the item to broken: mining speed
and block/attack wear become zero. The reserved durability stays internally;
the item is logically broken, not literally a native zero-durability item.
A tiny interval before that tick can still allow another action, but the guard
should prevent further native wear. This must be verified in Minecraft.

A diamond repair at the native anvil restores up to 25%. Holding the repaired
item in either hand restores the original tool and weapon components once
remaining durability exceeds two. The guard stays for the next wear cycle.
Name, other_pack.keep_me, enchantments and unrelated components are preserved.
The previous test helper lacked its .mcfunction extension; 1.0.33 fixes this.
Use newly issued fixtures; older experimental fixtures are not production gear.

## Manual checklist

1.0.34 feedback: entering broken appends a red `Broken` line and plays one
item-break sound with crit/smoke particles for the owner. Repair removes only
the marked status line, preserving other lore. The vanilla icon is unchanged.
Use a fresh fixture or repair and break an older fixture to trigger feedback.

- [ ] Confirm one sound/particle burst per break, with no repeating tick effect.
- [ ] Confirm Broken appears, disappears after repair and returns on next break.
- [ ] Add unrelated lore before/after Broken; repair must preserve those lines.

User validation (2026-11-18): the normal and enchanted test pickaxes both
survived natural wear and entered the broken state successfully. This confirms
the reported preservation scenario; it does not mark attacks, repairs, rapid
actions, hand swaps, relogs or repeated cycles as tested.

- [x] User confirmed preservation and broken-state transition for normal and enchanted test pickaxes.
- [ ] Independently record the specific blocks and wear paths exercised.
- [ ] Repeat using entity attacks, including the final two-point wear boundary.
- [ ] Repeat with Unbreaking II and rapid actions; no destruction or duplicate tools.
- [ ] Broken state prevents mining stone/dirt and no additional wear occurs.
- [ ] Repair with diamond in the anvil, hold the output, mine again, and repeat.
- [ ] Name, Unbreaking, guard and other_pack.keep_me survive every cycle.
- [ ] Test both hands, item swaps, disconnect/rejoin and death.
- [ ] Normal unmarked tools and other custom items are unaffected.
- [ ] Technical enchantment must not appear as a table/loot/trade reward.

## Boundaries

This is not enabled on general equipment. Arbitrary damage over two, modded
wear, Mending, grinding, smithing, commands that remove the guard, unusual
component edits and all other equipment families require separate design and
tests. Do not smith or grind these disposable fixtures during baseline tests.
The technical enchantment is visible for debugging. No resource pack required.
One-material full repair and removal of the native 40-level ceiling are not
implemented. The proof below is a bounded model, not a Minecraft execution test.


## Historical rollout technical gate

This gate was written for the original fixture. See the [staged coverage and
remaining checks](#current-implementation-and-remaining-checks) above.

Armor/shields may lose more than two durability in one event; the existing
threshold is not a destruction guarantee for them. Tick restoration after loss
is unsafe. Official1.21.11 ItemStack.applyDamage triggers the durability
advancement before setting damage, then consumes the old stack and invokes the
break callback. A replacement-before-break prototype must first prove source
identity (identical main/offhand items, multiple armor pieces, swaps), callback
safety and a transactional unequip path with full inventory. No general rollout
is activated until those tests pass. Do not use nonexistent clamped value effects;
the native registry does not contain that enchantment effect type.
