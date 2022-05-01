// Dimensions of A5 (ISO 216) paper
a5 = [148, 210];

// Intended print settings
layer_height    = 0.25;
extrusion_width = 0.45;

wall_angle  = 60;
wall_height = 10;
wall_top    = extrusion_width * 2;
wall_total  = wall_top + wall_height / tan(wall_angle);

base_size = [
    a5.x * 0.75 + wall_total,
    a5.y * 0.75 + wall_total,
    layer_height * 4,
];


base();


module base() {
    cube(base_size);
}
