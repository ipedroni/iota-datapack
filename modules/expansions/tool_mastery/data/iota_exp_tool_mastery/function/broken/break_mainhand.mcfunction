data modify storage iota_exp_tool_mastery:broken_feedback lore set value []
data modify storage iota_exp_tool_mastery:broken_feedback lore set from entity @s SelectedItem.components."minecraft:lore"
data remove storage iota_exp_tool_mastery:broken_feedback lore[{insertion:"iota:broken_status"}]
data modify storage iota_exp_tool_mastery:broken_feedback lore append value {text:"Broken",color:"red",italic:false,insertion:"iota:broken_status"}
item modify entity @s weapon.mainhand iota_exp_tool_mastery:mark_broken_poc
data modify storage iota_exp_tool_mastery:broken_feedback slot set value "weapon.mainhand"
function iota_exp_tool_mastery:broken/apply_lore with storage iota_exp_tool_mastery:broken_feedback
function iota_exp_tool_mastery:broken/effects
data remove storage iota_exp_tool_mastery:broken_feedback lore
data remove storage iota_exp_tool_mastery:broken_feedback slot
