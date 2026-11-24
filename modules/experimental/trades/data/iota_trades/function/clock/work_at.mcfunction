$execute unless dimension $(dimension) run return 0
$execute positioned $(x) $(y) $(z) unless entity @s[distance=..3] run return 0
$execute positioned $(x) $(y) $(z) unless block ~ ~ ~ #iota_trades:job_sites run return 0
$function iota_trades:clock/refill {id:$(id)}
