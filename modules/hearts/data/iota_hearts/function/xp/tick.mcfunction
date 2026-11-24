# Process deaths before any loaded orb can be claimed.
execute as @a unless score @s iota_x_id matches 1.. run function iota_hearts:xp/init_player
execute as @a[gamemode=survival,scores={iota_x_dead=1..}] run function iota_hearts:xp/death
execute as @a[gamemode=!survival,scores={iota_x_dead=1..}] run scoreboard players set @s iota_x_dead 0
execute as @a unless entity @s[nbt={Health:0.0f}] at @s run function iota_hearts:xp/player
execute in minecraft:overworld as @e[tag=iota_x_orb] at @s run function iota_hearts:xp/entity
execute in minecraft:the_nether as @e[tag=iota_x_orb] at @s run function iota_hearts:xp/entity
execute in minecraft:the_end as @e[tag=iota_x_orb] at @s run function iota_hearts:xp/entity
