// Required field: type - which building this is

// These instances live in the inventory in the GUI layer.

enum Carry {
    None, ClickCarry, HoldCarry
}

enum Action {
    None, Build, Sell, Buy
}

#region Logistical variables - Helps managing the movement of the item in the gui
action = variable_instance_exists(id, "action") ? action : Action.None
carry = variable_instance_exists(id, "carry") ? carry : Carry.None
smoothCarry = 0.4
smoothScale = 0.4
pickupFrameThreshold = 8
buildSnappingRange = itemSize
originalWidth = sprite_width
originalHeight = sprite_height
rotationModifier = 1 // this is used to mirror the sprite, when user rotates building for placement

#endregion

carriedBuildingData = ds_map_find_value(global.buildings, type)
sprite_index = object_get_sprite(carriedBuildingData.object)
guiScale = 128 / sprite_width // Square sprite assumed


terrainRequirement = carriedBuildingData.terrainRequirement
footprint = carriedBuildingData.footprint

layer = layer_get_id("GuiAir")
var zoomPercent = o_zoom_manager.getZoomPercentage()
var cameraViewPortDiff = o_zoom_manager.getViewportCameraSizeDifferenceRatio()

// 
image_xscale = zoomPercent * cameraViewPortDiff  * rotationModifier
image_yscale = zoomPercent * cameraViewPortDiff

isOwnedByPlayer = owner.object_index == o_inventory_manager

placeInstance = function(pos) {
    
    var canAfford = !isOwnedByPlayer && o_shop_manager.canAfford(type)
    
    var success = (canAfford || isOwnedByPlayer) && o_influence_grid_manager.buildAt(pos, type, rotationModifier == -1)
    if (success) {
        // Might be built directly from shop, or from inventory. Owning manager needs to be updated
        owner.removeItem(id)
    } else {
        // TODO this is a bit of a mess
        action = Action.None
        carry = Carry.None
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
        resetMovStruct() 
    }
}


returnToOwnerPosition = function () {
    //Only scooch here
    o_gui_manager.uiScooch(id)
    
    image_xscale = lerp(image_xscale, guiScale  * rotationModifier, smoothScale * 0.2)
    image_yscale = lerp(image_yscale, guiScale, smoothScale * 0.2)
}

resetMovStruct = function(){
    guiState.mov.originX = x
    guiState.mov.originY = y
    guiState.mov.timePassed = 0
}

// mousePressCounter == 0, only hover
// mousePressCounter > 0, mouse button pressed
// mousePressCounter = -1, mouse button just released
onDelegatedMouse = function(pos, mousePressCounter) {
    switch (carry) {
        case Carry.None:
            if (position_meeting(mouseGuiX, mouseGuiY, id) && mousePressCounter == 1) {
                // Carry initiation
                o_placable_instance.carry = Carry.None
                carry = Carry.ClickCarry
            }
        break;
        case Carry.ClickCarry:
            if (mousePressCounter > pickupFrameThreshold){
                o_placable_instance.carry = Carry.None
                carry = Carry.HoldCarry
            }
        
            if (mousePressCounter == 1) {
                carry = Carry.None
                resetMovStruct()
            }
    
        break;
    
        case Carry.HoldCarry:
            if (mousePressCounter == -1) {
                carry = Carry.None
                resetMovStruct()
            }
        break;
    }
    
    return carry == Carry.ClickCarry || carry == Carry.HoldCarry
}