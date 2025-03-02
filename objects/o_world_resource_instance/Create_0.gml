movement = animcurve_get_channel(c_movement, "fast_slow")
scale = animcurve_get_channel(c_movement, "fast_throw")
targetScale = 0.5

// inits with: originPositionType = GUI | WORLD. When transitioning from gui layer to world, the detach point should not be converted to iso since the gui is not projected
// we convert the actual position here to counteract iso conversion in draw call:
if (variable_instance_exists(id, "originPositionType") && originPositionType == OriginPositionType.GUI) {
    origin = isoToRoom(origin.x, origin.y)
}