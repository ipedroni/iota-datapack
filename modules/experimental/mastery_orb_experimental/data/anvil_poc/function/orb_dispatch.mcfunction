# IMPORTANTE: on target deve acontecer ANTES de remover interaction.
execute on target run function anvil_poc:orb_click
# Limpa evento para nao disparar repetidamente.
data remove entity @s interaction
