module inner(
    material_z,
    inner_size,
) {
    linear_extrude(material_z)
    square(inner_size);
}
