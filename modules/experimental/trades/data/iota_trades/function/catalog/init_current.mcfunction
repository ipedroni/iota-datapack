data modify storage iota_trades:scratch init.region set value "current"
execute if data entity @s VillagerData{profession:"minecraft:librarian"} run return run function iota_trades:catalog/init_current_librarian
execute if data entity @s VillagerData{profession:"minecraft:toolsmith"} store result storage iota_trades:scratch init.draw int 1 run random value 0..15
execute unless data entity @s VillagerData{profession:"minecraft:toolsmith"} store result storage iota_trades:scratch init.draw int 1 run random value 0..7
function iota_trades:catalog/init_apply with storage iota_trades:scratch init
