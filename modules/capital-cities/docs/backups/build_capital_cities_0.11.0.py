import json
from math import pi, sin, sqrt
from itertools import groupby
from pathlib import Path
from random import Random
from zipfile import ZIP_DEFLATED, ZipFile

VERSION = '0.11.0'
MINECRAFT_VERSION = '1.21.11'
NAMESPACE = 'capital_cities'
DIMENSION = f'{NAMESPACE}:plains_inhabited'
OBJECTIVE = 'cc_inhabited'
SIZE = 800
TILE = 80
SURFACE = 80
SPAWN = '399.5 84 735.5'
files = {}


def function(name, commands):
    files[f'data/{NAMESPACE}/function/{name}.mcfunction'] = '\n'.join(commands) + '\n'


def metadata(path, value):
    files[path] = json.dumps(value, ensure_ascii=False, indent=2) + '\n'


def call(name):
    return f'function {NAMESPACE}:{name}'


def fill(x1, y1, z1, x2, y2, z2, material):
    assert (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1) <= 32768
    return f'fill {x1} {y1} {z1} {x2} {y2} {z2} minecraft:{material}'


metadata('pack.mcmeta', {'pack': {
    'description': f'Capital Cities {VERSION} - Minecraft Java {MINECRAFT_VERSION}',
    'min_format': [94, 1],
    'max_format': [94, 1],
}})
metadata(f'data/{NAMESPACE}/dimension/plains_inhabited.json', {
    'type': 'minecraft:overworld',
    'generator': {'type': 'minecraft:flat', 'settings': {
        'biome': 'minecraft:plains',
        'layers': [
            {'height': 1, 'block': 'minecraft:bedrock'},
            {'height': 141, 'block': 'minecraft:stone'},
            {'height': 2, 'block': 'minecraft:dirt'},
            {'height': 1, 'block': 'minecraft:grass_block'},
        ],
        'lakes': False,
        'features': False,
        'structure_overrides': [],
    }},
})
for event in ('load', 'tick'):
    metadata(f'data/minecraft/tags/function/{event}.json', {'values': [f'{NAMESPACE}:{event}']})

# Regions are applied back to front. Rectangles are clipped to the loaded tile.
regions = [
    (352, 256, 447, 319, 81, 84, 'stone_bricks'),
    (352, 256, 447, 319, 85, 85, 'polished_andesite'),
    (394, 320, 405, 799, 80, 80, 'stone_bricks'),
    (118, 480, 670, 482, 80, 80, 'gravel'),
    (394, 480, 405, 482, 80, 80, 'stone_bricks'),
    (168, 330, 630, 336, 80, 80, 'gravel'),
    (512, 128, 615, 191, 80, 80, 'coarse_dirt'),
]
for step in range(5):
    z = 324 - step
    regions.append((394, z, 405, z, 81, 81 + step, 'stone_bricks'))
    regions.append((394, z, 405, z, 81 + step, 81 + step, 'stone_brick_stairs[facing=north]'))

# The southern gate closes the gap between the two ends of this trace.
wall = [
    (405, 454), (534, 454), (534, 402), (607, 402), (607, 449),
    (661, 449), (661, 400), (704, 400), (704, 313), (663, 313),
    (663, 252), (717, 252), (717, 166), (682, 166), (682, 111),
    (637, 111), (637, 59), (573, 59), (573, 35), (455, 35),
    (455, 108), (359, 108), (359, 63), (290, 63), (290, 47),
    (192, 47), (192, 88), (136, 88), (136, 141), (92, 141),
    (92, 220), (148, 220), (148, 280), (98, 280), (98, 332),
    (73, 332), (73, 395), (143, 395), (143, 440), (204, 440),
    (204, 414), (270, 414), (270, 454), (394, 454),
]


def box(x1, z1, x2, z2, y1, y2, material):
    assert 0 <= x1 <= x2 < SIZE and 0 <= z1 <= z2 < SIZE and SURFACE <= y1 <= y2 <= 124
    regions.append((x1, z1, x2, z2, y1, y2, material))


