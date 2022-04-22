// Intended print settings
layer_height    = 0.25;
extrusion_width = 0.45;

// Material strength
material_xy = extrusion_width * 2;
material_z  = layer_height * 4;

// Dimensions of A5 (ISO 216) paper
a5 = [148, 210];

hole_diameter = 1.5;
hole_offset   = hole_diameter * 3;

gap = 0.2;

size_inner = [
    a5.x,
    a5.y / 2 + hole_offset,
    20,
];
size_outer = [
    size_inner.x + material_xy * 2,
    size_inner.y + material_xy,
    size_inner.z + material_z,
];
size_top = [
    size_inner.x - gap,
    hole_offset * 2,
    material_z,
];

hole_distance_nominal = 20;
num_holes             = round(size_inner.x / hole_distance_nominal / 2) * 2;
hole_distance_actual  = size_inner.x / num_holes;


$fn = 60;


bottom();

translate([
    material_xy + gap / 2,
    material_xy + a5.y / 2 - size_top.y / 2,
    size_inner.z / 2,
])
top();


module bottom() {
    difference() {
        cube(size_outer);

        translate([material_xy, material_xy, material_z])
        union() {
            cube([size_inner.x, size_inner.y * 2, size_inner.z * 2]);

            translate([0, a5.y / 2, 0])
            holes();
        }
    }
}

// TASK: Add piece to line up top with bottom part.
module top() {
    difference() {
        cube(size_top);

        translate([0, size_top.y / 2, 0])
        holes();
    }
}

module holes() {
    for (i = [1:num_holes]) {
        translate([hole_distance_actual * (i - 0.5), 0, 0])
        cylinder(d = hole_diameter, h = size_outer.z, center = true);
    }
}
