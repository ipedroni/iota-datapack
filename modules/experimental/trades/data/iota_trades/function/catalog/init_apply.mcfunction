$execute unless data storage iota_trades:templates $(profession)_$(region).p$(draw) run return 0
$data modify storage iota_trades:residents r$(id).rolled set from storage iota_trades:templates $(profession)_$(region).p$(draw).rolled
$data modify storage iota_trades:residents r$(id).order set from storage iota_trades:templates $(profession)_$(region).p$(draw).order
$execute if data storage iota_trades:templates $(profession)_$(region).p$(draw).sale_group run data modify storage iota_trades:residents r$(id).sale_group set from storage iota_trades:templates $(profession)_$(region).p$(draw).sale_group
$execute if data storage iota_trades:templates $(profession)_$(region).p$(draw).map_slots run function iota_trades:catalog/maps/init {id:$(id),template:"$(profession)_$(region).p$(draw)"}
$data modify storage iota_trades:residents r$(id).region set value "$(region)"
$data modify storage iota_trades:residents r$(id).anchor set from storage iota_trades:scratch init.job
$data modify storage iota_trades:residents r$(id).original_offers set from entity @s Offers
execute store result score #start_xp it_identity_tmp run data get entity @s Xp
$execute store result score #bootstrap it_identity_tmp run data get storage iota_trades:residents r$(id).bootstrap
scoreboard players operation #start_xp it_identity_tmp -= #bootstrap it_identity_tmp
execute if score #start_xp it_identity_tmp matches ..-1 run scoreboard players set #start_xp it_identity_tmp 0
$execute store result storage iota_trades:residents r$(id).commercial_xp int 1 run scoreboard players get #start_xp it_identity_tmp
$data modify storage iota_trades:residents r$(id).clock set value {ordinary:0,secret:0,regional:0,sleep_used:0}
$data modify storage iota_trades:residents r$(id).catalog set value 1b
$data modify storage iota_trades:residents r$(id).dirty set value 1b
$data modify storage iota_trades:residents r$(id).published set value 0b
$data modify storage iota_trades:residents r$(id).secret_unlocked set value 0b
tag @s add iota_trades_catalog
