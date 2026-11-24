# Avanca pela direcao da mira; o jogador continua sendo @s.
execute if block ~ ~ ~ minecraft:player_head if block ~ ~-1 ~ #anvil_poc:anvils run function anvil_poc:orb_install_here
execute if score @s ap_orb_found matches 0 run scoreboard players add @s ap_orb_ray 1
execute if score @s ap_orb_found matches 0 if score @s ap_orb_ray matches ..20 positioned ^ ^ ^0.25 run function anvil_poc:orb_ray
