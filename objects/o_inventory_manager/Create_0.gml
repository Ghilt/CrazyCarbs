
itemSize = sprite_get_height(object_get_sprite(o_placable_instance))
var inventoryHeight = sprite_get_height(object_get_sprite(o_gui_inventory)) - itemSize

inventory = []

inventoryX = guiXMid - (guiWidth * 0.25)
inventoryY = guiYBot - inventoryHeight


addItem = function(item, amount = 1) {
    for (var i = 0; i < amount; i++) {
        var inst = instance_create_layer(inventoryX + array_length(inventory) * itemSize, inventoryY, "Gui", o_placable_instance) 
        array_push(inventory, inst)
    }
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

compactify = function(){
    for (var i = 0; i < array_length(inventory); i++) {
        inventory[i].buildPos.x = inventoryX + i * itemSize
        inventory[i].battlePos.x = inventoryX + i * itemSize
    }
}