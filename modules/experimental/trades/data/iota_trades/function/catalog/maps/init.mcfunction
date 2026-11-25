$data modify storage iota_trades:residents r$(id).map_work set value {id:$(id),used:[],slots:[]}
$data modify storage iota_trades:residents r$(id).map_work.slots set from storage iota_trades:templates $(template).map_slots
$data modify storage iota_trades:residents r$(id).map_work.dimension set from storage iota_trades:scratch init.job.dimension
$execute store result storage iota_trades:residents r$(id).map_work.x int 1 run data get entity @s Pos[0]
$execute store result storage iota_trades:residents r$(id).map_work.y int 1 run data get entity @s Pos[1]
$execute store result storage iota_trades:residents r$(id).map_work.z int 1 run data get entity @s Pos[2]
tag @s add iota_trades_map_work
