function iota_hearts:xp/context
data remove storage iota_hearts:xp work.record
function iota_hearts:xp/read_record with storage iota_hearts:xp work
execute if score @s iota_x_wait matches 1 run function iota_hearts:xp/respawn
scoreboard players operation #owner iota_x_id = @s iota_x_id
scoreboard players operation #generation iota_x_gen = @s iota_x_gen
execute if data storage iota_hearts:xp work.record{active:1b} run function iota_hearts:xp/ensure_location with storage iota_hearts:xp work.record.location
scoreboard players set @s iota_x_ground 0
execute if entity @s[nbt={OnGround:1b}] run scoreboard players set @s iota_x_ground 1
