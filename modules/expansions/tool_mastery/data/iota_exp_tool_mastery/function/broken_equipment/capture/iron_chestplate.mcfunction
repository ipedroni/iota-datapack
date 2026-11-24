advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/iron_chestplate
data modify storage iota_broken:scratch find set value {item:"minecraft:iron_chestplate",default_max:240}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
