advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/golden_boots
data modify storage iota_broken:scratch find set value {item:"minecraft:golden_boots",default_max:91}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
