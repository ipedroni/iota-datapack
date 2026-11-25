$execute unless data storage iota_trades:residents r$(id).order run return 0
$data modify storage iota_trades:scratch refill.order set from storage iota_trades:residents r$(id).order
$data modify storage iota_trades:scratch refill.id set value $(id)
function iota_trades:clock/refill_next
$data modify storage iota_trades:residents r$(id).clock.ordinary set value 0
$data modify storage iota_trades:residents r$(id).clock.sleep_used set value 0
$data modify storage iota_trades:residents r$(id).dirty set value 1b
