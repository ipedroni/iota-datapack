# Attack event is stored on the interaction entity.
# Resolve attacker, retaining station coordinates as command execution position.
execute on attacker run function anvil_poc:orb_attack
data remove entity @s attack
