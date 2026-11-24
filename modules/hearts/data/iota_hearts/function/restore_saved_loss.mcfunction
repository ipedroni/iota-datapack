scoreboard players set @s iota_l_lost 1
execute if score #active iota_l_math matches 1 store result score @s iota_l_lost run attribute @s minecraft:max_health modifier value get iota_hearts:death_penalty -10
execute unless score #active iota_l_math matches 1 if score #renamed iota_l_math matches 1 store result score @s iota_l_lost run attribute @s minecraft:max_health modifier value get iota_life_death:death_penalty -10
execute unless score #active iota_l_math matches 1 unless score #renamed iota_l_math matches 1 if score #legacy iota_l_math matches 1 store result score @s iota_l_lost run attribute @s minecraft:max_health modifier value get iota_life:death_penalty -10
execute if score @s iota_l_lost matches ..0 run scoreboard players set @s iota_l_lost 1
execute if score @s iota_l_lost matches 6.. run scoreboard players set @s iota_l_lost 5
