# POC experimental: uma transacao por vez; somente ferramentas marcadas.
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run tellraw @s {"text":"Principal invalida; nada alterado.","color":"red"}
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:orb_negative
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run return fail
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run tellraw @s {"text":"Secundaria invalida; nada alterado.","color":"red"}
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:orb_negative
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run return fail
# O NBT do jogador nao expõe a offhand de forma confiavel: copiar para armor stand temporario.
execute if entity @e[type=minecraft:armor_stand,tag=ap_v25_temp] run tellraw @s {"text":"Ja existe transacao temporaria. Cancelado.","color":"red"}
execute if entity @e[type=minecraft:armor_stand,tag=ap_v25_temp] run function anvil_poc:orb_negative
execute if entity @e[type=minecraft:armor_stand,tag=ap_v25_temp] run return fail
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["ap_v25_temp"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
execute at @s run item replace entity @e[type=minecraft:armor_stand,tag=ap_v25_temp,sort=nearest,limit=1,distance=..1] weapon.mainhand from entity @s weapon.offhand
scoreboard players set @s ap_readok 0
scoreboard players set @s ap_secondary -1
execute at @s store success score @s ap_readok run data get entity @e[type=minecraft:armor_stand,tag=ap_v25_temp,sort=nearest,limit=1,distance=..1] equipment.mainhand.components."minecraft:custom_data".anvil_poc.xp 1
execute at @s store result score @s ap_secondary run data get entity @e[type=minecraft:armor_stand,tag=ap_v25_temp,sort=nearest,limit=1,distance=..1] equipment.mainhand.components."minecraft:custom_data".anvil_poc.xp 1
scoreboard players set @s ap_primary -1
execute store result score @s ap_primary run data get entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp 1
execute unless score @s ap_readok matches 1 run tellraw @s {"text":"Falha ao ler XP. Nenhum item consumido.","color":"red"}
execute unless score @s ap_readok matches 1 run function anvil_poc:cleanup
execute unless score @s ap_readok matches 1 run function anvil_poc:orb_negative
execute unless score @s ap_readok matches 1 run return fail
execute unless score @s ap_primary matches 0..8000 run tellraw @s {"text":"XP principal fora de 0..8000. Cancelado.","color":"red"}
execute unless score @s ap_primary matches 0..8000 run function anvil_poc:cleanup
execute unless score @s ap_primary matches 0..8000 run function anvil_poc:orb_negative
execute unless score @s ap_primary matches 0..8000 run return fail
execute unless score @s ap_secondary matches 0..8000 run tellraw @s {"text":"XP secundaria fora de 0..8000. Cancelado.","color":"red"}
execute unless score @s ap_secondary matches 0..8000 run function anvil_poc:cleanup
execute unless score @s ap_secondary matches 0..8000 run function anvil_poc:orb_negative
execute unless score @s ap_secondary matches 0..8000 run return fail
scoreboard players operation @s ap_transfer = @s ap_secondary
scoreboard players set #four ap_result 4
scoreboard players operation @s ap_transfer /= #four ap_result
# Nao consumir ferramentas quando a transferencia arredondaria para zero.
execute unless score @s ap_transfer matches 1.. run tellraw @s {"text":"Transferencia arredondaria para 0 XP. Secundaria preservada.","color":"yellow"}
execute unless score @s ap_transfer matches 1.. run function anvil_poc:cleanup
execute unless score @s ap_transfer matches 1.. run function anvil_poc:orb_negative
execute unless score @s ap_transfer matches 1.. run return fail
# Nao consumir secundaria quando a principal ja atingiu o teto.
execute if score @s ap_primary matches 8000 run tellraw @s {"text":"Principal ja esta em 8000 XP. Secundaria preservada.","color":"yellow"}
execute if score @s ap_primary matches 8000 run function anvil_poc:cleanup
execute if score @s ap_primary matches 8000 run function anvil_poc:orb_negative
execute if score @s ap_primary matches 8000 run return fail
scoreboard players operation @s ap_result = @s ap_primary
scoreboard players operation @s ap_result += @s ap_transfer
execute if score @s ap_result matches 8001.. run scoreboard players set @s ap_result 8000
execute unless score @s ap_result > @s ap_primary run tellraw @s {"text":"Sem ganho de XP. Operacao cancelada, itens preservados.","color":"yellow"}
execute unless score @s ap_result > @s ap_primary run function anvil_poc:cleanup
execute unless score @s ap_result > @s ap_primary run function anvil_poc:orb_negative
execute unless score @s ap_result > @s ap_primary run return fail
execute store result storage anvil_poc:runtime xp int 1 run scoreboard players get @s ap_result
# Verificacao de presenca dos dois itens imediatamente antes da gravacao.
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:cleanup
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:orb_negative
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run return fail
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:cleanup
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run function anvil_poc:orb_negative
execute unless items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_data~{anvil_poc:{test:1b}}] run return fail
item modify entity @s weapon.mainhand anvil_poc:set_xp
execute store result score @s ap_verify run data get entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp 1
execute unless score @s ap_verify = @s ap_result run tellraw @s {"text":"ERRO: XP gravada difere da esperada. Secundaria PRESERVADA. Nao repetir antes de inspecionar.","color":"red"}
execute unless score @s ap_verify = @s ap_result run function anvil_poc:cleanup
execute unless score @s ap_verify = @s ap_result run function anvil_poc:orb_negative
execute unless score @s ap_verify = @s ap_result run return fail
# IMPORTANTE: ainda nao ha rollback transacional. Este teste nao protege contra
# desconexao/falha entre gravacao e consumo; nao usar itens valiosos.
item replace entity @s weapon.offhand with minecraft:air
function anvil_poc:cleanup
tellraw @s [{"text":"[v2.8] Transferencia concluida. XP principal: ","color":"green"},{"score":{"name":"@s","objective":"ap_primary"}},{"text":" | secundaria: "},{"score":{"name":"@s","objective":"ap_secondary"}},{"text":" | herdada: "},{"score":{"name":"@s","objective":"ap_transfer"}},{"text":" | final: "},{"score":{"name":"@s","objective":"ap_result"}}]

# v3.7: feedback apenas depois da transferencia confirmada e consumo da secundaria.
execute at @s as @e[type=minecraft:interaction,tag=ap_orb,sort=nearest,limit=1,distance=..5] at @s run particle minecraft:enchant ~ ~0.15 ~ 0.25 0.18 0.25 0.12 25 force
execute at @s as @e[type=minecraft:interaction,tag=ap_orb,sort=nearest,limit=1,distance=..5] at @s run particle minecraft:end_rod ~ ~0.20 ~ 0.18 0.12 0.18 0.035 9 force
execute at @s run playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.7 1.25
execute at @s run playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.6 1.55
