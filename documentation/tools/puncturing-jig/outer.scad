include <common.scad>


module outer() {
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

            // Vertical front ribs
            for (pos = rib_positions_front) {
                translate([rim + material_xy + pos, 0, 0])
                cube([material_xy, rim, height]);
            }

            // Vertical side ribs
            for (pos = rib_positions_side) {
                translate([0, rim + material_xy + pos, 0])
                cube([base_size.x, material_xy, height]);
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
        translate([
            base_size.x * position.x,
            base_size.y * position.y,
            height / 2,
        ])
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
        difference() {
            children();

            translate([-base_size.x / 2, base_size.y, height / 2])
            linear_extrude(height * 2, center = true)
            square(base_size * 2);

            for (i = [0, 1]) {
                translate([
                    rim + material_xy / 2 + (inner_size.x + material_xy) * i,
                    base_size.y - rib_distance_side + material_xy / 2,
                    height / 2,
                ])
                linear_extrude(height * 2, center = true)
                square([inner_size.x / 2, rib_distance_side * 2]);
            }
        }
    }
}
