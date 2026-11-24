scoreboard players set @s ap_orb_found 1
execute align xyz positioned ~0.5 ~0.08 ~0.5 run function anvil_poc:orb_create_here
tellraw @s {"text":"[ORB v3.8] Display station installed. Click directly on the orb.","color":"green"}
