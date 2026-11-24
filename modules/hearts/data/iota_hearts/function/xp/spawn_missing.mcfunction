scoreboard players set #hitbox iota_x_math 0
scoreboard players set #display iota_x_math 0
execute as @e[type=minecraft:interaction,tag=iota_x_orb,distance=..2] if score @s iota_x_id = #owner iota_x_id if score @s iota_x_gen = #generation iota_x_gen run scoreboard players set #hitbox iota_x_math 1
execute as @e[type=minecraft:item_display,tag=iota_x_orb,distance=..2] if score @s iota_x_id = #owner iota_x_id if score @s iota_x_gen = #generation iota_x_gen run scoreboard players set #display iota_x_math 1
execute if score #hitbox iota_x_math matches 0 positioned ~0.5 ~0.8 ~0.5 summon minecraft:interaction run function iota_hearts:xp/init_hitbox
execute if score #display iota_x_math matches 0 positioned ~0.5 ~1.075 ~0.5 summon minecraft:item_display run function iota_hearts:xp/init_display
data modify storage iota_hearts:xp work.record.placed set value 1b
function iota_hearts:xp/save_record with storage iota_hearts:xp work
