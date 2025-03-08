if (isDefeated) {
    return;
}

var isoSpace = roomToIso(x, y)
draw_sprite(sprite_index, image_index, isoSpace.x, isoSpace.y)

if (!o_debugger_util.isoProjection) {
    draw_circle(x, y, stats.range, true)
}
