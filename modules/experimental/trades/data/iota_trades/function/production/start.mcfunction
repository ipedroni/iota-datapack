data modify storage iota_trades:scratch production set value {steps:[],picked:{},rolled:{},sales:[],buys:[],books:[]}
data modify storage iota_trades:scratch init.pool set from storage iota_trades:scratch init.profession
execute if data entity @s VillagerData{profession:"minecraft:mason"} run function iota_trades:production/mason
execute if data entity @s VillagerData{profession:"minecraft:librarian"} run function iota_trades:production/librarian
function iota_trades:production/read_pool with storage iota_trades:scratch init
execute unless data storage iota_trades:scratch production.steps[0] run return 0
function iota_trades:production/next_step
execute if data storage iota_trades:scratch production.failed run return 0
data modify storage iota_trades:scratch init.region set value "production"
data modify storage iota_trades:scratch init.draw set from storage iota_trades:scratch init.id
function iota_trades:production/persist with storage iota_trades:scratch init
