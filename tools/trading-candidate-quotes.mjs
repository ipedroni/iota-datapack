import fs from 'node:fs';

const read = file => fs.readFileSync(new URL('../' + file, import.meta.url), 'utf8');
const design = read('docs/discovery/drafts/trading_design_directions.md').replaceAll('\r\n', '\n');
const id = name => 'minecraft:' + name.toLowerCase().replaceAll(' ', '_');
const colors = 'white orange magenta light_blue yellow lime pink gray light_gray cyan purple blue brown green red black'.split(' ');
const names = new Map(Object.entries({
  'Nether Quartz': ['quartz'], 'Redstone Dust': ['redstone'], 'Slimeball': ['slime_ball'],
  'Beeswax (Honeycomb)': ['honeycomb'], 'Empty Map': ['map'],
  'Wool, any eligible color': colors.map(color => color + '_wool'),
  'Dye, any eligible color except Black': colors.filter(color => color !== 'black').map(color => color + '_dye'),
  'Froglight, any eligible color': ['ochre_froglight', 'verdant_froglight', 'pearlescent_froglight'],
  'Happy Ghast Harness, any eligible color': colors.map(color => color + '_harness'),
  'Raw Chicken, Porkchop, Beef or Mutton': ['chicken', 'porkchop', 'beef', 'mutton'],
  'Cooked Chicken, Cooked Mutton, Cooked Rabbit, Steak or Cooked Porkchop': ['cooked_chicken', 'cooked_mutton', 'cooked_rabbit', 'cooked_beef', 'cooked_porkchop'],
  'Polished Andesite, Diorite, Granite, Deepslate or Tuff': ['andesite', 'diorite', 'granite', 'deepslate', 'tuff'].map(stone => 'polished_' + stone),
  'Glass family, Terracotta family, Glazed Terracotta or Concrete': [
    'glass', 'terracotta', ...colors.flatMap(color => ['stained_glass', 'terracotta', 'glazed_terracotta', 'concrete'].map(type => color + '_' + type)),
  ],
}));
export const sales = [];
export const purchases = [];
function quote(item, saleLot, payment, purchaseLot, payout) {
  if (+saleLot) {
    const [emeralds, blocks = 0] = String(payment).match(/\d+/g).map(Number);
    sales.push({ item, lot: +saleLot, emeralds, blocks });
  }
  if (+purchaseLot) purchases.push({ item, lot: +purchaseLot, payout: +payout });
}
for (const [heading, fields] of [
  ['Shared candidate quotes for overlapping offers', 5],
  ['Candidate farm, textile and supply quotes', 5],
  ['Candidate equipment and navigation quotes', 3],
  ['Candidate food, ammunition and container quotes', 5],
  ['Candidate Mason specialty quotes', 3],
]) {
  const section = design.split('### ' + heading + '\n')[1];
  if (!section) throw new Error('Missing quote table: ' + heading);
  for (const line of section.split(/\r?\n### /)[0].split(/\r?\n/).filter(line => line.startsWith('| '))) {
    const [name, a, b, c, d] = line.split('|').slice(1, -1).map(cell => cell.trim());
    if (!/\d|—/.test(a) || [name, a, b, c, d].filter(cell => cell !== undefined).length !== fields) continue;
    // These are component-sensitive, so keep them out of the item-only graph.
    if (name === 'Tipped Arrow' || name === 'Decorated Pot') continue;
    for (const item of names.get(name)?.map(id) ?? name.split(' or ').map(id)) {
      if (heading === 'Candidate equipment and navigation quotes') quote(item, 1, a, Number(b) > 0 ? 1 : 0, b);
      else quote(item, a, b, c, d);
    }
  }
}
// Profession-specific quotes use prose and compound cells in the design.
for (const terms of [
  ['iron_ingot', 8, '5 emeralds + 4 blocks', 32, 62],
  ['gold_ingot', 8, '9 emeralds + 7 blocks', 16, 61],
  ['gold_ingot', 0, 0, 64, 243], ['diamond', 1, 34, 1, 15],
  ['netherite_scrap', 1, '5 emeralds + 7 blocks'],
  ['clay_ball', 28, 5, 64, 3], ['clay', 4, 5],
  ['cod', 4, 3], ['salmon', 4, 3], ['cooked_cod', 0, 0, 1, 1], ['cooked_salmon', 0, 0, 1, 1],
  ['ender_pearl', 1, 5, 4, 5], ['blaze_powder', 1, 3, 8, 7], ['ender_eye', 0, 0, 1, 9],
  ['nether_wart', 8, 4], ['lily_pad', 8, 4], ['experience_bottle', 1, 5],
  ['amethyst_shard', 0, 0, 32, 4], ['lapis_lazuli', 0, 0, 32, 4], ['chorus_fruit', 0, 0, 16, 7],
  ['golden_apple', 1, '8 emeralds + 7 blocks'], ['golden_carrot', 1, 7], ['sniffer_egg', 1, '5 emeralds + 7 blocks'],
  ...['brown', 'blue', 'green'].map(color => [color + '_dye', 10, 9]),
  ['black_dye', 10, 23],
]) quote(id(terms[0]), ...terms.slice(1));
