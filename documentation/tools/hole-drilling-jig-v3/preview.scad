// Dimensions of A5 (ISO 216) paper
a5 = [148, 210];

// Intended print settings
layer_height    = 0.25;
extrusion_width = 0.45;

wall_angle  = 60;
wall_height = 10;
wall_top    = extrusion_width * 2;
wall_slope  = wall_height / tan(wall_angle);
wall_total  = wall_top + wall_slope;

base_size = [
    a5.x * 0.75 + wall_total,
    a5.y * 0.75 + wall_total,
    layer_height * 4,
];


// TASK: Extract into module.
// TASK: Add holes.
union() {
    base();

    translate([0, 0, base_size.z])
    union() {
        translate([-wall_total, 0, 0])
        front_wall(base_size.x - wall_total);

        translate([0, wall_total, 0])
        side_wall(base_size.y - wall_total);

        // TASK: Add corner.
    }
}


module base() {
    cube(base_size);
}

module front_wall(length) {
    translate([base_size.x, wall_total, 0])
    rotate([0, -90, 0])
    rotate([0, 0, -90])
    wall(length);
}

module side_wall(length) {
    translate([base_size.x - wall_total, length, 0])
    rotate([90, 0, 0])
    wall(length);
}

module wall(length) {
    linear_extrude(length)
    polygon([
        [         0,           0],
        [wall_total,           0],
        [  wall_top, wall_height],
        [         0, wall_height],
    ]);
}
