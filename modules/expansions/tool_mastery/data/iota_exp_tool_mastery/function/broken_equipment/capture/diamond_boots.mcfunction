advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/diamond_boots
data modify storage iota_broken:scratch find set value {item:"minecraft:diamond_boots",default_max:429}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
