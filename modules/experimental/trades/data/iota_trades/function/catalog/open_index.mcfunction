$execute unless data storage iota_trades:residents r$(id).active_slots[$(index)] run return 0
$data modify storage iota_trades:scratch open set value {id:$(id),index:$(index)}
$data modify storage iota_trades:scratch open.slot set from storage iota_trades:residents r$(id).active_slots[$(index)]
function iota_trades:catalog/open_slot with storage iota_trades:scratch open
