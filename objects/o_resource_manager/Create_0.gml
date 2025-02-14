enum Resource
{
    LUMBER,
    WOOL,
    ORE
}

resourceArea = object_get_sprite(o_gui_resource_area)
instance_create_layer(guiXMid - sprite_get_width(resourceArea) / 2, 0, "Gui", o_gui_resource_area)


resourceAreaResourceStartX = guiXMid - resourceArea.sprite_width/2 + 64
resourceAreaResourceStartY = 8
storageSize = 45
storageRowSize = 15
overproductionDump = { x: guiXMid + resourceArea.sprite_width/2 + 64, y: resourceAreaResourceStartY + 67 }


// Indexes tied to enum above
resources = [0, 0, 0]

resourceInstances = []



function generateResource(type, amount, resourceInstance) {
    resourceInstance.depth = 0
    resources[type] += amount

    var currentResourceCount = array_length(resourceInstances)
    
    if (currentResourceCount == storageSize) {
        
        for (var i = 0; i < array_length(resourceInstances); i++) {
            resourceInstances[i].battlePos = { x: overproductionDump.x, y: overproductionDump.y } 
            resourceInstances[i].alarm[0] = 2 * one_second 
        }
        
        resources = [0, 0, 0]
        resourceInstances = [] // maybe store them somewhere else to do some other fancy animation, load them on a ship or something
        currentResourceCount = 0
    }
    
    var row = currentResourceCount div storageRowSize
    var column = currentResourceCount mod storageRowSize
    
    var targetX = resourceAreaResourceStartX + column * resourceInstance.sprite_width
    var targetY = resourceAreaResourceStartY + row * resourceInstance.sprite_height

    resourceInstance.battlePos = { x: targetX, y: targetY }
    array_push(resourceInstances, resourceInstance)
}