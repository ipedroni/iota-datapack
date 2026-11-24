execute at @s as @e[type=minecraft:interaction,tag=ap_orb_v38,distance=..5] at @s run kill @e[type=minecraft:item_display,tag=ap_orb_display_v38,distance=..0.5]
execute at @s run kill @e[type=minecraft:interaction,tag=ap_orb,distance=..5]
tellraw @s {"text":"[ORB] Nearby station hitboxes removed; physical heads preserved.","color":"yellow"}
