execute unless data storage iota_trades:scratch publish.order[0] run return 0
data modify storage iota_trades:scratch publish.slot set from storage iota_trades:scratch publish.order[0]
function iota_trades:catalog/add_active with storage iota_trades:scratch publish
data remove storage iota_trades:scratch publish.order[0]
function iota_trades:catalog/build_active
