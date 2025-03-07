var isoSpace = roomToIso(x, y)
draw_sprite(sprite_index, image_index, isoSpace.x, isoSpace.y)

if (!o_debugger_util.isoProjection) {
    draw_circle(x, y, range, true)
}
