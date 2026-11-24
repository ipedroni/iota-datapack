scoreboard players set @s primitive_fatigue 0
function iota_hands_off:hand_speed_tick
tellraw @s {"text":"Primitive Survival: penalidade de mineracao manual desativada.","color":"yellow"}
