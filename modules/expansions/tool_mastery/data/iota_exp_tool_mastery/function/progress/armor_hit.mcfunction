advancement revoke @s only iota_exp_tool_mastery:armor_hit
execute unless entity @s[gamemode=survival] run return 0
execute if score @s iota_armor_cd matches 1.. run return 0
scoreboard players set @s iota_armor_hit 1
scoreboard players set @s iota_armor_cd 40
