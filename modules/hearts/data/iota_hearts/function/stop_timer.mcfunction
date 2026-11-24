execute if score @s iota_h_hud matches 1 run function iota_hearts:hide_timer
execute if score @s iota_l_ticks = @s iota_l_ticks run scoreboard players reset @s iota_l_ticks
execute if score @s iota_l_lost = @s iota_l_lost run scoreboard players reset @s iota_l_lost
return fail
