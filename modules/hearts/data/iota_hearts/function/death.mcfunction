scoreboard players add @s iota_l_lost 0
execute if score @s iota_l_lost matches 5.. run effect give @s minecraft:hunger 60 2
execute if score @s iota_l_lost matches ..4 run scoreboard players add @s iota_l_lost 1
scoreboard players set @s iota_l_deaths 0
scoreboard players set @s iota_l_ticks 0
function iota_hearts:apply_health
function iota_hearts:respawn_feedback
