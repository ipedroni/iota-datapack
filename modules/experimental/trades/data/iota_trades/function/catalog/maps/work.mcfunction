$execute unless data storage iota_trades:residents r$(id).map_work run return run tag @s remove iota_trades_map_work
$data modify storage iota_trades:scratch maps set from storage iota_trades:residents r$(id).map_work
execute unless data storage iota_trades:scratch maps.choices run function iota_trades:catalog/maps/next_slot
execute if data storage iota_trades:scratch maps.choices[0] run function iota_trades:catalog/maps/work_at with storage iota_trades:scratch maps
execute unless data storage iota_trades:scratch maps.choices[0] run function iota_trades:catalog/maps/finish_slot
$execute if data storage iota_trades:scratch maps.slots[0] run return run data modify storage iota_trades:residents r$(id).map_work set from storage iota_trades:scratch maps
$data remove storage iota_trades:residents r$(id).map_work
tag @s remove iota_trades_map_work
