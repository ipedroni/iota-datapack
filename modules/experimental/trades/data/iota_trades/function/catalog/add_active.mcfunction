$execute store result score #offer_level it_identity_tmp run data get storage iota_trades:residents r$(id).rolled.o$(slot).level
$execute if score #offer_level it_identity_tmp matches 6 if data storage iota_trades:residents r$(id){secret_unlocked:1b} run scoreboard players set #offer_level it_identity_tmp 5
execute if score #offer_level it_identity_tmp > #level it_identity_tmp run return 0
$data modify storage iota_trades:scratch publish.recipes append from storage iota_trades:residents r$(id).rolled.o$(slot).native
$data modify storage iota_trades:residents r$(id).active_slots append value $(slot)
