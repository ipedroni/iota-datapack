# Show immediately on crouch, then refresh once per real second.
execute if score @s iota_h_hud matches 1 if score @s iota_h_probe matches 0 run function iota_hearts:display
execute unless score @s iota_h_hud matches 1 run function iota_hearts:display
scoreboard players set @s iota_h_hud 1
