if (isDefeated) {
    return;
}

var isoSpace = roomToIso(x, y)
draw_sprite(sprite_index, image_index, isoSpace.x, isoSpace.y)

if (!o_debugger_util.isoProjection) {
    draw_circle(x, y, stats.range, true)
    var dirv = global.directionVector[dir]
    dirv = { x: dirv.x * 32, y: dirv.y * 32,}
    var displaced = vectorAdd(instancePosition(id), dirv)
    draw_arrow(x, y, displaced.x, displaced.y, 20) 
}
