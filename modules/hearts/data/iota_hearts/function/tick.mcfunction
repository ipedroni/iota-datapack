function iota_hearts:xp/tick
execute as @a[gamemode=survival,scores={iota_h_fx=1..}] unless entity @s[nbt={Health:0.0f}] unless score @s iota_l_deaths matches 1.. run function iota_hearts:respawn_feedback_tick
execute as @a[gamemode=survival] unless entity @s[nbt={Health:0.0f}] run function iota_hearts:player
