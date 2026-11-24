# Drop one matching orb item at the station position; then delete the station.
execute at @s run summon minecraft:item ~ ~0.2 ~ {Tags:["ap_orb_drop"],Item:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":{properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjFhMTExZWMxMTAyYzQwYzAyZDFkNDBmNDdlNjA5Mzg1MTIzOTNlOWRkYWZlZmQ1MDI4ZDJkM2EyMmJmNTE4ZSJ9fX0="}]},"minecraft:item_name":{text:"Orbe de Maestria (POC)",color:"aqua",italic:false},"minecraft:lore":[{text:"Coloque sobre uma Anvil",color:"gray",italic:false}]}}}
execute at @s run kill @e[type=minecraft:item_display,tag=ap_orb_display_v38,distance=..0.7,limit=1,sort=nearest]
kill @s
