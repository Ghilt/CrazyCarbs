

var inventory_sprite = object_get_sprite(o_gui_inventory)
instance_create_layer(guiXMid - sprite_get_width(inventory_sprite) / 2, guiYBot - sprite_get_height(inventory_sprite), "Gui", o_gui_inventory)

var inventoryHeight = sprite_get_height(inventory_sprite) 

inventory = []

inventoryX = guiXMid - (guiWidth * 0.25)
inventoryY = guiYBot - inventoryHeight + 64

// creationData is optional , {x, y, carry, action} 
addItem = function(type, creationData = false) {
    var buildPos = { x: inventoryX + array_length(inventory) * itemSize, y: inventoryY }
    var battlePos = { x : buildPos.x, y: buildPos.y + itemSize }
    
    var guiState = new GuiState(buildPos.x, buildPos.y, battlePos.x, battlePos.y)
    
    var initData = creationData ? { 
        type: type, 
        owner: id, 
        guiState, 
        x: creationData.x, 
        y: creationData.y,
        carry: creationData.carry,
        action: creationData.action
    } : {
        type: type, 
        owner: id, 
        guiState 
    }
    
    var inst = instance_create_layer(buildPos.x, buildPos.y, "Gui", o_placable_instance, initData) 
    array_push(inventory, inst)
    return inst
}

removeItem = function(item) {
    with { inventory, item }
    var index = array_find_index(inventory, function(_e, _i) { 
            return _e == item; 
        } 
    )

    array_delete(inventory, index, 1)
    instance_destroy(item.id)
    compactify()
}

compactify = function() {
    for (var i = 0; i < array_length(inventory); i++) {
        inventory[i].guiState.buildPos.x = inventoryX + i * itemSize
        inventory[i].guiState.battlePos.x = inventoryX + i * itemSize
    }
}

getBuyIntent = function(mouseX, mouseY) {
    var isOverInventoryBox = position_meeting(mouseX, mouseY, o_gui_inventory)

    return { buyIt: isOverInventoryBox, x: inventoryX, y: inventoryY}
}