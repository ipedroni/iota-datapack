advancement revoke @s only iota_exp_tool_mastery:shield_using_hand
execute if entity @s[gamemode=survival] if items entity @s weapon.mainhand minecraft:shield[minecraft:custom_data~{iota_mastery:{shield_hand:1b}}] run scoreboard players set @s iota_shield_active 1
