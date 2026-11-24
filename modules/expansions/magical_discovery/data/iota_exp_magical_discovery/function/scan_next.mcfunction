data modify storage iota_exp_magical_discovery:scan item set from storage iota_exp_magical_discovery:scan queue[0]
execute if data storage iota_exp_magical_discovery:scan item.components."minecraft:enchantments" run function iota_exp_magical_discovery:scan_enchants
execute if data storage iota_exp_magical_discovery:scan item.components."minecraft:stored_enchantments" run function iota_exp_magical_discovery:scan_enchants
data remove storage iota_exp_magical_discovery:scan queue[0]
execute if data storage iota_exp_magical_discovery:scan queue[0] run function iota_exp_magical_discovery:scan_next
