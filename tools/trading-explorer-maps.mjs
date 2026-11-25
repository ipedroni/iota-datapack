import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const targets = {
  village: ['#minecraft:village', 'target_x', 2],
  shipwreck: ['#minecraft:shipwreck', 'target_x', 2],
  ruined_portal: ['#minecraft:ruined_portal', 'target_x', 2],
  buried_treasure: ['minecraft:buried_treasure', 'red_x', 1],
  ocean_monument: ['minecraft:monument', 'monument', 2],
  trial_chambers: ['minecraft:trial_chambers', 'trial_chambers', 2],
  woodland_mansion: ['minecraft:mansion', 'mansion', 2],
  ancient_city: ['minecraft:ancient_city', 'target_x', 2],
};

export const explorerMaps = Object.fromEntries(Object.entries(targets).map(([offer, [target, marker, zoom]]) => [
  offer, {
    target,
    structureTag: { values: [target] },
    table: {
      type: 'minecraft:chest',
      pools: [{
        rolls: 1,
        entries: [{
          type: 'minecraft:item',
          name: 'minecraft:map',
          functions: [{
            function: 'minecraft:exploration_map',
            destination: 'iota_trades:explorer/' + offer,
            decoration: 'minecraft:' + marker,
            zoom,
            skip_existing_chunks: false,
          }],
        }],
      }],
    },
  },
]));

export function writeExplorerMaps(directory) {
  for (const [name, { table, structureTag }] of Object.entries(explorerMaps)) {
    for (const [subfolder, data] of [['loot_table', table], ['tags/worldgen/structure', structureTag]]) {
      const target = path.join(directory, subfolder, 'explorer');
      fs.mkdirSync(target, { recursive: true });
      fs.writeFileSync(path.join(target, name + '.json'), JSON.stringify(data, null, 2) + '\n');
    }
  }
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const modulePath = new URL('../modules/experimental/trades/data/iota_trades/', import.meta.url);
  writeExplorerMaps(fileURLToPath(modulePath));
}
