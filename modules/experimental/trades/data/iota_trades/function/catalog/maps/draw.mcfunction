# The only map slot with a non-map alternative is Journeyman's Spyglass.
$execute if data storage iota_trades:residents r$(id).rolled.o$(slot){item:"minecraft:spyglass"} store result score #map_branch it_identity_tmp run random value 1..100
$execute if data storage iota_trades:residents r$(id).rolled.o$(slot){item:"minecraft:spyglass"} if score #map_branch it_identity_tmp matches 1..25 run return 0
execute store result score #map_limit it_identity_tmp run data get storage iota_trades:scratch maps.found
scoreboard players remove #map_limit it_identity_tmp 1
execute store result storage iota_trades:scratch maps.limit int 1 run scoreboard players get #map_limit it_identity_tmp
function iota_trades:catalog/maps/index with storage iota_trades:scratch maps
function iota_trades:catalog/maps/commit with storage iota_trades:scratch maps
