enum Carry {
    None, ClickCarry, HoldCarry
}

enum Action {
    None, Build // Sell
}

action = Action.None
carry = Carry.None
smoothCarry = 0.4
smoothScale = 0.4
clickGuard = false
time = 0
pickupFrameThreshold = 8
buildSnappingRange = 60

originX = x
originY = y
originalWidth = sprite_width // might be better to get this info from sprite_get_info(index).original_width
originalHeight = sprite_height

function placeInstance(pos) {
    o_influence_grid_manager.buildAt(pos)
    instance_destroy(self)
}