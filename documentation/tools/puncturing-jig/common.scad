// Intended print settings
layer_height    = 0.25;
extrusion_width = 0.45;

// Material strength
material_xy = extrusion_width * 2;
material_z  = layer_height * 4;

// Dimensions of A5 (ISO 216) paper
a5 = [148, 210];

height = 40;

gap =  0.2;
rim = 10;

rib_distance = 20;

inner_size = [a5.x, a5.y / 2] + [gap, gap / 2];
outer_size = inner_size + [material_xy * 2, material_xy];
base_size  = outer_size + [rim * 2, rim];

rib_distance_target = 20;

num_ribs_front = round((inner_size.x / rib_distance_target - 1) / 2) * 2 + 1;
num_ribs_side  = round(inner_size.y / rib_distance_target - 1);

rib_distance_front = inner_size.x / (num_ribs_front + 1);
rib_distance_side  = inner_size.y / (num_ribs_side  + 1);

rib_positions_front = [
    for (i = [1:num_ribs_front])
        rib_distance_front * i - material_xy / 2
];
rib_positions_side = [
    for (i = [1:num_ribs_side + 1])
        rib_distance_side * i - material_xy / 2
];
