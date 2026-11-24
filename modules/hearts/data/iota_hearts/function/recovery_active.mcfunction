# Detect persisted modifiers before trusting or clearing saved scores.
scoreboard players set #penalty iota_l_math 0
execute store success score #active iota_l_math run attribute @s minecraft:max_health modifier value get iota_hearts:death_penalty
execute store success score #renamed iota_l_math run attribute @s minecraft:max_health modifier value get iota_life_death:death_penalty
execute store success score #legacy iota_l_math run attribute @s minecraft:max_health modifier value get iota_life:death_penalty
execute if score #active iota_l_math matches 1 run scoreboard players set #penalty iota_l_math 1
execute if score #renamed iota_l_math matches 1 run scoreboard players set #penalty iota_l_math 1
execute if score #legacy iota_l_math matches 1 run scoreboard players set #penalty iota_l_math 1
execute if score #penalty iota_l_math matches 0 run return run function iota_hearts:stop_timer
execute unless score @s iota_l_lost matches 1..5 run function iota_hearts:restore_saved_loss
execute unless score @s iota_l_ticks matches 0.. run scoreboard players set @s iota_l_ticks 0
execute if score #renamed iota_l_math matches 1 run function iota_hearts:apply_health
execute if score #legacy iota_l_math matches 1 run function iota_hearts:apply_health
return 1
