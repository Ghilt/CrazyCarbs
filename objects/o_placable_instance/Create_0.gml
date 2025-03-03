// Required field: type - which building this is

// These instances live in the inventory in the GUI layer.

enum Carry {
    None, ClickCarry, HoldCarry
}

enum Action {
    None, Build, Sell, Buy
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
#endregion

sprite_index = object_get_sprite(ds_map_find_value(global.buildings, type).building)
terrainRequirement = ds_map_find_value(global.buildings, type).terrainRequirement

layer = layer_get_id("GuiAir")

isOwnedByPlayer = owner.object_index == o_inventory_manager

placeInstance = function(pos) {
    
    var canAfford = !isOwnedByPlayer && o_shop_manager.canAfford(type)
    
    var success = (canAfford || isOwnedByPlayer) && o_influence_grid_manager.buildAt(pos, type)
    if (success) {
        // Might be built directly from shop, or from inventory. Owning manager needs to be updated
        owner.removeItem(id)
    } else {
        // TODO this is a bit of a mess
        action = Action.None
        carry = Carry.None
        time = 0
        resetMovStruct()
    }
}

sellInstance = function() {
    // owner is garanteed to be the o_inventory_manager here
    o_shop_manager.sellItem(type)
    owner.removeItem(id)
}

buyInstance = function() {
    // owner is garanteed to be the o_shop_manager here
    var canAfford = !isOwnedByPlayer && o_shop_manager.canAfford(type)
    if (canAfford) {
        o_inventory_manager.addItem(type)
        owner.removeItem(id)
    } else {
        action = Action.None
        carry = Carry.None
        time = 0
        resetMovStruct() 
    }
}


returnToOwnerPosition = function () {
    //Only scooch here
    o_gui_manager.uiScooch(id)
    
    image_xscale = lerp(image_xscale, 1, smoothScale * 0.2)
    image_yscale = lerp(image_yscale, 1, smoothScale * 0.2)
}

resetMovStruct = function(){
    guiState.mov.originX = x
    guiState.mov.originY = y
    guiState.mov.timePassed = 0
}