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
    hole_offset * 2 + hole_offset,
    material_z,
];

hole_distance_nominal = 20;
num_holes             = round(size_inner.x / hole_distance_nominal / 2) * 2;
hole_distance_actual  = size_inner.x / num_holes;


$fn = 60;


// TASK: The current approach has two weaknesses:
//       1. The construction is too flimsy. Everything should be a bit thicker,
//          so the jig can be accurate.
//       2. The inner size of the printed part is not completely accurate. It's
//          short by about an extrusion width (0.45mm). This is *not* visible in
//          the slicer, where everything is alright.
//
//       The source of the slight inaccuracy almost doesn't matter. The real
//       problem is that the design is so dependent on perfect accuracy.
//
//       There's really no reason why the stack of paper should be enclosed on
//       two sides in the first place. It should be perfectly fine, to have two
//       orthogonal sides that meet at a corner (which should be relieved).
//
//       If the stack where to be constrained at the opposite sides, those
//       opposite sides should be adjustable (and that would require a
//       constraint at the top too).
//
//       I think a good approach for the next iteration would be a two-sided jig
//       that has more substance to it.


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

module top() {
    difference() {
        union() {
            cube(size_top);

            translate([
                (size_top.x - size_outer.x) / 2,
                size_top.y - hole_offset,
                0,
            ])
            cube([size_outer.x, hole_offset, material_z]);
        }

        // TASK: For some reason, the holes are not central on the top part. The
        //       difference between the distances of the outer hole perimeters
        //       to the outside of the part is about 0.2mm. This is visible in
        //       the slicer, as well as the printed part.
        translate([0, hole_offset, 0])
        holes();
    }
}

module holes() {
    for (i = [1:num_holes]) {
        translate([hole_distance_actual * (i - 0.5), 0, 0])
        cylinder(d = hole_diameter, h = size_outer.z, center = true);
    }
}