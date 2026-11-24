# Executed as old station hitbox, at its current position.
# Adjust only the matching nearby display; do not recreate or consume any items.
execute as @e[type=minecraft:item_display,tag=ap_orb_display_v38,distance=..0.45,limit=1,sort=nearest] run data merge entity @s {transformation:{translation:[0.0f,0.42f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.0f,1.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
tp @s ~ ~0.25 ~
tag @s add ap_orb_v382
