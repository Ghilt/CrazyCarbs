if (device_mouse_check_button(0, mb_left) ) {
    mousePressedCounter = max(mousePressedCounter, 0)
    mousePressedCounter++;
} else if (mousePressedCounter > 0) {
    // Mouse just released, -1 means this speficially in the below logic
    mousePressedCounter = -1;
    currentMousePressConsumed = false
    
    o_effects_manager.mouseClickFeedbackAt(mousePos)
    
} else {
    mousePressedCounter = 0;
}

var resolvedToHover = false
var uiPos = mouseGuiPos

// E.g if rerolling the shop when holding one of its items
carriedInstance = instance_exists(carriedInstance) ? carriedInstance : false

if (carriedInstance) {
    currentMousePressConsumed = mousePressedCounter > 0
    var isNowCarried = carriedInstance.onDelegatedMouse(uiPos, mousePressedCounter) 
    if (!isNowCarried) {
        carriedInstance = false
    }
} else {
    
    // There is also handy list version of these collision methods if I don't just wanna take a random one from all collisions
    var instanceHit = instance_position(uiPos.x, uiPos.y, o_placable_instance)

    if (instanceHit != noone) {
        currentMousePressConsumed = mousePressedCounter > 0
        var isNowCarried = instanceHit.onDelegatedMouse(uiPos, mousePressedCounter) 
        if (isNowCarried) {
            carriedInstance = instanceHit
        } else {
            carriedInstance = false
            resolvedToHover = true
            o_building_info_manager.hover(instanceHit)
        }
        return
    }
    
    
    var tile = isoMouseTile()
    var roomPos = { x: tile.x * TILE_SIZE, y: tile.y * TILE_SIZE }
    
    if (mousePressedCounter > 0 && !currentMousePressConsumed) {
        currentMousePressConsumed = true
        
        if (!o_game_phase_manager.isBuildPhase()) {
            return
        }
        
        var deactivatedBuilding = o_influence_grid_manager.removeBuildingAt(roomPos)
        
        if (deactivatedBuilding != noone) {
            var isoSpace = roomToIso(deactivatedBuilding.x, deactivatedBuilding.y)
            var newItemInInventoryInitData = o_zoom_manager.convertToGuiSpace(isoSpace.x, isoSpace.y)
            newItemInInventoryInitData.carry = Carry.ClickCarry
            newItemInInventoryInitData.action = Action.Build
            carriedInstance = o_inventory_manager.addItem(deactivatedBuilding, newItemInInventoryInitData)
        }
    } else {
        var buildingAt = o_influence_grid_manager.getBuildingAt(roomPos)
        if (buildingAt != noone) {
            resolvedToHover = true
            o_building_info_manager.hover(buildingAt)  
            return
        }
    }
}

if (!resolvedToHover) {
    // Nothing was hovered
    o_building_info_manager.resetHover()
}