def rounded_trace(points):
    """Round the old corners while preserving the gate and large offsets."""
    samples = [points[0]]
    for before, corner, after in zip(points, points[1:], points[2:]):
        incoming = abs(corner[0] - before[0]) + abs(corner[1] - before[1])
        outgoing = abs(after[0] - corner[0]) + abs(after[1] - corner[1])
        if not incoming or not outgoing:
            continue
        radius = min(incoming // 2, outgoing // 2, 30 + (sum(corner) % 16))
        if not radius:
            samples.append(corner)
            continue
        entry = tuple(c + (a - c) * radius / incoming for a, c in zip(before, corner))
        exit = tuple(c + (b - c) * radius / outgoing for b, c in zip(after, corner))
        for step in range(2 * radius + 1):
            t = step / (2 * radius)
            samples.append(tuple(round((1 - t)**2 * a + 2*t*(1 - t)*c + t*t*b)
                                 for a, c, b in zip(entry, corner, exit)))
    samples.append(points[-1])

    x, z = samples[0]
    trace = [(x, z)]
    for target_x, target_z in samples[1:]:
        while (x, z) != (target_x, target_z):
            if x != target_x:
                x += 1 if x < target_x else -1
                trace.append((x, z))
            if z != target_z:
                z += 1 if z < target_z else -1
                trace.append((x, z))
    return trace


def paint_cells(cells, low, high, material):
    """Merge consecutive cells on the same row before emitting fills."""
    for z, row in groupby(sorted(cells, key=lambda cell: (cell[1], cell[0])), key=lambda cell: cell[1]):
        for _, run in groupby(enumerate(row), key=lambda item: item[1][0] - item[0]):
            xs = [cell[0] for _, cell in run]
            box(xs[0], z, xs[-1], z, low, high, material)


STONE_GRADIENT = (
    ('deepslate_bricks', 'cobbled_deepslate', 'cracked_deepslate_bricks', 'chiseled_deepslate'),
    ('stone_bricks', 'mossy_stone_bricks', 'cracked_stone_bricks', 'andesite'),
    ('tuff_bricks', 'stone_bricks', 'polished_andesite', 'chiseled_tuff_bricks'),
)


def weather_stone(cells, edge, bottom, top):
    """Paint continuous strata, then vary only visible masonry."""
    height = top - bottom + 1
    for y in range(bottom, top + 1):
        band = min(2, 3*(y - bottom)//height)
        palette = STONE_GRADIENT[band]
        paint_cells(cells, y, y, palette[0])
        accents = {}
        for x, z in edge:
            patch = (x//5 * 47 + z//4 * 23 + y//2 * 31) % 19
            grain = (x * 73 ^ z * 97 ^ y * 43) % 37
            if grain < 3 and y < top - 1:
                face = next((facing for dx, dz, facing in
                             ((1, 0, 'west'), (-1, 0, 'east'), (0, 1, 'north'), (0, -1, 'south'))
                             if (x + dx, z + dz) not in cells), 'north')
                stone = ('deepslate_brick', 'stone_brick', 'tuff_brick')[band]
                detail = (f'{stone}_slab[type=top]' if grain == 0 else
                          f'{stone}_stairs[facing={face},half={"top" if grain == 1 else "bottom"}]')
            elif patch < 6 or grain < 10:
                detail = palette[1 + (patch + grain) % 3]
            else:
                continue
            accents.setdefault(detail, set()).add((x, z))
        for material, marks in accents.items():
            paint_cells(marks, y, y, material)




def tower(x, z, height, radius=6):
    box(x - radius, z - radius, x + radius, z + radius, 81, height, 'stone_bricks')
    box(x - radius, z - radius, x + radius, z + radius, height, height, 'smooth_stone')
    for offset in range(-radius, radius + 1, 3):
        for edge in (-radius, radius):
            box(x + offset, z + edge, x + offset, z + edge, height + 1, height + 2, 'stone_bricks')
            box(x + edge, z + offset, x + edge, z + offset, height + 1, height + 2, 'stone_bricks')


def defenses(style):
    start = len(regions)
    # Remap axes monotonically so the trace stays orthogonal before rounding.
    # Keep the south gate, its approaches and the developable city interior fixed.
    offsets = ((0, 0, 0), (-22, 24, 13), (21, -19, -15), (-13, -26, 21))
    west, east, north = offsets[style]
    outline = [
        (x + west if x <= 148 else x + east if x >= 597 else x,
         z + north if z <= 111 else z)
        for x, z in wall
    ]
    wall_trace = rounded_trace(outline)
    wall_cells = {(x + dx, z + dz) for x, z in wall_trace
                  for dx in range(-3, 4) for dz in range(-3, 4) if dx*dx + dz*dz <= 12}
    wall_edge = {(x, z) for x, z in wall_cells
                 if any((x + dx, z + dz) not in wall_cells
                        for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)))}
    weather_stone(wall_cells, wall_edge, 81, 91)
    paint_cells(wall_cells, 92, 92, 'smooth_stone')
    paint_cells({(x, z) for x, z in wall_edge if (x + 3*z) % 6 < 4}, 93, 94, 'stone_bricks')

    # The exterior pilasters are narrow shafts with stepped bases and caps.
    buttress_cells = set()
    for index in range(28, len(wall_trace) - 28, 24):
        x, z = wall_trace[index]
        before, after = wall_trace[index - 4], wall_trace[index + 4]
        dx, dz = after[0] - before[0], after[1] - before[1]
        ox, oz = ((0, 1 if dx > 0 else -1) if abs(dx) >= abs(dz)
                  else (-1 if dz > 0 else 1, 0))
        pedestal = {(x + ox*step - oz*side, z + oz*step + ox*side)
                    for step in (3, 4, 5) for side in (-1, 0, 1)}
        shaft = {(x + ox*step, z + oz*step) for step in (3, 4)}
        buttress_cells.update(pedestal | shaft)
        paint_cells(pedestal, 81, 81, 'polished_deepslate')
        paint_cells(pedestal, 82, 82, 'deepslate_brick_slab[type=bottom]')
        paint_cells(shaft, 82, 86, 'deepslate_bricks')
        paint_cells(shaft, 87, 89, 'stone_brick_wall')
        paint_cells(shaft, 90, 90, 'chiseled_tuff_bricks')
        paint_cells(shaft, 91, 91, 'polished_tuff_slab[type=top]')

    for x, z, radius, height in (
        (192, 47, 9, 112), (573, 35, 5, 98), (717, 252, 8, 108),
        (661, 449, 6, 101), (143, 440, 9, 107), (73, 332, 4, 98), (148, 220, 7, 104),
    ):
        x, z = min(wall_trace, key=lambda point: ((point[0] - x)**2 + (point[1] - z)**2, point))
        tower(x, z, height, radius)
        passage = {(cx, cz) for cx, cz in wall_cells - wall_edge
                   if abs(cx - x) <= radius and abs(cz - z) <= radius}
        paint_cells(passage, 93, 96, 'air')
    placements = regions[start:]
    del regions[start:]
    return placements, wall_cells | buttress_cells


defense_plans = [defenses(style) for style in range(4)]
tower(383, 454, 103)
tower(416, 454, 103)
box(389, 450, 410, 458, 89, 92, 'stone_bricks')
box(390, 450, 409, 458, 81, 88, 'air')
box(390, 450, 391, 458, 81, 86, 'stone_bricks')
box(408, 450, 409, 458, 81, 86, 'stone_bricks')
for x in (383, 416):
    box(x, 459, x, 460, 95, 97, 'air')
    box(x - 4, 448, x + 4, 457, 81, 85, 'air')
    box(x - 2, 447, x + 2, 448, 81, 83, 'air')
box(376, 452, 423, 456, 93, 95, 'air')

# A broad stair from inside the portico reaches the wall walk.
for step in range(12):
    z = 437 + step
    box(402, z, 404, z, 81, 81 + step, 'stone_bricks')
    box(402, z, 404, z, 81 + step, 81 + step, 'stone_brick_stairs[facing=south]')
box(402, 449, 404, 450, 92, 92, 'stone_bricks')


def house(x, z, base, wall_material, roof, door_z):
    box(x, z, x + 12, z + 10, base, base, 'cobblestone')
    box(x, z, x + 12, z + 10, base + 1, base + 5, wall_material)
    box(x + 1, z + 1, x + 11, z + 9, base + 1, base + 5, 'air')
    for corner_x in (x, x + 12):
        for corner_z in (z, z + 10):
            box(corner_x, corner_z, corner_x, corner_z, base + 1, base + 5, 'stripped_spruce_log')
    box(x + 6, door_z, x + 7, door_z, base + 1, base + 3, 'air')
    for window_x in (x + 3, x + 9):
        box(window_x, z, window_x, z, base + 3, base + 4, 'glass_pane')
        box(window_x, z + 10, window_x, z + 10, base + 3, base + 4, 'glass_pane')
    for rise in range(5):
        box(x - 1, z - 1 + rise, x + 13, z + 11 - rise, base + 6 + rise, base + 6 + rise, roof)


# Stagger the terraces, local paths and house setbacks on either side of the main road.
for west, east, north, south, height, houses in (
    (291, 381, 334, 365, 3, ((304, 337), (332, 340), (359, 335))),
    (307, 383, 381, 407, 1, ((316, 384), (341, 390), (364, 381))),
    (419, 494, 345, 372, 2, ((425, 349), (452, 346), (476, 353))),
    (425, 515, 384, 415, 1, ((433, 390), (464, 386), (493, 395))),
):
    box(west, north, east, south, 81, 80 + height, 'cobblestone')
    box(west, north, east, south, 80 + height, 80 + height, 'grass_block')
    west_side = east < 394
    edge = east if west_side else west
    road_z = south - 4
    box(west, road_z, east, road_z + 3, 80 + height, 80 + height, 'gravel')
    for step in range(height):
        x = edge + height - step if west_side else edge - height + step
        facing = 'west' if west_side else 'east'
        box(x, road_z, x, road_z + 3, 81, 81 + step, 'cobblestone')
        box(x, road_z, x, road_z + 3, 81 + step, 81 + step,
            f'cobblestone_stairs[facing={facing}]')
    left, right = (edge + height + 1, 393) if west_side else (406, edge - height - 1)
    box(left, road_z, right, road_z + 3, 80, 80, 'gravel')
    for index, (x, z) in enumerate(houses):
        house(x, z, 80 + height, 'white_terracotta' if index % 2 == 0 else 'bricks',
              'spruce_planks' if index != 1 else 'red_terracotta', z + 10)
        box(x + 6, z + 11, x + 7, road_z - 1, 80 + height, 80 + height, 'gravel')

# Offset stairs lead through enclosed courts before reaching the keep.
box(506, 132, 624, 223, 81, 85, 'stone')
box(506, 132, 624, 223, 85, 85, 'grass_block')
box(523, 144, 610, 191, 86, 91, 'stone_bricks')
box(523, 144, 610, 191, 91, 91, 'polished_andesite')
for x, south, base, height in ((560, 223, 80, 5), (580, 191, 85, 6)):
    for step in range(height):
        z = south + height - step
        box(x, z, x + 7, z, base + 1, base + 1 + step, 'stone_bricks')
        box(x, z, x + 7, z, base + 1 + step, base + 1 + step,
            'stone_brick_stairs[facing=north]')
box(560, 229, 567, 330, 80, 80, 'gravel')

# The lower curtain follows the terrace edge. Retaining walls close its northern side.
for left, top, right, bottom in (
    (506, 191, 509, 223), (621, 191, 624, 223), (506, 221, 624, 223),
    (506, 191, 522, 194), (611, 191, 624, 194),
    (510, 205, 574, 208), (571, 197, 574, 204),
):
    masonry = {(x, z) for x in range(left, right + 1) for z in range(top, bottom + 1)}
    edge = {(x, z) for x, z in masonry if x in (left, right) or z in (top, bottom)}
    weather_stone(masonry, edge, 86, 96)

for left, top, right, bottom in (
    (523, 144, 526, 191), (607, 144, 610, 191), (523, 144, 610, 147),
    (523, 188, 610, 191), (526, 168, 592, 171), (589, 172, 592, 180),
):
    masonry = {(x, z) for x in range(left, right + 1) for z in range(top, bottom + 1)}
    edge = {(x, z) for x, z in masonry if x in (left, right) or z in (top, bottom)}
    weather_stone(masonry, edge, 92, 104)


def arch(x, first_z, last_z, floor, span, rise, bend):
    # A vertical spring line supports an elliptical crown. The opening drifts
    # laterally through the thickness of the wall to turn the sightline.
    for z in range(first_z, last_z + 1):
        t = (z - first_z) / (last_z - first_z)
        center = x + round(bend * sin(pi * t))
        box(center - span, z, center + span, z, floor + 1, floor + 4, 'air')
        for level in range(1, rise + 1):
            half = max(1, round(span * sqrt(1 - (level / rise)**2)))
            y = floor + 4 + level
            box(center - half, z, center + half, z, y, y, 'air')


arch(563, 221, 223, 85, 7, 5, 2)
arch(539, 205, 208, 85, 6, 5, -3)
arch(583, 188, 191, 91, 7, 6, 2)
arch(550, 168, 171, 91, 8, 6, -3)
box(551, 211, 569, 218, 85, 85, 'coarse_dirt')
box(534, 196, 547, 204, 85, 85, 'polished_andesite')
box(568, 175, 587, 185, 91, 91, 'cobblestone')
house(559, 151, 91, 'stone_bricks', 'dark_oak_planks', 161)

for x in (353, 429):
    house(x + 1, 258, 85, 'calcite', 'dark_oak_planks', 268)

# Market stalls face the central approach.
for x in (373, 420):
    for z in (288, 303):
        box(x, z, x + 5, z + 1, 86, 86, 'oak_planks')
        for post in (x, x + 5):
            box(post, z + 1, post, z + 1, 87, 89, 'spruce_fence')
        for stripe in range(6):
            wool = 'white_wool' if stripe % 2 else 'red_wool'
            box(x + stripe, z, x + stripe, z + 3, 90, 90, wool)

def contour_field(start, first, width, length, elevation, phase, crop, rotated=False):
    """Build a ribbon of crops over slopes, with irrigation broken at grade changes."""
    def profile(row):
        t = row / length
        shift = round(12*sin(2*pi*t + phase) + 5*sin(5*pi*t + phase))
        rise = round(elevation + 1.5*sin(3*pi*t + phase) + 1.4*sin(7*pi*t))
        return start + shift, max(2, rise)

    def strip(left, right, first_row, last_row, low, high, material):
        if rotated:
            box(first_row, left, last_row, right, low, high, material)
        else:
            box(left, first_row, right, last_row, low, high, material)

    profiles = [profile(row) for row in range(length)]
    if not rotated and first >= 494:
        left, rise = profiles[0]
        if first - rise > 483:
            box(left, 483, left + 2, first - rise - 1, 80, 80, 'packed_mud')
        for step in range(rise):
            z = first - rise + step
            box(left, z, left + 2, z, 81, 81 + step, 'dirt')
            box(left, z, left + 2, z, 81 + step, 81 + step,
                'mud_brick_stairs[facing=south]')
    for (left, rise), offsets in groupby(range(length), key=profiles.__getitem__):
        rows = list(offsets)
        z1, z2 = first + rows[0], first + rows[-1]
        right = left + width - 1
        y = SURFACE + rise
        strip(left, right, z1, z2, 81, y - 1, 'dirt')
        strip(left, left, z1, z2, y, y, 'packed_mud')
        strip(right, right, z1, z2, y - 1, y, 'mossy_cobblestone')
        strip(left + 1, right - 1, z1, z2, y, y, 'farmland[moisture=7]')
        strip(left + 1, right - 1, z1, z2, y + 1, y + 1, f'{crop}[age=7]')
        for row in rows:
            if 0 < row < length - 1 and profiles[row - 1][1] == rise == profiles[row + 1][1]:
                for channel in range(left + 4, right - 1, 8):
                    z = first + row
                    strip(channel, channel, z, z, y + 1, y + 1, 'air')
                    strip(channel, channel, z, z, y, y, 'water')
    # Put steps into the uphill edge where the walking strip changes level.
    for row in range(1, length):
        (prev_x, prev_rise), (x, rise) = profiles[row - 1:row + 1]
        if rise == prev_rise:
            continue
        high_row = row if rise > prev_rise else row - 1
        high_x = x if rise > prev_rise else prev_x
        facing = ('east' if rise > prev_rise else 'west') if rotated else (
            'south' if rise > prev_rise else 'north')
        y = SURFACE + max(rise, prev_rise)
        strip(high_x, high_x, first + high_row, first + high_row, y, y,
              f'mud_brick_stairs[facing={facing}]')


# Raise the agricultural approach gently; the gate and its crossroad stay level.
for z in range(486, 800):
    rise = min(3, 1 + (z - 486)//6)
    box(394, z, 405, z, 81, 80 + rise, 'cobblestone')
    material = ('stone_brick_stairs[facing=south]'
                if z in (486, 492, 498) else 'stone_bricks')
    box(394, z, 405, z, 80 + rise, 80 + rise, material)


def farm_plan(style):
    start_index = len(regions)
    rng = Random(190 + style)
    phase = rng.uniform(-0.45, 0.9)
    for index, start in enumerate((125, 177, 230, 281, 464, 515, 567, 622)):
        contour_field(start + rng.randint(-4, 4), 494 + index % 3 * 3 + rng.randint(0, 6),
                          rng.randint(29, 36), rng.randint(232, 285),
                      4 + index % 3, phase if index < 4 else phase + 2.1,
                      'wheat' if index % 2 == 0 else 'carrots')

    # Smaller outer ribbons fit the gaps between the ramparts and the map edge.
    for start, first, width, length, elevation, phase, crop, rotated in (
        (18, 145, 17, 218, 4, 1.1, 'wheat', False),
        (41, 152, 15, 170, 6, 1.1, 'carrots', False),
        (762, 151, 17, 164, 5, 1.9, 'wheat', False),
        (17, 85, 13, 215, 5, 0.7, 'carrots', True),
        (16, 310, 12, 239, 3, 2.2, 'wheat', True),
    ):
        contour_field(start, first + rng.randint(0, 9), width, length - rng.randint(0, 24),
                          elevation, phase + style * 0.24, crop, rotated)


    placements = regions[start_index:]
    del regions[start_index:]
    return placements


farm_plans = [farm_plan(style) for style in range(4)]


VARIANT_COUNT = 16


def city_plan(seed):
    rng = Random(seed)
    plan = []

    def place(left, top, right, bottom, low, high, block):
        assert 0 <= left <= right < SIZE and 0 <= top <= bottom < SIZE
        assert 80 <= low <= high <= 124
        plan.append((left, top, right, bottom, low, high, block))

    coastal_defenses = defense_plans[seed % 4][1]
    phase = rng.uniform(-0.95, 0.95)
    river_width = rng.randrange(17, 25, 2)

    def river(z):
        t = (z - 20) / 435
        return round(635 + 112*t + 34*sin(2*pi*t + phase) + 11*sin(5*pi*t))

    half = river_width // 2
    for z in range(20, 456):
        center = river(z)
        left, right = center - half, center + half
        place(left - 2, z, right + 2, z, 80, 80, 'gravel')
        place(left, z, right, z, 80, 80, 'water')
        # Cut only below the wall walk; keep the deck over the water.
        for offset in range(-half, half + 1):
            x = center + offset
            if (x, z) in coastal_defenses:
                vault = 84 + round(5 * sqrt(1 - (offset / half)**2))
                place(x, z, x, z, 81, vault, 'air')
                place(x, z, x, z, vault + 1, min(vault + 2, 91), 'chiseled_stone_bricks')

    bridge_z = rng.randrange(278, 312)
    bridge_centers = [river(z) for z in range(bridge_z, bridge_z + 9)]
    west, east = min(bridge_centers) - half - 6, max(bridge_centers) + half + 6
    place(448, bridge_z, west, bridge_z + 8, 80, 80, 'gravel')
    place(west, bridge_z, east, bridge_z + 8, 81, 81, 'stone_bricks')
    for x in (west - 1, east + 1):
        place(x, bridge_z, x, bridge_z + 8, 81, 81, 'stone_brick_slab')
    for z in (bridge_z, bridge_z + 8):
        place(west, z, east, z, 82, 82, 'stone_brick_wall')
    # The market's eastern steps meet the bridge road.
    for step in range(5):
        x = 452 - step
        place(x, bridge_z + 1, x, bridge_z + 7, 81, 81 + step, 'stone_bricks')
        place(x, bridge_z + 1, x, bridge_z + 7, 81 + step, 81 + step,
              'stone_brick_stairs[facing=west]')

    aqueduct_z = rng.randrange(112, 123)
    place(564, aqueduct_z, 762, aqueduct_z + 4, 96, 97, 'stone_bricks')
    place(566, aqueduct_z + 1, 760, aqueduct_z + 3, 97, 97, 'water')
    for x in range(566, 762, 14):
        place(x, aqueduct_z, x + 2, aqueduct_z + 4, 81, 95, 'stone_bricks')
        place(x + 3, aqueduct_z, x + 4, aqueduct_z + 4, 94, 95, 'stone_bricks')
        place(x + 5, aqueduct_z, x + 6, aqueduct_z + 4, 95, 95, 'stone_bricks')
        if x > 566:
            place(x - 2, aqueduct_z, x - 1, aqueduct_z + 4, 94, 95, 'stone_bricks')
            place(x - 4, aqueduct_z, x - 3, aqueduct_z + 4, 95, 95, 'stone_bricks')
    # Raised source and receiving basin mark both ends of the aqueduct.
    for left, right in ((548, 565), (761, 778)):
        place(left, aqueduct_z - 5, right, aqueduct_z + 9, 81, 97, 'stone_bricks')
        place(left + 1, aqueduct_z - 4, right - 1, aqueduct_z + 8, 97, 97, 'water')
    place(565, aqueduct_z + 1, 565, aqueduct_z + 3, 97, 97, 'water')
    place(761, aqueduct_z + 1, 761, aqueduct_z + 3, 97, 97, 'water')

    place(488, 257, 495, bridge_z + 8, 80, 80, 'gravel')
    place(527, bridge_z - 9, 565, bridge_z + 15, 80, 80, 'polished_andesite')
    waterways, plan = plan, []
    residents = []
    rng = Random(701 + seed)

    def building(x, z, width, depth, base, height, wall, roof, balcony=False,
                 face='south', roof_style=0, occupied=False):
        right, back = x + width - 1, z + depth - 1
        place(x, z, right, back, base, base, 'cobblestone')
        place(x, z, right, back, base + 1, base + height, wall)
        place(x + 1, z + 1, right - 1, back - 1, base + 1, base + height, 'air')
        center = (x + right) // 2
        midpoint = (z + back) // 2
        entrances = {
            'south': (center, back, center + 1, back),
            'north': (center, z, center + 1, z),
            'west': (x, midpoint, x, midpoint + 1),
            'east': (right, midpoint, right, midpoint + 1),
        }
        place(*entrances[face], base + 1, base + 3, 'air')
        for xx in (x, right):
            place(xx, z, xx, back, base + 1, base + height, 'stripped_spruce_log')
        for y in range(base + 3, base + height, 4):
            for xx in (x + 2, right - 2):
                for edge in (z, back):
                    place(xx, edge, xx, edge, y, y + 1, 'glass_pane')
        for rise in range((4, 3, 2)[roof_style]):
            y = base + height + 1 + rise
            if roof_style == 1:
                place(x - 1 + rise, z - 1, right + 1 - rise, back + 1, y, y, roof)
            else:
                place(x - 1, z - 1 + rise, right + 1, back + 1 - rise, y, y, roof)
        if roof_style == 2:
            place(x + 1, z + 1, x + 1, z + 1, base + height + 1, base + height + 4,
                  'stone_bricks')
        if occupied:
            place(x + 2, z + 2, x + 2, z + 2, base + 1, base + 1, 'white_bed[facing=east,part=foot]')
            place(x + 3, z + 2, x + 3, z + 2, base + 1, base + 1, 'white_bed[facing=east,part=head]')
            job = rng.choice(('barrel', 'blast_furnace', 'stonecutter', 'loom', 'lectern',
                              'smithing_table', 'cartography_table', 'fletching_table'))
            place(right - 2, z + 2, right - 2, z + 2, base + 1, base + 1, job)
            place(right - 2, z + 3, right - 2, z + 3, base + 1, base + 1, 'lantern')
            residents.append((center, base + 1, midpoint))
        if balcony:
            place(x, back + 1, right, back + 2, base + 5, base + 5, 'spruce_planks')
            place(x, back + 2, right, back + 2, base + 6, base + 6, 'spruce_fence')
            place(center, back, center + 1, back, base + 6, base + 7, 'air')
            if height > 8:
                place(x + 1, z + 1, right - 1, back - 1, base + 5, base + 5, 'spruce_planks')
                for step in range(5):
                    place(x + 1, z + 2 + step, x + 1, z + 2 + step, base + 1 + step,
                          base + 1 + step, 'spruce_stairs[facing=south]')

    # A circular tower with a tapering roof and a hollow ground floor.
    wizard_x = rng.choice((469, 483, 499))
    wizard_z = rng.randrange(155, 190)
    radius = rng.randrange(8, 11)
    eaves = rng.randrange(101, 106)
    for dz in range(-radius, radius + 1):
        half_width = int(sqrt(radius**2 - dz**2))
        z = wizard_z + dz
        place(wizard_x - half_width, z, wizard_x + half_width, z, 81, eaves, 'calcite')
    for dz in range(-radius + 2, radius - 1):
        half_width = int(sqrt((radius - 2)**2 - dz**2))
        z = wizard_z + dz
        place(wizard_x - half_width, z, wizard_x + half_width, z, 81, 89, 'air')
    place(wizard_x - 1, wizard_z + radius - 2, wizard_x + 1, wizard_z + radius,
          81, 84, 'air')
    for level in range(18):
        roof_radius = (radius + 1) * (17 - level) / 17
        for dz in range(-int(roof_radius), int(roof_radius) + 1):
            half_width = int(sqrt(roof_radius**2 - dz**2))
            z = wizard_z + dz
            place(wizard_x - half_width, z, wizard_x + half_width, z,
                  eaves + level + 1, eaves + level + 1, 'dark_oak_planks')

    # West-side streets bend independently and meet a north–south collector.
    levels = [rng.randint(0, 6) for _ in range(8)]
    for row, rise in enumerate(levels):
        for x in range(167, 342):
            undulation = round(2 * sin((x - 165)/25 + row*0.8 + seed))
            height = max(0, min(8, rise + undulation))
            north = 125 + 23*row
            south = north + 22
            if height:
                place(x, north, x, south, 81, 80 + height, 'dirt')
                place(x, north, x, south, 80 + height, 80 + height, 'grass_block')
    for row, rise in enumerate(levels):
        center_z = 148 + 23*row + rng.randint(-4, 4)
        base = 80 + rise
        width = rng.choice((3, 3, 5, 7, 11))
        amplitude = rng.choice((3, 5, 7))
        road_phase = rng.uniform(-0.9, 0.9)

        def road_z(x):
            return center_z + round(amplitude * sin((x - 172) / 19 + road_phase)
                                    + 2*sin((x - 172) / 8 + road_phase))

        pavement = 'andesite' if width >= 8 else 'gravel'
        for x in range(172, 336):
            z = road_z(x)
            level = (rise if x < 320 else max(0, rise - (x - 320)//3))
            if level:
                place(x, z - width//2, x, z + width//2, 81, 80 + level, 'dirt')
            place(x, z - width//2, x, z + width//2, 81 + level, 89, 'air')
            material = ('cobblestone_stairs[facing=west]'
                        if level and x >= 322 and (x - 322) % 3 == 0 else pavement)
            place(x, z - width//2, x, z + width//2, 80 + level, 80 + level, material)
        z = road_z(335)
        for x in range(336, 342):
            level = max(0, rise - 5 - (x - 336))
            place(x, z - width//2, x, z + width//2, 81 + level, 89, 'air')
            place(x, z - width//2, x, z + width//2, 80, 80, pavement)
            if level:
                place(x, z - width//2, x, z + width//2, 81, 80 + level, 'cobblestone')
                place(x, z - width//2, x, z + width//2, 80 + level, 80 + level,
                      'cobblestone_stairs[facing=west]')
        lot_slots = sorted(rng.sample(range(8), rng.choice((7, 8))))
        for lot in lot_slots:
            x = 173 + lot*18 + rng.randrange(0, 3)
            kind = rng.randrange(6)
            building_width, depth, height = (
                (8, 9, 14), (14, 10, 6), (7, 8, 5),
                (10, 7, 9), (12, 8, 7), (9, 10, 11),
            )[kind]
            front = min(road_z(xx) for xx in range(x, x + building_width)) - width//2 - 3
            back = front - rng.randrange(0, 2)
            top = back - depth + 1
            house_base = max(80, base + rng.choice((-1, 0, 0, 1, 2)))
            face = rng.choice(('south', 'south', 'north', 'east', 'west'))
            material = rng.choice(('stone_bricks', 'stone_bricks', 'stone', 'andesite',
                                   'cobbled_deepslate', 'deepslate_bricks'))
            place(x - 1, top - 1, x + building_width, back + 1, 81, 90, 'air')
            if house_base > 80:
                place(x - 1, top - 1, x + building_width, back + 1, 81, house_base, 'stone')
            building(x, top, building_width, depth, house_base, height, material,
                     rng.choice(('spruce_planks', 'spruce_planks', 'deepslate_tiles')),
                     balcony=kind in (0, 5), face=face, roof_style=rng.randrange(3), occupied=True)

            center = x + (building_width - 1)//2
            mid_z = (top + back)//2
            lanes = {
                'south': (center, back + 1),
                'east': (x + building_width, mid_z),
                'west': (x - 1, mid_z),
                'north': (x - 1, top - 1),
            }
            lane, entry = lanes[face]
            if face == 'north':
                place(lane, entry, center + 1, entry, house_base, house_base, 'gravel')
            for path_z in range(entry, road_z(lane) - width//2):
                distance = road_z(lane) - width//2 - path_z
                path_y = base + max(-distance, min(distance, house_base - base))
                place(lane, path_z, lane, path_z, 81 if path_y > 80 else 80, path_y, 'stone')
                place(lane, path_z, lane, path_z, path_y + 1, 89, 'air')
                place(lane, path_z, lane, path_z, path_y, path_y, 'gravel')

    place(342, 134, 346, 335, 80, 80, 'gravel')
    place(337, 279, 346, 286, 80, 80, 'polished_andesite')
    for step in range(5):
        x = 347 + step
        place(x, 279, x, 286, 81, 81 + step, 'stone_bricks')
        place(x, 279, x, 286, 81 + step, 81 + step, 'stone_brick_stairs[facing=east]')
    building(476, 239, 27, 18, 80, 12, 'stone_bricks', 'spruce_planks', occupied=True)
    building(509 + 3*seed, 248, 22, 14, 80, 9, 'stone', 'spruce_planks', occupied=True)
    building(475, 265, 12, 8, 80, 6, 'stone_bricks', 'spruce_planks', occupied=True)
    building(492, 265, 10, 8, 80, 7, 'deepslate_bricks', 'spruce_planks', occupied=True)
    return waterways, plan, residents


shared_residents = []


def inhabit_home(x, z, floor, job):
    box(x + 2, z + 2, x + 2, z + 2, floor + 1, floor + 1, 'white_bed[facing=east,part=foot]')
    box(x + 3, z + 2, x + 3, z + 2, floor + 1, floor + 1, 'white_bed[facing=east,part=head]')
    box(x + 8, z + 2, x + 8, z + 2, floor + 1, floor + 1, job)
    box(x + 8, z + 3, x + 8, z + 3, floor + 1, floor + 1, 'lantern')
    shared_residents.append((x + 5, floor + 1, z + 5))


for x, z, floor, job in (
    (354, 258, 85, 'barrel'), (430, 258, 85, 'lectern'), (559, 151, 91, 'blast_furnace'),
    (304, 337, 83, 'stonecutter'), (332, 340, 83, 'loom'), (359, 335, 83, 'smithing_table'),
    (316, 384, 81, 'barrel'), (341, 390, 81, 'cartography_table'), (364, 381, 81, 'fletching_table'),
    (425, 349, 82, 'lectern'), (452, 346, 82, 'barrel'), (476, 353, 82, 'stonecutter'),
    (433, 390, 81, 'loom'), (464, 386, 81, 'smithing_table'), (493, 395, 81, 'barrel'),
):
    inhabit_home(x, z, floor, job)
for x, z in ((105, 466), (625, 466), (41, 109), (751, 137), (67, 23)):
    house(x, z, 80, 'stone_bricks', 'spruce_planks', z + 10)
    inhabit_home(x, z, 80, 'composter')


plans = [city_plan(seed) for seed in range(VARIANT_COUNT)]



def assign(name, value):
    return f'scoreboard players set #{name} {OBJECTIVE} {value}'


def matches(name, value):
    return f'if score #{name} {OBJECTIVE} matches {value}'


tiles = [(x, z) for z in range(0, SIZE, TILE) for x in range(0, SIZE, TILE)]
dispatch = []
for index, (x, z) in enumerate(tiles):
    end_x, end_z = x + TILE - 1, z + TILE - 1
    area = f'{x} {z} {end_x} {end_z}'
    prefix = f'tile/{index}'
    ready = ' '.join(
        f'if loaded {cx} {SURFACE} {cz}'
        for cx in range(x, end_x + 1, 16)
        for cz in range(z, end_z + 1, 16)
    )
    dispatch.append(f'execute {matches("tile", index)} run return run {call(prefix + "/tick")}')
    function(prefix + '/tick', [
        f'execute {matches("loading", 0)} run return run {call(prefix + "/load")}',
        f'execute {ready} run {call(prefix + "/apply")}',
    ])
    function(prefix + '/load', [f'forceload add {area}', assign('loading', 1)])
    def tile_commands(placements):
        for x1, z1, x2, z2, y1, y2, material in placements:
            left, right = max(x, x1), min(end_x, x2)
            top, bottom = max(z, z1), min(end_z, z2)
            if left <= right and top <= bottom:
                for layer in range(y1, y2 + 1, 4):
                    yield fill(left, layer, top, right, min(layer + 3, y2), bottom, material)

    commands = []

    def inhabitants(positions):
        return [
            f'summon minecraft:villager {px + 0.5} {py} {pz + 0.5} '
            '{PersistenceRequired:1b,Tags:["cc_resident"]}'
            for px, py, pz in positions if x <= px <= end_x and z <= pz <= end_z
        ]

    for shape in range(4):
        overlay = list(tile_commands(defense_plans[shape][0]))
        overlay.extend(tile_commands(farm_plans[shape]))
        if overlay:
            name = f'{prefix}/land_{shape}'
            function(name, overlay)
            commands.append(f'execute {matches("land", shape)} run {call(name)}')
    commands.extend(tile_commands(regions))
    for variant, (waterways, district, residents) in enumerate(plans):
        for part, placements in (('water', waterways), ('district', district)):
            overlay = list(tile_commands(placements))
            if part == 'district':
                overlay.extend(inhabitants(residents))
            if overlay:
                name = f'{prefix}/{part}_{variant}'
                function(name, overlay)
                commands.append(f'execute {matches(part, variant)} run {call(name)}')
    commands.extend(inhabitants(shared_residents))
    function(prefix + '/build', commands)
    function(prefix + '/clear', [
        *[fill(x, y, z, end_x, y + 3, end_z, 'air') for y in range(81, 125, 4)],
        fill(x, SURFACE, z, end_x, SURFACE, end_z, 'grass_block'),
        f'kill @e[type=!minecraft:player,x={x},y=81,z={z},dx={TILE-1},dy=43,dz={TILE-1}]',
    ])
    function(prefix + '/apply', [
        f'execute {matches("state", 1)} run {call(prefix + "/build")}',
        f'execute {matches("state", 3)} run {call(prefix + "/clear")}',
        f'forceload remove {area}',
        assign('loading', 0),
        f'scoreboard players add #tile {OBJECTIVE} 1',
    ])

function('load', [f'scoreboard objectives add {OBJECTIVE} dummy'])
function('tick', [
    f'execute {matches("state", 1)} in {DIMENSION} run {call("city/work")}',
    f'execute {matches("state", 3)} in {DIMENSION} run {call("city/work")}',
    f'execute {matches("state", 2)} as @a[tag=cc11_visit] run {call("city/arrive")}',
    f'execute {matches("state", 0)} as @a[tag=cc11_reset] run {call("city/reset_notice")}',
])
function('city/work', [
    f'execute {matches("tile", len(tiles))} run return run {call("city/finish")}',
    *dispatch,
])
function('city/finish', [
    f'execute {matches("state", 1)} run return run {assign("state", 2)}',
    assign('state', 0),
])
for part in ('water', 'district'):
    function(f'city/roll_{part}', [
        f'execute unless score #{part} {OBJECTIVE} matches 0..{VARIANT_COUNT - 1} '
        f'run return run execute store result score #{part} {OBJECTIVE} run random value 0..{VARIANT_COUNT - 1}',
        f'execute store result score #offset {OBJECTIVE} run random value 1..{VARIANT_COUNT - 1}',
        f'scoreboard players operation #{part} {OBJECTIVE} += #offset {OBJECTIVE}',
        f'execute {matches(part, f"{VARIANT_COUNT}..")} run scoreboard players remove #{part} {OBJECTIVE} {VARIANT_COUNT}',
    ])
function('city/start', [
    call('city/roll_water'), call('city/roll_district'),
    assign('shape_count', 4),
    f'scoreboard players operation #next_land {OBJECTIVE} = #water {OBJECTIVE}',
    f'scoreboard players operation #next_land {OBJECTIVE} %= #shape_count {OBJECTIVE}',
    f'execute if score #next_land {OBJECTIVE} = #land {OBJECTIVE} run scoreboard players add #water {OBJECTIVE} 1',
    f'execute {matches("water", f"{VARIANT_COUNT}..")} run scoreboard players remove #water {OBJECTIVE} {VARIANT_COUNT}',
    f'scoreboard players operation #land {OBJECTIVE} = #water {OBJECTIVE}',
    f'scoreboard players operation #land {OBJECTIVE} %= #shape_count {OBJECTIVE}', 
    assign('tile', 0), assign('loading', 0), assign('state', 1),
])
function('visit', [
    f'execute {matches("state", 3)} run return run tellraw @s "Aguarde o reset."',
    f'execute {matches("state", 2)} run return run {call("city/arrive")}',
    'tag @s add cc11_visit',
    f'execute unless score #state {OBJECTIVE} matches 1 run {call("city/start")}',
    'tellraw @s "Preparando a capital de 800 × 800. Voce sera teleportado ao concluir."',
])
function('city/arrive', [
    'tag @s remove cc11_visit',
    f'execute in {DIMENSION} run teleport @s {SPAWN} 180 0',
    call('status'),
])
function('status', [
    f'execute {matches("state", 1)} run return run tellraw @s ["Gerando setores: ",{{"score":{{"name":"#tile","objective":"{OBJECTIVE}"}}}},"/{len(tiles)}"]',
    f'execute {matches("state", 3)} run return run tellraw @s "Reset em andamento."',
    f'execute unless score #state {OBJECTIVE} matches 2 run return run tellraw @s "Use /function capital_cities:visit para gerar a capital."',
    f'tellraw @s ["Capital 0.11.0 | Rio ",{{"score":{{"name":"#water","objective":"{OBJECTIVE}"}}}}," | Bairro ",{{"score":{{"name":"#district","objective":"{OBJECTIVE}"}}}}]',
])
function('reset', [
    assign('occupied', 0),
    f'execute as @a at @s if dimension {DIMENSION} run {assign("occupied", 1)}',
    f'execute {matches("occupied", 1)} run return run tellraw @s "Todos devem sair da capital antes do reset."',
    f'execute unless score #state {OBJECTIVE} matches 2 run return run tellraw @s "O reset exige uma capital pronta. Consulte /function capital_cities:status."',
    'tag @s add cc11_reset',
    assign('tile', 0),
    assign('loading', 0),
    assign('state', 3),
    'tellraw @s "Limpando a planta da capital 0.11."',
])
function('city/reset_notice', [
    'tag @s remove cc11_reset',
    'tellraw @s "Planta limpa. Use /function capital_cities:visit para reconstruir."',
])

files['LEIA-ME.txt'] = f"""Capital Cities {VERSION} — Minecraft Java {MINECRAFT_VERSION}

Instale o ZIP em datapacks, feche e reabra o mundo.
Com comandos habilitados, use /function capital_cities:visit.
Aguarde a geração em setores. A chegada é na estrada entre as lavouras.
Siga para o norte, passe pelo portão e chegue à praça do mercado.
Explore os bairros habitados, as casas de pedra e os quatro cinturões agrícolas.
O status mostra o rio e o bairro sorteados. Depois do reset, ambos mudam na próxima visita.
A muralha tem curvas assimétricas. No forte, os arcos desencontrados ligam os pátios.
Use /function capital_cities:status para consultar o progresso.

Antes da visita, anote coordenadas seguras no Overworld.
Para voltar, use /execute in minecraft:overworld run tp @s <x> <y> <z>.

Use um mundo novo para testar. A 0.11 tem uma dimensão própria.
Aldeões são gerados com camas e postos de trabalho em casas urbanas e rurais.
O reset limpa a planta da 0.11 entre Y 81 e 124 e restaura a grama em Y 80.
Saia da dimensão antes de executá-lo.
"""

output = Path(__file__).resolve().parents[1] / 'dist' / f'capital_cities_v{VERSION}_mc{MINECRAFT_VERSION}.zip'
output.parent.mkdir(parents=True, exist_ok=True)
with ZipFile(output, 'w', ZIP_DEFLATED) as archive:
    for path, content in files.items():
        archive.writestr(path, content)
with ZipFile(output) as archive:
    assert archive.testzip() is None
print(f'{output} ({len(files)} files)')
