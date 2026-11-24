tag @s add iota_x_orb
scoreboard players operation @s iota_x_id = #owner iota_x_id
scoreboard players operation @s iota_x_gen = #generation iota_x_gen
data merge entity @s {billboard:"center",brightness:{block:15,sky:15},view_range:1.0f,shadow_radius:0.0f,item_display:"fixed",transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.45f,0.45f,0.45f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},item:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":{properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjZmZjBhYTQ4NTQ0N2JiOGRjZjQ1OTkyM2I0OWY5MWM0M2IwNDBiZDU2ZTYzMTVkYWE4YjZmODNiNGMzZWI1MSJ9fX0="}]}}}}
