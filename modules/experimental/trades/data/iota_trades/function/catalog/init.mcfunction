execute store result storage iota_trades:scratch init.id int 1 run scoreboard players get @s it_identity
data modify storage iota_trades:scratch init.profession set string entity @s VillagerData.profession 10
data remove storage iota_trades:scratch init.job
data modify storage iota_trades:scratch init.job set from entity @s Brain.memories."minecraft:job_site".value
execute unless data storage iota_trades:scratch init.job.pos run return 0
execute if entity @s[tag=iota_trades_production_test] run return run function iota_trades:production/start
execute if entity @s[tag=iota_trades_current_probe] run return run function iota_trades:catalog/init_current
data modify storage iota_trades:scratch init.region set value "none"
function iota_trades:catalog/classify with storage iota_trades:scratch init.job
execute store result storage iota_trades:scratch init.draw int 1 run random value 0..3
function iota_trades:catalog/init_apply with storage iota_trades:scratch init
