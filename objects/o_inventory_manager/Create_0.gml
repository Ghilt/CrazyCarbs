
var inventoryHeight = 128
itemSize = 64

inventory = []

inventoryX = guiXMid - (guiWidth * 0.25)
inventoryY = guiYBot - inventoryHeight



function addItem(item, amount = 1) {
    for (var i = 0; i < amount; i++) {
        var inst = instance_create_layer(inventoryX + array_length(inventory) * itemSize, inventoryY, "Gui", o_placable_instance)
        inst.depth = 0
        array_push(inventory, inst)
    }
    
}