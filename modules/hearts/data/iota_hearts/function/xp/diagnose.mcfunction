function iota_hearts:xp/total
tellraw @s [{"text":"[Hearts XP] Pontos atuais: ","color":"yellow"},{"score":{"name":"#total","objective":"iota_x_math"}}]
function iota_hearts:xp/context
data remove storage iota_hearts:xp work.record
function iota_hearts:xp/read_record with storage iota_hearts:xp work
data get storage iota_hearts:xp work.record
