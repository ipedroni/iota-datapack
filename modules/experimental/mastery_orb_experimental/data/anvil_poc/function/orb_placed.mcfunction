# Triggered after placing a standing player head; scan nearby for a head above an anvil.
advancement revoke @s only anvil_poc:orb_placed
execute at @s run function anvil_poc:orb_scan
