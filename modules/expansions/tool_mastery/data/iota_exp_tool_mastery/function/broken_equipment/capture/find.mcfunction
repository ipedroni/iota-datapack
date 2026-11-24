data remove storage iota_broken:scratch capture
$data modify storage iota_broken:scratch capture set from entity @s Inventory[{id:"minecraft:structure_void",components:{"minecraft:custom_data":{iota_break_capture:{item:"$(item)",owner:$(owner)}}}}].components."minecraft:custom_data".iota_break_capture
$execute unless data storage iota_broken:scratch capture.original.id run data modify storage iota_broken:scratch capture set from entity @e[type=item,nbt={Item:{id:"minecraft:structure_void",components:{"minecraft:custom_data":{iota_break_capture:{item:"$(item)",owner:$(owner)}}}}},limit=1] Item.components."minecraft:custom_data".iota_break_capture
execute unless data storage iota_broken:scratch capture.original.id run return 0
$execute unless data storage iota_broken:scratch capture.original{id:"$(item)"} run return 0
data modify storage iota_broken:scratch capture.default_max set from storage iota_broken:scratch find.default_max
data modify storage iota_broken:scratch item set from storage iota_broken:scratch capture.original
function iota_exp_tool_mastery:broken_equipment/capture/process with storage iota_broken:scratch capture
