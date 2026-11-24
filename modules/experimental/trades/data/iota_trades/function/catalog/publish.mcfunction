$data modify storage iota_trades:scratch publish.order set from storage iota_trades:residents r$(id).order
$data modify storage iota_trades:scratch publish.id set value $(id)
$execute if data storage iota_trades:residents r$(id) run data modify storage iota_trades:scratch publish.recipes set value []
$execute if data storage iota_trades:residents r$(id) run data modify storage iota_trades:residents r$(id).active_slots set value []
$execute store result score #xp it_identity_tmp run data get storage iota_trades:residents r$(id).commercial_xp
$execute if data storage iota_trades:residents r$(id) run scoreboard players set #level it_identity_tmp 1
$execute if data storage iota_trades:residents r$(id) if score #xp it_identity_tmp matches 10.. run scoreboard players set #level it_identity_tmp 2
$execute if data storage iota_trades:residents r$(id) if score #xp it_identity_tmp matches 70.. run scoreboard players set #level it_identity_tmp 3
$execute if data storage iota_trades:residents r$(id) if score #xp it_identity_tmp matches 150.. run scoreboard players set #level it_identity_tmp 4
$execute if data storage iota_trades:residents r$(id) if score #xp it_identity_tmp matches 250.. run scoreboard players set #level it_identity_tmp 5
$execute if data storage iota_trades:residents r$(id) run execute store result storage iota_trades:scratch publish.level int 1 run scoreboard players get #level it_identity_tmp
$execute if data storage iota_trades:residents r$(id) run function iota_trades:catalog/build_active
$execute if data storage iota_trades:residents r$(id) run data modify entity @s Offers.Recipes set from storage iota_trades:scratch publish.recipes
$execute if data storage iota_trades:residents r$(id) run execute store result entity @s VillagerData.level int 1 run scoreboard players get #level it_identity_tmp
$execute if data storage iota_trades:residents r$(id) if score #xp it_identity_tmp matches ..0 run scoreboard players set #xp it_identity_tmp 1
$execute if data storage iota_trades:residents r$(id) run execute store result entity @s Xp int 1 run scoreboard players get #xp it_identity_tmp
$data modify storage iota_trades:residents r$(id).dirty set value 0b
$data modify storage iota_trades:residents r$(id).published set value 1b
