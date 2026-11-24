scoreboard objectives add iota_world dummy
execute in minecraft:overworld run gamerule minecraft:advance_time false
execute unless data storage iota_world:migrations {mob_griefing_initialized:1b} store success storage iota_world:migrations mob_griefing_initialized byte 1 in minecraft:overworld run gamerule minecraft:mob_griefing false
