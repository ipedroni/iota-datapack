data modify storage iota_tool_mastery:progress attributes set from storage iota_tool_mastery:progress default_attributes
execute if data storage iota_tool_mastery:progress stack.components."minecraft:attribute_modifiers" run data modify storage iota_tool_mastery:progress attributes set from storage iota_tool_mastery:progress stack.components."minecraft:attribute_modifiers"
execute unless score #xp iota_mastery matches 400.. unless data storage iota_tool_mastery:progress attributes[{id:"iota_exp_tool_mastery:mining_speed"}] run return 0
data remove storage iota_tool_mastery:progress attributes[{id:"iota_exp_tool_mastery:mining_speed"}]
execute unless score #xp iota_mastery matches 400.. run return run function iota_exp_tool_mastery:progress/apply_mining_speed with storage iota_tool_mastery:progress
data modify storage iota_tool_mastery:progress attributes append value {id:"iota_exp_tool_mastery:mining_speed",type:"minecraft:block_break_speed",amount:0.0d,operation:"add_multiplied_total",slot:"mainhand"}
execute store result storage iota_tool_mastery:progress attributes[-1].amount double 0.00005 run scoreboard players get #xp iota_mastery
function iota_exp_tool_mastery:progress/apply_mining_speed with storage iota_tool_mastery:progress
