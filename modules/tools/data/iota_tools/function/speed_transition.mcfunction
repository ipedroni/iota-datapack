# Remove only Primitive Survival's own modifier. Other mods' modifiers are preserved.
execute if score @s primitive_speed_state matches 1..3 run attribute @s minecraft:block_break_speed modifier remove primitive:tool_speed
execute if score @s primitive_speed_target matches 1 run attribute @s minecraft:block_break_speed modifier add primitive:tool_speed -0.5 add_multiplied_total
execute if score @s primitive_speed_target matches 2 run attribute @s minecraft:block_break_speed modifier add primitive:tool_speed -0.5 add_multiplied_total
execute if score @s primitive_speed_target matches 3 run attribute @s minecraft:block_break_speed modifier add primitive:tool_speed 0.1111111111111111 add_multiplied_total
scoreboard players operation @s primitive_speed_state = @s primitive_speed_target
