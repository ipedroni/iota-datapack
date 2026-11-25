$execute if data storage iota_trades:scratch maps.used[{destination:"$(destination)"}] run return 0
$execute summon minecraft:armor_stand run function iota_trades:catalog/maps/capture {table:"$(table)"}
