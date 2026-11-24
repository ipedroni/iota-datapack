scoreboard players set #skip iota_world 24000
scoreboard players operation #skip iota_world -= #time iota_world
execute store result storage iota_world:clock skip int 1 run scoreboard players get #skip iota_world
function iota_world:skip with storage iota_world:clock
