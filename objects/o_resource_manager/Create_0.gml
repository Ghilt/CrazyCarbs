// This resource manager is responsible for managing prodouced resources during the battle phase

enum Resource
{
    LUMBER,
    WOOL,
    ORE
}

var resourceArea = object_get_sprite(o_gui_resource_area)
var resourceAreaWidth = sprite_get_width(resourceArea)

instance_create_layer(guiXMid - resourceAreaWidth / 2, -sprite_get_height(resourceArea), "Gui", o_gui_resource_area)

resourceAreaResourceStartX = guiXMid - resourceAreaWidth / 2 + 64
resourceAreaResourceStartY = 8
storageSize = 45
storageRowSize = 15

// Indexes tied to enum above
resources = [[0, 0, 0], [0, 0, 0]]


resourceInstances = [[],[]]


// Player 0 is the player, player 1 is the enemy
generateResource = function(type, amount, resourceInstance, player) {
   resources[player][type] += 1

    var currentResourceCount = array_length(resourceInstances[player])
    
    if (currentResourceCount == storageSize) {
        // City have over produced, good job city
        var consumer = o_influence_grid_manager.getBuildingThatAcceptsOverProduction(player) // TODO handle if there is no consumer

        for (var i = 0; i < array_length(resourceInstances[player]); i++) {
            
            var detachFromUiPos = o_zoom_manager.convertToWorldSpace({ x: resourceInstances[player][i].x, y: resourceInstances[player][i].y })
            
            var initData = {
                origin: { x: detachFromUiPos.x, y: detachFromUiPos.y },
                target: { x: consumer.x, y: consumer.y },
                timePassed: 0,
                duration: one_second,
                sprite_index : resourceInstances[player][i].sprite_index,
                depth: -10,
                image_xscale: o_zoom_manager.getZoomScale(),
                image_yscale: o_zoom_manager.getZoomScale()
            }
            
            var sendToConsumerInstance = instance_create_layer(detachFromUiPos.x, detachFromUiPos.y, "Air", o_world_resource_instance, initData)

            instance_destroy(resourceInstances[player][i])
        }
        
        resources[player] = [0, 0, 0]
        resourceInstances[player] = []
        currentResourceCount = 0
        consumer.overproductionTriggered()
    }
    
    var row = currentResourceCount div storageRowSize
    var column = currentResourceCount mod storageRowSize
    
    var targetX = resourceAreaResourceStartX + column * resourceInstance.sprite_width
    var targetY = resourceAreaResourceStartY + row * resourceInstance.sprite_height

    with (resourceInstance) {
        origin = { x: resourceInstance.x, y: resourceInstance.y }
        target = { x: targetX, y: targetY }
        timePassed = 0
        duration = one_second
    }
    
    array_push(resourceInstances[player], resourceInstance)
}