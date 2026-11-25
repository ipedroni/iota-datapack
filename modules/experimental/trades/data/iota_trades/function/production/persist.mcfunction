$data modify storage iota_trades:templates $(profession)_production.p$(id) set value {}
$data modify storage iota_trades:templates $(profession)_production.p$(id).rolled set from storage iota_trades:scratch production.rolled
$data modify storage iota_trades:templates $(profession)_production.p$(id).order set from storage iota_trades:scratch production.sales
$data modify storage iota_trades:templates $(profession)_production.p$(id).order append from storage iota_trades:scratch production.buys[]
$execute if data storage iota_trades:scratch production.sale_group run data modify storage iota_trades:templates $(profession)_production.p$(id).sale_group set from storage iota_trades:scratch production.sale_group
$execute if data storage iota_trades:production $(profession)_maps run data modify storage iota_trades:templates $(profession)_production.p$(id).map_slots set from storage iota_trades:production $(profession)_maps
function iota_trades:catalog/init_apply with storage iota_trades:scratch init
$data remove storage iota_trades:templates $(profession)_production.p$(id)
