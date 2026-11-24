data modify storage iota_tool_mastery:progress common set value []
data modify storage iota_tool_mastery:progress rare set value []
scoreboard players set #common iota_mastery 0
scoreboard players set #rare iota_mastery 0
data modify storage iota_tool_mastery:progress rare_odds set value 50
function iota_exp_tool_mastery:reward/candidate/quick_charge {enchant:"quick_charge",min:2,max:3,weight:4,pool:"common"}
function iota_exp_tool_mastery:reward/candidate/unbreaking {enchant:"unbreaking",min:2,max:3,weight:4,pool:"common"}
function iota_exp_tool_mastery:reward/candidate/piercing {enchant:"piercing",min:2,max:4,weight:4,pool:"common"}
function iota_exp_tool_mastery:reward/candidate/multishot {enchant:"multishot",min:1,max:1,weight:1,pool:"common"}
function iota_exp_tool_mastery:reward/candidate/mending {enchant:"mending",min:1,max:1,weight:4,pool:"rare"}
function iota_exp_tool_mastery:reward/draw with storage iota_tool_mastery:progress
execute unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/mark with storage iota_tool_mastery:progress
