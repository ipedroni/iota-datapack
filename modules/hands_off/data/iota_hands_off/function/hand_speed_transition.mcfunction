# Separate modifier ID from vanilla tool-speed modifiers.
execute if score @s primitive_hand_state matches 1 run attribute @s minecraft:block_break_speed modifier remove primitive:hand_penalty
execute if score @s primitive_hand_target matches 1 run attribute @s minecraft:block_break_speed modifier add primitive:hand_penalty -0.80 add_multiplied_total
scoreboard players operation @s primitive_hand_state = @s primitive_hand_target
