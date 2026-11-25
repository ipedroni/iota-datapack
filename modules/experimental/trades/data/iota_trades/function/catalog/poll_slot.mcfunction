$execute unless data entity @s Offers.Recipes[$(index)] run return 0
scoreboard players set #poll_live it_identity_tmp 0
scoreboard players set #poll_previous it_identity_tmp 0
$execute if data entity @s Offers.Recipes[$(index)].uses store result score #poll_live it_identity_tmp run data get entity @s Offers.Recipes[$(index)].uses
$execute if data storage iota_trades:residents r$(id).rolled.o$(slot).native.uses store result score #poll_previous it_identity_tmp run data get storage iota_trades:residents r$(id).rolled.o$(slot).native.uses
execute if score #poll_live it_identity_tmp = #poll_previous it_identity_tmp run return 0
$execute if score #poll_live it_identity_tmp < #poll_previous it_identity_tmp run return run execute store result entity @s Offers.Recipes[$(index)].uses int 1 run scoreboard players get #poll_previous it_identity_tmp
$execute store result storage iota_trades:residents r$(id).rolled.o$(slot).native.uses int 1 run scoreboard players get #poll_live it_identity_tmp
scoreboard players operation #poll_live it_identity_tmp -= #poll_previous it_identity_tmp
$execute store result score #poll_xp it_identity_tmp run data get storage iota_trades:residents r$(id).rolled.o$(slot).xp
scoreboard players operation #poll_xp it_identity_tmp *= #poll_live it_identity_tmp
$execute store result score #poll_total it_identity_tmp run data get storage iota_trades:residents r$(id).commercial_xp
scoreboard players operation #poll_total it_identity_tmp += #poll_xp it_identity_tmp
$execute store result storage iota_trades:residents r$(id).commercial_xp int 1 run scoreboard players get #poll_total it_identity_tmp
$data modify storage iota_trades:residents r$(id).dirty set value 1b
