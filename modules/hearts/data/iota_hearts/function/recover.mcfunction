execute unless score @s iota_l_lost matches 1.. run return fail
scoreboard players reset @s iota_l_lost
scoreboard players reset @s iota_l_ticks
function iota_hearts:apply_health
scoreboard players set @s iota_h_hud 0
execute at @s run particle minecraft:heart ~ ~1.2 ~ 0.65 0.45 0.65 0 12 normal @s
execute at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~1.6 ~ 0.7 1.15
title @s actionbar {"text":"Maximum health restored","color":"green"}
