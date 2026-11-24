data modify storage iota_trades:scratch coords.dimension set from storage iota_trades:scratch init.job.dimension
data modify storage iota_trades:scratch coords.x set from storage iota_trades:scratch init.job.pos[0]
data modify storage iota_trades:scratch coords.y set from storage iota_trades:scratch init.job.pos[1]
data modify storage iota_trades:scratch coords.z set from storage iota_trades:scratch init.job.pos[2]
function iota_trades:catalog/classify_at with storage iota_trades:scratch coords
