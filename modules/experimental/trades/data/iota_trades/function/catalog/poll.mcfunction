$execute unless data storage iota_trades:residents r$(id){published:1b} run return 0
execute unless data entity @s Offers.Recipes run return 0
$execute store success score #poll_changed it_identity_tmp run data modify storage iota_trades:residents r$(id).observed_offers set from entity @s Offers.Recipes
execute unless score #poll_changed it_identity_tmp matches 1 run return 0
$data modify storage iota_trades:scratch poll set value {id:$(id),index:0,slots:[]}
$data modify storage iota_trades:scratch poll.slots set from storage iota_trades:residents r$(id).active_slots
scoreboard players set #poll_index it_identity_tmp 0
function iota_trades:catalog/poll_next
