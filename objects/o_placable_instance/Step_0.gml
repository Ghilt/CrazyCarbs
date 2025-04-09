if (!o_game_phase_manager.isBuildPhase()) {
    returnToOwnerPosition()
    return;
}

var closestPos = o_influence_grid_manager.getClosestBuildableSpot(mouse_x, mouse_y, footprint, terrainRequirement)

switch (carry) {
    case Carry.None:
        if (action == Action.Sell) {
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
    
    image_xscale = lerp(image_xscale, zoomPercent * cameraViewPortDiff  * rotationModifier, smoothScale)
    image_yscale = lerp(image_yscale, zoomPercent * cameraViewPortDiff, smoothScale)
    layer = layer_get_id("GuiStratosphere")
} else {
    layer = layer_get_id("GuiAir")  
}