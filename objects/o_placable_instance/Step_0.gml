if (!o_game_phase_manager.isBuildPhase()) {
    returnToOwnerPosition()
    return;
}

if (device_mouse_check_button(0, mb_left) ) {
    time = max(time, 0)
    time++;
}
else if (time > 0) {
    // Mouse just released, -1 means this speficially in the below logic
    time = -1;
}
else {
    time = 0;
}

var closestPos = o_influence_grid_manager.getClosestBuildableSpot(mouse_x, mouse_y, terrainRequirement)

switch (carry) {
    case Carry.None:
        if (position_meeting(mouseGuiX, mouseGuiY, id) && time == 1) {
            // Carry initiation
            o_placable_instance.carry = Carry.None
            carry = Carry.ClickCarry
        } else if (action == Action.Sell) {
            sellInstance()
        } else if (action == Action.Buy) {
            buyInstance()
        } else if (action == Action.Build) {
            placeInstance(closestPos) // Allow slight graphical inconsistency here for now; if you click before it has lerped all the way to the building site. It will still work
        } else {
            // return to inventory or shop
            returnToOwnerPosition()
        }
    break;
    case Carry.ClickCarry:
        if (time > pickupFrameThreshold){
            o_placable_instance.carry = Carry.None
            carry = Carry.HoldCarry
        }
    
        if (time == 1) {
            carry = Carry.None
            resetMovStruct()
        }

    break;

    case Carry.HoldCarry:
        if (time == -1) {
            carry = Carry.None
            resetMovStruct()
        }
    break;
}

var sellIntent = isOwnedByPlayer ? o_shop_manager.getSellIntent(mouseGuiX, mouseGuiY) : { sellIt: false }
var buyIntent = !isOwnedByPlayer ? o_inventory_manager.getBuyIntent(mouseGuiX, mouseGuiY) : { buyIt: false }

if (carry == Carry.ClickCarry || carry == Carry.HoldCarry) {
    if (buyIntent.buyIt) {
        x = lerp(x, buyIntent.x, smoothCarry)
        y = lerp(y, buyIntent.y, smoothCarry)
        action = Action.Buy   
    } else if (closestPos.distance < buildSnappingRange) {
        // Lets prepare to build it!
        var inIsoSpace = roomToIso(closestPos.x, closestPos.y)
        var inGuiSpace = o_zoom_manager.convertToGuiSpace(inIsoSpace.x, inIsoSpace.y)
        x = lerp(x, inGuiSpace.x, smoothCarry)
        y = lerp(y, inGuiSpace.y, smoothCarry)
        action = Action.Build
    } else if (sellIntent.sellIt) {
        x = lerp(x, sellIntent.x, smoothCarry)
        y = lerp(y, sellIntent.y, smoothCarry)
        action = Action.Sell   
    } else {
        // Follow mouse
        x = lerp(x, mouseGuiX, smoothCarry)
        y = lerp(y, mouseGuiY, smoothCarry)
        action = Action.None
    }
    
    var zoomPercent = o_zoom_manager.getZoomPercentage()
    var cameraViewPortDiff = o_zoom_manager.getViewportCameraSizeDifferenceRatio()
    
    image_xscale = lerp(image_xscale, zoomPercent * cameraViewPortDiff, smoothScale)
    image_yscale = lerp(image_yscale, zoomPercent * cameraViewPortDiff, smoothScale)
    layer = layer_get_id("GuiStratosphere")
} else {
    layer = layer_get_id("GuiAir")  
}