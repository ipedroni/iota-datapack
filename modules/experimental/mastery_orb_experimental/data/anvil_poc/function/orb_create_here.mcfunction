# v3.8.3: display unchanged; hitbox starts 0.125 block above station block origin.
execute unless block ~ ~-1 ~ #anvil_poc:anvils run return fail
# Do not convert a head when a different station is already here.
execute if entity @e[type=minecraft:interaction,tag=ap_orb_v38,distance=..0.4] run return 0
kill @e[type=minecraft:interaction,tag=ap_orb,tag=!ap_orb_v38,distance=..0.5]
summon minecraft:interaction ~ ~-0.0625 ~ {Tags:["ap_orb","ap_orb_v38","ap_orb_v382","ap_orb_v383","ap_orb_v384","ap_orb_v386"],width:0.55f,height:0.55f,response:1b}
summon minecraft:item_display ~ ~ ~ {Tags:["ap_orb_display_v38"],item:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":{properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjFhMTExZWMxMTAyYzQwYzAyZDFkNDBmNDdlNjA5Mzg1MTIzOTNlOWRkYWZlZmQ1MDI4ZDJkM2EyMmJmNTE4ZSJ9fX0="}]},"minecraft:item_name":{text:"Orbe de Maestria (POC)",color:"aqua",italic:false},"minecraft:lore":[{text:"Coloque sobre uma Anvil",color:"gray",italic:false}]}},item_display:"head",transformation:{translation:[0.0f,0.42f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.0f,1.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
# Remove the physical head, so its block raycast no longer steals the click.
setblock ~ ~ ~ minecraft:air replace
