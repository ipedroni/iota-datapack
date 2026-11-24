$execute store result score #clock it_identity_tmp run data get storage iota_trades:residents r$(id).clock.ordinary
execute if score #clock it_identity_tmp matches ..71999 run scoreboard players add #clock it_identity_tmp 1
$execute store result storage iota_trades:residents r$(id).clock.ordinary int 1 run scoreboard players get #clock it_identity_tmp
$execute store result score #sleep it_identity_tmp run data get storage iota_trades:residents r$(id).clock.sleep_used
scoreboard players set #credit it_identity_tmp 36000
scoreboard players operation #credit it_identity_tmp *= #sleep it_identity_tmp
scoreboard players operation #credit it_identity_tmp += #clock it_identity_tmp
$execute if score @s it_far matches 60.. if score #clock it_identity_tmp matches 36000.. if score #credit it_identity_tmp matches 72000.. run function iota_trades:clock/check_work {id:$(id)}
