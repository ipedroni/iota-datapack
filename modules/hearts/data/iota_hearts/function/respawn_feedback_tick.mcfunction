# Per-player live ticks preserve the recipient and follow their current location.
scoreboard players remove @s iota_h_fx 1
execute if score @s iota_h_fx matches 0 at @s run particle minecraft:damage_indicator ~ ~1.2 ~ 0.55 0.55 0.55 0.12 24 force @s
