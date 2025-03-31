var isoSpace = roomToIso(x, y)
draw_sprite_ext(sprite_index, image_index, isoSpace.x, isoSpace.y, rotated ? -1 : 1, 1, 0, c_white, 1)