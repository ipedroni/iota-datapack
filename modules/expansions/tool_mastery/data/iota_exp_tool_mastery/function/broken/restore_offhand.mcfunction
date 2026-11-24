data modify storage iota_exp_tool_mastery:broken_feedback lore set value []
data modify storage iota_exp_tool_mastery:broken_feedback lore set from entity @s equipment.offhand.components."minecraft:lore"
data remove storage iota_exp_tool_mastery:broken_feedback lore[{insertion:"iota:broken_status"}]
item modify entity @s weapon.offhand iota_exp_tool_mastery:restore_broken_poc
data modify storage iota_exp_tool_mastery:broken_feedback slot set value "weapon.offhand"
function iota_exp_tool_mastery:broken/apply_lore with storage iota_exp_tool_mastery:broken_feedback
data remove storage iota_exp_tool_mastery:broken_feedback lore
data remove storage iota_exp_tool_mastery:broken_feedback slot
