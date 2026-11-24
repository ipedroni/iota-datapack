$execute store result entity @e[type=villager,tag=iota_trades_id.$(id),limit=1] Offers.Recipes[$(index)].uses int 1 run data get storage iota_trades:residents r$(id).rolled.o$(slot).native.uses
