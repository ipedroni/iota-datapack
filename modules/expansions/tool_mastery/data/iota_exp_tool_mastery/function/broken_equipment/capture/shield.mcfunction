advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/shield
data modify storage iota_broken:scratch find set value {item:"minecraft:shield",default_max:336}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
