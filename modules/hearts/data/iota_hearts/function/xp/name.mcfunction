data merge entity @s {CustomName:{text:"Experience Orb",italic:false},CustomNameVisible:0b}
execute if entity @s[type=minecraft:item_display] run data modify entity @s item.components."minecraft:custom_name" set value {text:"Experience Orb",italic:false}
tag @s add iota_x_named
