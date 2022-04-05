use <inner.scad>
use <outer.scad>


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

num_ribs_front = round(outer_size.x / rib_distance_target - 1);
num_ribs_side  = round(outer_size.y / rib_distance_target - 1);

rib_distance_front = outer_size.x / (num_ribs_front + 1);
rib_distance_side  = outer_size.y / (num_ribs_side  + 1);


$fn = 60;


// outer(
//     material_xy        = material_xy,
//     material_z         = material_z,
//     height             = height,
//     rim                = rim,
//     inner_size         = inner_size,
//     outer_size         = outer_size,
//     base_size          = base_size,
//     num_ribs_front     = num_ribs_front,
//     num_ribs_side      = num_ribs_side,
//     rib_distance_front = rib_distance_front,
//     rib_distance_side  = rib_distance_side
// );
inner(
    material_z = material_z,
    inner_size = inner_size
);
