
var inventoryHeight = 128
itemSize = 64

inventory = []

inventoryX = guiXMid - (guiWidth * 0.25)  // maybe use flexpanel
inventoryY = guiYBot - inventoryHeight

addItem(Building.GOLD_MINE)



function addItem(item, amount = 1) {
    for (var i = 0; i < amount; i++) {
        var inst = instance_create_layer(inventoryX + array_length(inventory) * itemSize, inventoryY, "Gui", o_placable_instance)
        inst.depth = 0
        array_push(inventory, inst)
    }
}

function removeItem(item) {
    with { inventory, item }
    var index = array_find_index(inventory, function(_e, _i) { 
            return _e == item; 
        } 
    )

    array_delete(inventory, index, 1)
    instance_destroy(item.id)
    compactify()
}

function compactify(){
    for (var i = 0; i < array_length(inventory); i++) {
        inventory[i].originX = inventoryX + i * itemSize
    }
}