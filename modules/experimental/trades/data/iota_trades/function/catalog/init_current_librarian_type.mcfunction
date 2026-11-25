$data modify storage iota_trades:scratch init.region set value "current_$(type)"
function iota_trades:catalog/init_apply with storage iota_trades:scratch init
