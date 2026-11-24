scoreboard players set #xp_written iota_mastery 0
data remove storage iota_tool_mastery:progress first_lore
data modify storage iota_tool_mastery:progress first_lore set from storage iota_tool_mastery:progress stack.components."minecraft:lore"[0]
execute if score #xp iota_mastery matches 0..4 run function iota_exp_tool_mastery:progress/lore_hand_0 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 5..399 run function iota_exp_tool_mastery:progress/lore_hand_1 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 400..1599 run function iota_exp_tool_mastery:progress/lore_hand_2 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 1600..3999 run function iota_exp_tool_mastery:progress/lore_hand_3 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 4000..7999 run function iota_exp_tool_mastery:progress/lore_hand_4 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 8000.. run function iota_exp_tool_mastery:progress/lore_hand_5 with storage iota_tool_mastery:progress
execute unless score #xp_written iota_mastery matches 1 run return 0
execute unless score #milestones iota_mastery matches 1 run return 0
scoreboard players set #reward_failed iota_mastery 0
execute if score #xp iota_mastery matches 1600.. if score #processed iota_mastery matches ..2 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_3 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 4000.. if score #processed iota_mastery matches ..3 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_4 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 8000.. if score #processed iota_mastery matches ..4 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_5 with storage iota_tool_mastery:progress
execute if score #previous_xp iota_mastery matches ..4999 if score #xp iota_mastery matches 5.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Rookie","rank":1}
execute if score #previous_xp iota_mastery matches ..399999 if score #xp iota_mastery matches 400.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Apprentice","rank":2}
execute if score #previous_xp iota_mastery matches ..1599999 if score #xp iota_mastery matches 1600.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Adept","rank":3}
execute if score #previous_xp iota_mastery matches ..3999999 if score #xp iota_mastery matches 4000.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Expert","rank":4}
execute if score #previous_xp iota_mastery matches ..7999999 if score #xp iota_mastery matches 8000.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Masterwork","rank":5}
execute if data storage iota_tool_mastery:progress notification_level run return run function iota_exp_tool_mastery:feedback/level_up
