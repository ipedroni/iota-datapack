# Vanilla anvil persistence tests

Target: Minecraft Java 1.21.11. This is a test-only development pack.

Install the ZIP in a disposable world's datapacks folder, run /reload, and run
/function iota_test:help. Use Survival for the anvil operations.
Each setup requires empty hands, adds 30 player experience levels and supplies
disposable items. Existing levels are retained, and repeated setups add another
30 levels. Game mode is unchanged. Move the offhand ingredient into the anvil manually.

| Setup command suffix | Left input | Right input | Expected result XP |
| --- | --- | --- | --- |
| repair | 101, 3000 XP | Iron ingot | 3000 |
| combine | 101, 3000 XP | 202, 2000 XP | 3000 |
| reverse | 202, 2000 XP | 101, 3000 XP | 2000 |
| rename | 101, 3000 XP | Empty | 3000 |

Run /function iota_test:setup/<suffix>, perform the operation, then run
/function iota_test:verify/<suffix> with the result in your main hand.
For combine and reverse, Efficiency II + II should produce Efficiency III.
For repair, damage must decrease. For rename, the new name must appear.

The verifier checks the legacy XP field, the left input's serial number,
a synthetic processed-milestone marker, and unrelated custom data. The marker
tests component persistence and does not implement the future reward system.
An untouched input can pass the verifier: the operator must confirm that the
anvil operation actually occurred. Inspect the displayed components for lore,
enchantments and damage. Repeat using shift-click when collecting the output.
Store the result in a chest and retrieve it, reload and verify again. Save and
reopen the world, then verify again.

## Validation status

Automated checks validate JSON, command target files and generated fixtures.
In-game anvil behavior remains UNVERIFIED until these steps are performed.
Record PASS/FAIL for each operation, shift-click, reload and save/reopen.
These tests do not assert that XP from the right input is transferred.

