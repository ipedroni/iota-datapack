data modify storage iota_exp_magical_discovery:scan queue set from entity @s Inventory
execute if data storage iota_exp_magical_discovery:scan queue[0] run function iota_exp_magical_discovery:scan_next
