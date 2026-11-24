$execute unless data storage iota_trades:residents r$(id).active_slots[$(index)] run return 0
$data modify storage iota_trades:scratch trade set value {id:$(id)}
$data modify storage iota_trades:scratch trade.slot set from storage iota_trades:residents r$(id).active_slots[$(index)]
$data modify storage iota_trades:scratch trade.native set from entity @e[type=villager,tag=iota_trades_id.$(id),limit=1] Offers.Recipes[$(index)]
data modify storage iota_trades:scratch trade.uuid set from entity @s UUID
function iota_trades:catalog/trade_slot with storage iota_trades:scratch trade
