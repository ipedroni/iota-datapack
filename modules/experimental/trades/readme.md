# Iota Trades identity prototype

Experimental and excluded from the base build. Install only in disposable test worlds. See the [five-level design](../../../docs/discovery/drafts/trading_design_directions.md) and [native evidence summary](../../../docs/release_checklist.md#automated-research-evidence--2026-11-20).

This slice assigns a persistent identity when a loaded villager has a profession, gives zero-XP professionals one bootstrap XP to lock their career through vanilla rules, names unnamed villagers at Apprentice and snapshots native offer state. Identity tags support rehydrating the scoreboard after curing changes the entity UUID. Existing custom names and native offers are preserved.

No Iota catalogs, discounts, stock timers, village membership or Secret offers are installed. The bootstrap point must be subtracted from custom commercial progression. This prototype does not prevent command edits or implement arbitrary mod compatibility. Item naming is en-US. No dependency is required.

## Bounded exact-event experiment

IDs 1 through 64 have dedicated hidden interaction/trade advancements. They identify the actual native target without nearest-villager guessing. This is a bounded research channel, not an approved 64-villager product limit. Higher IDs keep identity behavior but have no exact-event recording in this prototype. Do not ship this capacity boundary or claim an unlimited full Trades runtime.

Exact trade events now record positive native-XP deltas separately by player UUID and resident ID. Two-player native GUI tests credit 3 XP to each actor; a zero-delta replay adds no XP. Interaction establishes the native baseline, so the bootstrap point is excluded. External XP edits during an open trade, unsupported event IDs and final commercial progression still require a production policy.
