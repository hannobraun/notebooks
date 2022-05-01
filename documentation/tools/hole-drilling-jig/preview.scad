include <modules.scad>;

bottom();

translate([
    material_xy + gap / 2,
    material_xy + size_inner.y - hole_offset * 2,
    material_z,
])
top();
