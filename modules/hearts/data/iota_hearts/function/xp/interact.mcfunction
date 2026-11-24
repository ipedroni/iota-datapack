execute if data entity @s interaction run execute on target run function iota_hearts:xp/claim with storage iota_hearts:xp work.record
data remove entity @s interaction
# Left clicks are deliberately accepted as an alternative to right clicks.
execute if data entity @s attack run execute on attacker run function iota_hearts:xp/claim with storage iota_hearts:xp work.record
data remove entity @s attack
scoreboard players add @s iota_x_math 1
execute if score @s iota_x_math matches 10.. run function iota_hearts:xp/aura
execute if score @s iota_x_math matches 10.. run scoreboard players set @s iota_x_math 0
