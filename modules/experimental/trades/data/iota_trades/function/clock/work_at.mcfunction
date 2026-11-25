$execute unless dimension $(dimension) run return 0
$execute positioned $(x) $(y) $(z) unless entity @s[distance=..3] run return 0
$execute positioned $(x) $(y) $(z) unless block ~ ~ ~ $(block) run return 0
$function iota_trades:clock/refill {id:$(id)}
