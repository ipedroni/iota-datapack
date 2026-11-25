data modify storage iota_trades:scratch init.type set string entity @s VillagerData.type 10
execute store result storage iota_trades:scratch init.draw int 1 run random value 0..3
function iota_trades:catalog/init_current_librarian_type with storage iota_trades:scratch init
