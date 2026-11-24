advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/netherite_helmet
data modify storage iota_broken:scratch find set value {item:"minecraft:netherite_helmet",default_max:407}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
