$execute store result score #clock it_identity_tmp run data get storage iota_trades:residents r$(id).clock.ordinary
$execute if score #clock it_identity_tmp matches 18000.. if data storage iota_trades:residents r$(id).clock{sleep_used:0} run data modify storage iota_trades:residents r$(id).clock.sleep_used set value 1
