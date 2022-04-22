include <modules.scad>;

bottom();

translate([
    material_xy + gap / 2,
    material_xy + size_inner.y - hole_offset * 2,
    size_inner.z / 2,
])
top();
