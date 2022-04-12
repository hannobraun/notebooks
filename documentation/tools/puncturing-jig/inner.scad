// TASK: This is not the actual diameter of the awl. Figure that out.
awl_diameter = 4;


module inner(
    material_xy,
    material_z,
    rim,
    inner_size,
    rib_positions_front,
    rib_positions_side,
    rib_distance_side,
) {
    hole_distance_nominal = 20;
    num_holes             = round(inner_size.x / hole_distance_nominal / 2) * 2;
    hole_distance_actual  = inner_size.x / num_holes;

    guide_height = rim * 4;

    add_holes()
    add_connector()
    union() {
        base();
        ribs();
    }

    module base() {
        linear_extrude(material_z)
        square(inner_size);
    }

    module add_holes() {
        difference() {
            union() {
                children();
                guides();
            }

            holes();
        }

        // TASK: The awl point is conical and reaches its full diameter only
        //       near the top. Making the guide (and therefore the whole tool)
        //       high enough to accomodate that is not practical.
        //
        //       I think this means that the guide needs to be flexible, so it
        //       centers the awl point all the way down.
        module guides() {
            for_each_hole()
            cylinder(d = awl_diameter * 2, h = material_z + rim);
        }

        module holes() {
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

    // TASK: Instead of having one protruding and one recessed part, consider
    //       having multiple smaller such pairs, so there's a rib between each
    //       pair. So basically have 4 protruding and 4 recessed parts.
    //
    //       This would provide more surface for the connectiong, as well as not
    //       interrupt most of the ribs, which should make the final assembly
    //       much stronger.
    module add_connector() {
        difference() {
            union() {
                children();

                linear_extrude(material_z)
                translate([inner_size.x / 2, inner_size.y])
                square([inner_size.x / 2, rib_distance_side]);
            }

            linear_extrude(guide_height * 4, center = true)
            translate([-inner_size.x / 2, inner_size.y - rib_distance_side])
            square([inner_size.x, rib_distance_side * 4]);
        }
    }

    // TASK: Round corners of ribs.
    module ribs() {
        for (pos = rib_positions_front) {
            translate([pos, 0, material_z])
            cube([material_xy, inner_size.y + rib_distance_side, rim]);
        }

        for (pos = rib_positions_side) {
            translate([0, pos, material_z])
            cube([inner_size.x, material_xy, rim]);
        }
    }
}
