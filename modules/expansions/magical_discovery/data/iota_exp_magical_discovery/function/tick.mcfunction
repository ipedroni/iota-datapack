scoreboard players add #scan id_scan 1
execute if score #scan id_scan matches 20.. as @a run function iota_exp_magical_discovery:scan_inventory
execute if score #scan id_scan matches 20.. run scoreboard players set #scan id_scan 0
