scoreboard players set #current it_identity_tmp 0
scoreboard players set #old it_identity_tmp 0
execute store result score #current it_identity_tmp run data get storage iota_trades:scratch trade.native.uses
$execute store result score #old it_identity_tmp run data get storage iota_trades:residents r$(id).rolled.o$(slot).native.uses
scoreboard players operation #delta it_identity_tmp = #current it_identity_tmp
scoreboard players operation #delta it_identity_tmp -= #old it_identity_tmp
execute unless score #delta it_identity_tmp matches 1.. run return 0
$execute store result score #reward it_identity_tmp run data get storage iota_trades:residents r$(id).rolled.o$(slot).xp
scoreboard players operation #reward it_identity_tmp *= #delta it_identity_tmp
$data modify storage iota_trades:residents r$(id).rolled.o$(slot).native set from storage iota_trades:scratch trade.native
$data modify storage iota_trades:residents r$(id).rolled.o$(slot).native.specialPrice set value 0
$execute store result score #total it_identity_tmp run data get storage iota_trades:residents r$(id).commercial_xp
scoreboard players operation #total it_identity_tmp += #reward it_identity_tmp
$execute store result storage iota_trades:residents r$(id).commercial_xp int 1 run scoreboard players get #total it_identity_tmp
$execute unless data storage iota_trades:residents r$(id).players[{uuid:$(uuid)}] run data modify storage iota_trades:residents r$(id).players append value {uuid:$(uuid),xp:0}
$execute store result score #personal it_identity_tmp run data get storage iota_trades:residents r$(id).players[{uuid:$(uuid)}].xp
scoreboard players operation #personal it_identity_tmp += #reward it_identity_tmp
$execute store result storage iota_trades:residents r$(id).players[{uuid:$(uuid)}].xp int 1 run scoreboard players get #personal it_identity_tmp
$data modify storage iota_trades:residents r$(id).dirty set value 1b
