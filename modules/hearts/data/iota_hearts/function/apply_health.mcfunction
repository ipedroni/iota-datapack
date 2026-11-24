attribute @s minecraft:max_health modifier remove iota_hearts:death_penalty
attribute @s minecraft:max_health modifier remove iota_life_death:death_penalty
attribute @s minecraft:max_health modifier remove iota_life:death_penalty
execute if score @s iota_l_lost matches 1 run attribute @s minecraft:max_health modifier add iota_hearts:death_penalty -0.1 add_multiplied_total
execute if score @s iota_l_lost matches 2 run attribute @s minecraft:max_health modifier add iota_hearts:death_penalty -0.2 add_multiplied_total
execute if score @s iota_l_lost matches 3 run attribute @s minecraft:max_health modifier add iota_hearts:death_penalty -0.3 add_multiplied_total
execute if score @s iota_l_lost matches 4 run attribute @s minecraft:max_health modifier add iota_hearts:death_penalty -0.4 add_multiplied_total
execute if score @s iota_l_lost matches 5 run attribute @s minecraft:max_health modifier add iota_hearts:death_penalty -0.5 add_multiplied_total
