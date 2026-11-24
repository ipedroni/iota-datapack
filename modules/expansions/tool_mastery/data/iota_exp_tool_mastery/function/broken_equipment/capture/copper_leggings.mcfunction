advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/copper_leggings
data modify storage iota_broken:scratch find set value {item:"minecraft:copper_leggings",default_max:165}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
