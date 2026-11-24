# A restrained wounded-state aura; campfire recovery already has green particles.
execute unless score @s iota_h_near matches 1 at @s run particle minecraft:dust{color:[0.5f,0.22f,0.22f],scale:0.6f} ~ ~0.9 ~ 0.3 0.4 0.3 0 12 force @s
execute unless score @s iota_h_near matches 1 at @s run particle minecraft:dust{color:[0.45f,0.45f,0.45f],scale:0.5f} ~ ~0.9 ~ 0.3 0.4 0.3 0 8 force @s
