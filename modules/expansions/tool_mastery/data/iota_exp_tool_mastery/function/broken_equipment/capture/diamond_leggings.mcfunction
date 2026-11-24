advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/diamond_leggings
data modify storage iota_broken:scratch find set value {item:"minecraft:diamond_leggings",default_max:495}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
