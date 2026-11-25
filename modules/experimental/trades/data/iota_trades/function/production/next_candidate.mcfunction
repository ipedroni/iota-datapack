execute unless data storage iota_trades:scratch production.remaining[0] run return 0
data remove storage iota_trades:scratch production.denied
data modify storage iota_trades:scratch production.deny set from storage iota_trades:scratch production.remaining[0].denied
function iota_trades:production/next_denial
execute unless data storage iota_trades:scratch production.denied run function iota_trades:production/include with storage iota_trades:scratch production.remaining[0]
data remove storage iota_trades:scratch production.remaining[0]
function iota_trades:production/next_candidate
