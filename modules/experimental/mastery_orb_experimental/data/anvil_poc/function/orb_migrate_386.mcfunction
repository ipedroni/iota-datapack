# Restore the base position used in the physical-head experiment, while keeping the v3.8.4 display.
# v3.8.4 stations: hitbox was spawned at +0.08 then moved down 0.125 => -0.045.
# Desired base: -0.0625, a downward correction of 0.0175 blocks.
tp @s ~ ~-0.0175 ~
data merge entity @s {height:0.55f,width:0.70f}
tag @s add ap_orb_v386
