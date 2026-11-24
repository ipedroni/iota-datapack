data modify storage iota_trades:scratch prefix set string storage iota_trades:scratch tags[0] 0 15
execute if data storage iota_trades:scratch {prefix:"iota_trades_id."} run function iota_trades:identity/recover_id
data remove storage iota_trades:scratch tags[0]
execute unless score @s it_identity matches 1.. if data storage iota_trades:scratch tags[0] run function iota_trades:identity/recover
