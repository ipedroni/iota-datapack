execute unless data storage iota_trades:scratch production.deny[0] run return 0
function iota_trades:production/check_denial with storage iota_trades:scratch production.deny[0]
data remove storage iota_trades:scratch production.deny[0]
execute unless data storage iota_trades:scratch production.denied run function iota_trades:production/next_denial
