scoreboard players set @s primitive_speed_enabled 0
scoreboard players set @s primitive_speed_target 0
function iota_tools:speed_transition
tellraw @s {"text":"Primitive Survival: velocidades personalizadas desativadas.","color":"yellow"}
