execute at @s run particle minecraft:dust{color:[0.22,0.68,1.0],scale:0.65} ~ ~1.35 ~ 0.55 0.45 0.55 0 12 normal @s
execute if data storage iota_tool_mastery:progress notification_level{rank:3} at @s run function iota_exp_tool_mastery:feedback/particles_enchant
execute if data storage iota_tool_mastery:progress notification_level{rank:4} at @s run function iota_exp_tool_mastery:feedback/particles_enchant
execute if data storage iota_tool_mastery:progress notification_level{rank:5} at @s run function iota_exp_tool_mastery:feedback/particles_enchant
