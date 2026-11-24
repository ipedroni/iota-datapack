execute at @s if entity @e[type=minecraft:villager,tag=iota_trades_catalog,distance=..8] run function iota_trades_qual:refresh
advancement revoke @s only iota_trades_qual:inventory_event
