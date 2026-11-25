# Keep per-tick accounting near a player and for the first tick after departure.
execute if score @s it_far matches ..1 run return run function iota_trades:catalog/poll with storage iota_trades:scratch frame
# Stagger idle checks by resident identity so they do not all run on one tick.
scoreboard players operation #poll_resident_phase it_identity_tmp = @s it_identity
scoreboard players operation #poll_resident_phase it_identity_tmp %= #poll_period it_identity_tmp
execute if score #poll_resident_phase it_identity_tmp = #poll_phase it_identity_tmp run function iota_trades:catalog/poll with storage iota_trades:scratch frame
