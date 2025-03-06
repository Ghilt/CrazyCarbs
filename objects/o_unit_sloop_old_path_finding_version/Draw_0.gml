var isoSpace = roomToIso(x, y)
draw_sprite(sprite_index, image_index, isoSpace.x, isoSpace.y)

for (var i = 0; i < path_get_number(path); i++) {
    draw_circle(path_get_point_x(path, i), path_get_point_y(path, i), 5, false)
}