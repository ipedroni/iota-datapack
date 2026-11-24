# v3.8: Convert a placed head into a non-blocking display + full-height interaction.
# Runs at the HEAD block location, not player location.
execute align xyz positioned ~0.5 ~0.08 ~0.5 unless entity @e[type=minecraft:interaction,tag=ap_orb_v38,distance=..0.4] run function anvil_poc:orb_create_here
