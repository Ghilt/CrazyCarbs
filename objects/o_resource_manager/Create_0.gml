// This resource manager is responsible for managing prodouced resources during the battle phase

enum Resource
{
    LUMBER,
    WOOL,
    ORE
}

var resourceArea = object_get_sprite(o_gui_resource_area)
var resourceAreaWidth = sprite_get_width(resourceArea)

instance_create_layer(guiXMid - resourceAreaWidth / 2, 0, "Gui", o_gui_resource_area)

resourceAreaResourceStartX = guiXMid - resourceAreaWidth / 2 + 64
resourceAreaResourceStartY = 8
storageSize = 45
storageRowSize = 15
overproductionDump = { x: guiXMid + resourceAreaWidth + 64, y: resourceAreaResourceStartY + 67 }


// Indexes tied to enum above
resources = [0, 0, 0]

resourceInstances = []



generateResource = function(type, amount, resourceInstance) {
    resourceInstance.depth = 0
    resources[type] += amount

    var currentResourceCount = array_length(resourceInstances)
    
    if (currentResourceCount == storageSize) {
        
        for (var i = 0; i < array_length(resourceInstances); i++) {
            resourceInstances[i].battlePos = { x: overproductionDump.x, y: overproductionDump.y } 
            resourceInstances[i].destroyAfterDelay()
        }
        
        resources = [0, 0, 0]
        resourceInstances = []
        currentResourceCount = 0
    }
    
    var row = currentResourceCount div storageRowSize
    var column = currentResourceCount mod storageRowSize
    
    var targetX = resourceAreaResourceStartX + column * resourceInstance.sprite_width
    var targetY = resourceAreaResourceStartY + row * resourceInstance.sprite_height

    resourceInstance.battlePos = { x: targetX, y: targetY }
    array_push(resourceInstances, resourceInstance)
}