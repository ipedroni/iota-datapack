# Rebuild the retained total once, with keep_inventory preventing vanilla XP drops.
function iota_hearts:xp/set_retained with storage iota_hearts:xp work.record
data modify storage iota_hearts:xp work.record.fallback set value {}
data modify storage iota_hearts:xp work.record.fallback.pos set from entity @s Pos
# Preserve exact fractional spawn coordinates through direct NBT copying.
data modify storage iota_hearts:xp work.record.fallback.x set from entity @s Pos[0]
data modify storage iota_hearts:xp work.record.fallback.y set from entity @s Pos[1]
data modify storage iota_hearts:xp work.record.fallback.z set from entity @s Pos[2]
execute if dimension minecraft:overworld run data modify storage iota_hearts:xp work.record.fallback.dim set value "minecraft:overworld"
execute if dimension minecraft:the_nether run data modify storage iota_hearts:xp work.record.fallback.dim set value "minecraft:the_nether"
execute if dimension minecraft:the_end run data modify storage iota_hearts:xp work.record.fallback.dim set value "minecraft:the_end"
data modify storage iota_hearts:xp work.record.location set from storage iota_hearts:xp work.record.fallback
execute if data storage iota_hearts:xp work.record{grounded:1b} if data storage iota_hearts:xp work.record.death run function iota_hearts:xp/use_death_location
execute if data storage iota_hearts:xp work.record{amount:0} run data modify storage iota_hearts:xp work.record.active set value 0b
execute unless data storage iota_hearts:xp work.record{amount:0} run data modify storage iota_hearts:xp work.record.active set value 1b
function iota_hearts:xp/save_record with storage iota_hearts:xp work
scoreboard players set @s iota_x_wait 0
