data remove storage iota_broken:scratch current
$execute store success score #live im_broken run data modify storage iota_broken:scratch current set from entity @s $(source)
scoreboard players set #different im_broken 1
execute if score #live im_broken matches 1 store success score #different im_broken run data modify storage iota_broken:scratch current set from storage iota_broken:scratch item
scoreboard players set #ready im_broken 0
function iota_exp_tool_mastery:broken_equipment/mark with storage iota_broken:scratch capture
$execute if score #ready im_broken matches 1 run clear @s minecraft:structure_void[minecraft:custom_data~{iota_break_capture:{item:"$(item)",owner:$(owner)}}] 1
$execute if score #ready im_broken matches 1 run kill @e[type=item,nbt={Item:{id:"minecraft:structure_void",components:{"minecraft:custom_data":{iota_break_capture:{item:"$(item)",owner:$(owner)}}}}},limit=1]
