execute if score @s iota_l_deaths matches 1.. run function iota_hearts:death
execute unless function iota_hearts:recovery_active run return 0
scoreboard players add @s iota_h_probe 1
execute unless score @s iota_h_near matches 0..1 run scoreboard players set @s iota_h_probe 20
execute if score @s iota_h_probe matches 20.. at @s align xyz store result score @s iota_h_near run function iota_hearts:near_campfire
execute if score @s iota_h_probe matches 20.. run scoreboard players set @s iota_h_probe 0
scoreboard players add @s iota_l_ticks 1
execute if score @s iota_h_near matches 1 run scoreboard players add @s iota_l_ticks 4
execute if score @s iota_h_near matches 1 if score @s iota_h_probe matches 0 at @s run particle minecraft:happy_villager ~ ~0.8 ~ 0.5 0.6 0.5 0 8 force @s
execute if score @s iota_l_ticks matches 6000.. run return run function iota_hearts:recover
execute if score @s iota_h_probe matches 0 run function iota_hearts:recovery_particles
function iota_hearts:display_tick
