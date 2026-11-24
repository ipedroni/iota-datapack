execute store result score #native it_identity_tmp run data get storage iota_trades:events last.native_xp
$execute store result score #previous it_identity_tmp run data get storage iota_trades:residents r$(id).accounted_xp
scoreboard players operation #delta it_identity_tmp = #native it_identity_tmp
scoreboard players operation #delta it_identity_tmp -= #previous it_identity_tmp
$data modify storage iota_trades:residents r$(id).accounted_xp set from storage iota_trades:events last.native_xp
execute unless score #delta it_identity_tmp matches 1.. run return 0
$execute unless data storage iota_trades:residents r$(id).players run data modify storage iota_trades:residents r$(id).players set value []
$execute unless data storage iota_trades:residents r$(id).players[{uuid:$(uuid)}] run data modify storage iota_trades:residents r$(id).players append value {uuid:$(uuid),xp:0}
$execute store result score #credit it_identity_tmp run data get storage iota_trades:residents r$(id).players[{uuid:$(uuid)}].xp
scoreboard players operation #credit it_identity_tmp += #delta it_identity_tmp
$execute store result storage iota_trades:residents r$(id).players[{uuid:$(uuid)}].xp int 1 run scoreboard players get #credit it_identity_tmp
