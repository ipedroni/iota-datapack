advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/copper_helmet
data modify storage iota_broken:scratch find set value {item:"minecraft:copper_helmet",default_max:121}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
