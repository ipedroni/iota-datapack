# Negative feedback only once per failed click, around the nearest station.
execute at @s as @e[type=minecraft:interaction,tag=ap_orb_v38,sort=nearest,limit=1,distance=..6] at @s run particle minecraft:smoke ~ ~0.30 ~ 0.13 0.09 0.13 0.012 7 normal
execute at @s run playsound minecraft:block.anvil.land master @s ~ ~ ~ 0.28 0.75
