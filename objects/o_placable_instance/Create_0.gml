// These instances live in the inventory in the GUI layer.

enum Carry {
    None, ClickCarry, HoldCarry
}

enum Action {
    None, Build // Sell the thing
}

#region Logistical variables - Helps managing the movement of the item in the gui
action = Action.None
carry = Carry.None
smoothCarry = 0.4
smoothScale = 0.4
time = 0
pickupFrameThreshold = 8
buildSnappingRange = 60

originalWidth = sprite_width
originalHeight = sprite_height

buildPos = { x, y }
battlePos = {x : x, y: y + 64}

#endregion

type = irandom_range(0, 1) // randomize a structure for now

sprite_index = object_get_sprite(ds_map_find_value(global.buildings, type).building)



function placeInstance(pos) {
    o_influence_grid_manager.buildAt(pos, type)
    o_inventory_manager.removeItem(id)
}

function returnToInventoryPosition() {
    o_gui_manager.uiScooch(id)
    
    image_xscale = lerp(image_xscale, 1, smoothScale * 0.2)
    image_yscale = lerp(image_yscale, 1, smoothScale * 0.2)
}