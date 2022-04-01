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

inner_size = [a5.x, a5.y / 2] + [gap, gap / 2];
outer_size = inner_size + [material_xy * 2, material_xy];
base_size  = outer_size + [rim * 2, rim];

rib_distance_target = 20;


connector()
difference() {
    union() {
        ribs();
        walls();
    }

    inner_space();

    corner([0, 0]);
    corner([1, 0]);
}


module ribs() {
    union() {
        horizontal(0.0);
        horizontal(0.5);
        horizontal(1.0);

        num_ribs_front = round(outer_size.x / rib_distance_target - 1);
        for (i = [1:num_ribs_front]) {
            location = i / (num_ribs_front + 1);
            vertical_front(location);
        }

        num_ribs_side = round((outer_size.y / rib_distance_target - 1));
        for (i = [1:num_ribs_side + 1]) {
            location = i / (num_ribs_side + 1);
            vertical_side(location);
        }

        vertical_corner(location = 0.0, angle =  45);
        vertical_corner(location = 1.0, angle = 135);
    }

    module horizontal(location) {
        offset = -(location - 0.5) * material_z / 2;

        translate([0, 0, offset + height * location])
        linear_extrude(material_z, center = true)
        square(base_size);
    }

    module vertical_front(location) {
        translate([rim + outer_size.x * location - material_xy / 2, 0, 0])
        cube([material_xy, rim, height]);
    }

    module vertical_side(location) {
        translate([0, rim + outer_size.y * location - material_xy / 2, 0])
        cube([base_size.x, material_xy, height]);
    }

    module vertical_corner(location, angle) {
        translate([base_size.x * location, 0, height / 2])
        rotate([0, 0, angle])
        translate([rim, 0, 0])
        cube([rim * 2, material_xy, height], center = true);
    }
}

module walls() {
    translate([rim, rim, 0])
    linear_extrude(height)
    square(outer_size);
}

module inner_space() {
    translate([rim + material_xy, rim + material_xy, height / 2])
    linear_extrude(height * 2, center = true)
    square([inner_size.x, inner_size.y * 2]);
}

module corner(position) {
    translate([base_size.x * position.x, base_size.y * position.y, height / 2])
    linear_extrude(height * 2, center = true)
    difference() {
        square([rim, rim] * 2, center = true);

        circle_offset = [rim, -rim];

        translate([
            circle_offset[position.x],
            circle_offset[position.y]
        ])
        circle(r = rim);
    }
}

module connector() {
    // TASK: Add connector.
    children();
}
