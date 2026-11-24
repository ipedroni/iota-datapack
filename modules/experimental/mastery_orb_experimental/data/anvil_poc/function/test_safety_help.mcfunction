tellraw @s {"text":"[v3.8.7] Safety and compatibility test menu (use a backup world):","color":"gold"}
tellraw @s {"text":"1. Empty BOTH hands, then /function anvil_poc:test_enchantments_different","color":"aqua"}
tellraw @s {"text":"2. Right-click orb, then /function anvil_poc:test_enchantments_verify","color":"aqua"}
tellraw @s {"text":"3. Empty BOTH hands, then /function anvil_poc:test_enchantments_conflict","color":"aqua"}
tellraw @s {"text":"4. Right-click orb, then /function anvil_poc:test_enchantments_conflict_verify","color":"aqua"}
tellraw @s {"text":"5. XP cap, zero gain, missing or invalid tool: follow TEST C in README_v3_8_7.txt and right-click the orb.","color":"yellow"}
tellraw @s {"text":"6. Inventory: test_inventory_fill, test_inventory_status, test_inventory_clear","color":"yellow"}
tellraw @s {"text":"7. Check drops, unrelated player heads, reload and two-player interaction manually.","color":"yellow"}
tellraw @s {"text":"WARNING: No atomic rollback or proven multiplayer isolation. Do not use valuable items.","color":"red"}
