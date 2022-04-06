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

    // TASK: Add ribs.
    // TASK: Extend holes upwards, to guide awl.
    difference() {
        linear_extrude(material_z)
        add_connector()
        base();

        holes();
    }

    module base() {
        square(inner_size);
    }

    module holes() {
        for (i = [0:num_holes / 2 - 1]) {
            linear_extrude(rim * 4, center = true)
            translate([
                inner_size.x / 2
                    + hole_distance_actual / 2
                    + hole_distance_actual * i,
                inner_size.y,
            ])
            circle(d = awl_diameter);
        }
    }

    module add_connector() {
        difference() {
            union() {
                children();

                translate([inner_size.x / 2, inner_size.y])
                connector_square();
            }

            translate([0, inner_size.y - rib_distance_side])
            connector_square();
        }

        module connector_square() {
            square([inner_size.x / 2, rib_distance_side]);
        }
    }
}
