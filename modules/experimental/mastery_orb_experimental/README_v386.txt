POC Anvil v3.8.6 | Minecraft Java 1.21.11

Based on the tested v3.8.4 interaction/display implementation (not the failed physical-head v3.8.5 experiment).

- Left-click the installed orb to recover it instantly (Survival/Adventure); Creative removes without a drop.
- Right-click still runs the XP transfer.
- Breaking or dropping the supporting anvil drops the orb.
- Existing v3.8.4 stations get a one-time hitbox adjustment: base lowered 0.0175 blocks to -0.0625 relative to head block origin; hitbox height 0.55, width 0.70.
- New stations use the same base and hitbox size.
- Decorative orb head drops: item entities with the exact orb texture have the custom name and lore restored on the next loaded tick. This does not affect unrelated head textures, but it does rename heads using the identical texture.

KNOWN LIMITATIONS:
- Decorative orb drops are restored after spawning as an item entity; direct inventory insertion or other special collection methods may bypass this restoration.
- Station detection inherited from v3.8.4 can treat ordinary player heads placed above anvils as orbs; fixing exact placement identification is still pending.
- If a v3.8.5 physical-head station remains in a test world, remove it before switching packs; this version is built on v3.8.4 and does not migrate experimental physical stations.
- Not yet tested in-game. Test on a copy of the world, especially breaking the anvil, decorative drops, and repeated placement/recovery.

Install: replace the previous POC ZIP in world/datapacks, then /reload. Keep only one version active.
