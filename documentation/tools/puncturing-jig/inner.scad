// TASK: This is not the actual diameter of the awl. Figure that out.
awl_diameter = 4;


module inner(
    material_z,
    rim,
    inner_size,
    rib_distance_side,
) {
    hole_distance_nominal = 20;
    num_holes             = round(inner_size.x / hole_distance_nominal / 2) * 2;
    hole_distance_actual  = inner_size.x / num_holes;

    guide_height = rim * 4;

    // TASK: Add ribs.
    add_holes()
    add_connector()
    linear_extrude(material_z)
    base();

    module base() {
        square(inner_size);
    }

    module add_holes() {
        difference() {
            union() {
                children();

                for_each_hole()
                cylinder(d = awl_diameter * 2, h = material_z + rim);
            }

            linear_extrude(guide_height, center = true)
            for_each_hole()
            circle(d = awl_diameter);
        }

        module for_each_hole() {
            for (i = [0:num_holes / 2 - 1]) {
                translate([
                    inner_size.x / 2
                        + hole_distance_actual / 2
                        + hole_distance_actual * i,
                    inner_size.y,
                ])
                children();
            }
        }
    }

    module add_connector() {
        difference() {
            union() {
                children();

                linear_extrude(material_z)
                translate([inner_size.x / 2, inner_size.y])
                connector_square();
            }

            linear_extrude(guide_height * 4, center = true)
            translate([0, inner_size.y - rib_distance_side])
            connector_square();
        }

        module connector_square() {
            square([inner_size.x / 2, rib_distance_side]);
        }
    }
}
