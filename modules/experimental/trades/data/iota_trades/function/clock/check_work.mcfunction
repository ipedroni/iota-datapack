data remove storage iota_trades:scratch work.job
data modify storage iota_trades:scratch work.job set from entity @s Brain.memories."minecraft:job_site".value
execute unless data storage iota_trades:scratch work.job.pos run return 0
$data modify storage iota_trades:scratch work.id set value $(id)
data modify storage iota_trades:scratch work.dimension set from storage iota_trades:scratch work.job.dimension
data modify storage iota_trades:scratch work.x set from storage iota_trades:scratch work.job.pos[0]
data modify storage iota_trades:scratch work.y set from storage iota_trades:scratch work.job.pos[1]
data modify storage iota_trades:scratch work.z set from storage iota_trades:scratch work.job.pos[2]
function iota_trades:clock/work_at with storage iota_trades:scratch work
