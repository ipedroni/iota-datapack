advancement revoke @s only iota_exp_tool_mastery:broken_equipment/capture/chainmail_chestplate
data modify storage iota_broken:scratch find set value {item:"minecraft:chainmail_chestplate",default_max:240}
data modify storage iota_broken:scratch find.owner set from entity @s UUID
function iota_exp_tool_mastery:broken_equipment/capture/find with storage iota_broken:scratch find
