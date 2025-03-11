if (o_debugger_util.isoProjection) {
    sprites = spritesIso
} else { 
    sprites = spritesNormal
}

var pos = instancePosition(id)

var displacement = vectorSubtract(pos, previousPos)


if (displacement.x != 0 || displacement.y != 0) {
   image_speed = 1  
} else {
    image_speed = 0
}

sprite_index = sprites[vectorQuadrant(displacement)]


previousPos = pos