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


// function inner_to_walls(inner) = inner + 2*material_xy;
// function inner_to_outer(inner) = inner_to_walls(inner) + 2*rim;


// inner_x = a5[0] + gap;
// inner_y = a5[1] + gap;

// outer_x = inner_to_outer(inner_x);
// outer_y = inner_to_outer(inner_y);

// walls_x = inner_to_walls(inner_x);
// walls_y = inner_to_walls(inner_y);


// $fn = 60;


// // TASK: The model is too big to print. Only model half of it, with an
// //       interface in the middle, so the two halves can be glued together.
// // TASK: Add horizontal ribs.


// model();


// module model() {
//     difference() {
//         union() {
//             base();
//             translate([0, 0, height - material_z]) base();

//             walls();

//             ribs();
//         }

//         inner();
//         corners();
//     }
// }

// module base() {
//     linear_extrude(material_z)
//     square([outer_x, outer_y]);
// }

// module walls() {
//     translate([rim, rim])
//     linear_extrude(height)
//     union() {
//         left_right();
//         front_back();
//         translate([0, inner_y + material_xy]) left_right();
//         translate([inner_x + material_xy, 0]) front_back();
//     }

//     module left_right() {
//         square([walls_x, material_xy]);
//     }

//     module front_back() {
//         square([material_xy, walls_y]);
//     }
// }

// module ribs() {
//     left_right_all();
//     front_back_all();
//     translate([outer_x - rim, 0]) left_right_all();
//     translate([0, outer_y - rim]) front_back_all();
//     corner_all();

//     module left_right_all() {
//         translate([0, rim, 0])
//         union() {
//             translate([0, inner_y * 0.25]) left_right();
//             translate([0, inner_y * 0.5 ]) left_right();
//             translate([0, inner_y * 0.75]) left_right();
//         }
//     }

//     module left_right() {
//         linear_extrude(height)
//         square([rim, material_xy]);
//     }

//     module front_back_all() {
//         translate([rim, 0, 0])
//         union() {
//             translate([inner_x * 1 / 3, 0]) front_back();
//             translate([inner_x * 2 / 3 , 0]) front_back();
//         }
//     }

//     module front_back() {
//         linear_extrude(height)
//         square([material_xy, rim]);
//     }

//     module corner_all() {
//         rotate([0, 0, 45]) corner_rib();
//         translate([outer_x, 0]) rotate([0, 0, 135]) corner_rib();
//         translate([outer_x, outer_y]) rotate([0, 0, 225]) corner_rib();
//         translate([0, outer_y]) rotate([0, 0, 315]) corner_rib();
//     }

//     module corner_rib() {
//         linear_extrude(height)
//         translate([rim / 4, -material_xy / 2])
//         square([2*rim, material_xy]);
//     }
// }

// module inner() {
//     offset = rim + material_xy;

//     linear_extrude(height)
//     translate([offset, offset])
//     square([inner_x, inner_y]);
// }

// module corners() {
//     linear_extrude(height)
//     union() {
//         corner();
//         translate([outer_x, 0]) rotate([0, 0, 90]) corner();
//         translate([outer_x, outer_y]) rotate([0, 0, 180]) corner();
//         translate([0, outer_y]) rotate([0, 0, -90]) corner();
//     }

//     module corner() {
//         difference() {
//             square([rim, rim]);

//             translate([rim, rim])
//             circle(r = rim);
//         }
//     }
// }
