advancement revoke @s only iota_exp_tool_mastery:shield_block
execute unless entity @s[gamemode=survival] run return 0
execute if score @s iota_shield_active matches 1 if items entity @s weapon.mainhand minecraft:shield[minecraft:custom_data~{iota_mastery:{shield_hand:1b}}] run return run scoreboard players add @s iota_block_hand 1
execute if score @s iota_shield_active matches 2 if items entity @s weapon.offhand minecraft:shield[minecraft:custom_data~{iota_mastery:{shield_hand:2b}}] run return run scoreboard players add @s iota_block_offhand 1
execute if items entity @s weapon.mainhand minecraft:shield unless items entity @s weapon.offhand *[minecraft:blocks_attacks] run return run scoreboard players add @s iota_block_hand 1
execute if items entity @s weapon.offhand minecraft:shield unless items entity @s weapon.mainhand *[minecraft:blocks_attacks] run scoreboard players add @s iota_block_offhand 1
