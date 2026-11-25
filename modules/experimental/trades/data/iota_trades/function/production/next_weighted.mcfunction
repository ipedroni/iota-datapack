execute unless data storage iota_trades:scratch production.remaining[0] run return 0
function iota_trades:production/consider with storage iota_trades:scratch production.remaining[0]
data remove storage iota_trades:scratch production.remaining[0]
function iota_trades:production/next_weighted
