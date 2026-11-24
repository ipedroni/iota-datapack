# Olhe para a cabeca ja instalada sobre uma Anvil (ate 5 blocos).
scoreboard players set @s ap_orb_ray 0
scoreboard players set @s ap_orb_found 0
execute anchored eyes positioned ^ ^ ^0.25 run function anvil_poc:orb_ray
execute if score @s ap_orb_found matches 0 run tellraw @s {"text":"[ORBE] Nenhuma cabeca sobre Anvil encontrada na mira (ate 5 blocos). Aponte para a cabeca.","color":"red"}
