# Called only after the owner's successful single payout.
playsound minecraft:entity.experience_orb.pickup master @s ~ ~1 ~ 1.0 1.1
playsound minecraft:block.amethyst_block.chime master @s ~ ~1 ~ 0.4 1.4
particle minecraft:dust{color:[0.35f,1.0f,0.1f],scale:1.0f} ~ ~1 ~ 0.55 0.6 0.55 0 24 force @s
particle minecraft:dust{color:[1.0f,0.9f,0.15f],scale:0.8f} ~ ~1 ~ 0.5 0.5 0.5 0 16 force @s
particle minecraft:happy_villager ~ ~1 ~ 0.45 0.5 0.45 0 16 force @s
