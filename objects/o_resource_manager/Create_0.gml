// This resource manager is responsible for managing prodouced resources during the battle phase

enum Resource
{
    LUMBER,
    HONEY,
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
generateResource = function(type, amount, productionSource) {
    player = productionSource.player
    
    resources[player][type] += 1
    var currentResourceCount = array_length(resourceInstances[player])
    
    #region Overproduction trigger
    if (currentResourceCount == storageSize) {
        // City have over produced, good job city
        
        var consumer = o_influence_grid_manager.getBuildingThatAcceptsOverProduction(player) // TODO handle if there is no consumer

        if (player == Player.US) {
            // animate goods going to consumer
            for (var i = 0; i < array_length(resourceInstances[player]); i++) {
                var detachFromUiPos = o_zoom_manager.convertToWorldSpace({ x: resourceInstances[player][i].x, y: resourceInstances[player][i].y })
                
                var initData = {
                    origin: { x: detachFromUiPos.x, y: detachFromUiPos.y },
                    target: { x: consumer.x, y: consumer.y },
                    timePassed: 0,
                    duration: one_second,
                    sprite_index : resourceInstances[player][i].sprite_index,
                    image_xscale: o_zoom_manager.getZoomScale(),
                    image_yscale: o_zoom_manager.getZoomScale(),
                    originPositionType: OriginPositionType.GUI
                }
                
                var sendToConsumerInstance = instance_create_layer(detachFromUiPos.x, detachFromUiPos.y, "Ground", o_world_resource_instance, initData)
                instance_destroy(resourceInstances[player][i])
            } 
        } else {
            // do nothing for enemy resource instances, the instances are destroyed by themselves when they have finished animating
        }
        
        
        resources[player] = [0, 0, 0]
        resourceInstances[player] = []
        currentResourceCount = 0
        consumer.overproductionTriggered()
    }
    #endregion
    
    var row = currentResourceCount div storageRowSize
    var column = currentResourceCount mod storageRowSize
    
    // get original size of sprite, since this sprite is being scaled as part of anim
    var targetX = resourceAreaResourceStartX + column * guiResourceSize
    var targetY = resourceAreaResourceStartY + row * guiResourceSize


    var resourceInstance
    var initData = { 
        sprite_index: productionSource.childResourceSprite,
        timePassed: 0,
        duration: one_second
    }
    
    if (player == Player.US) {
        // then animate the resource to the ui
        
        // When transitioning from world layer to gui, the world detach point should be converted to iso; the gui instances are not projected
        // This is similar to what is required for world_resource but in reverse.
        // so we actually set the actual position of the instance here to be in iso space :/ 
        var isoSpace = roomToIso(productionSource.x, productionSource.y)
        var posInUiSpaceToGenerateResource = o_zoom_manager.convertToGuiSpace(isoSpace.x, isoSpace.y) 
        
        with (initData) {
            origin = { x: posInUiSpaceToGenerateResource.x, y: posInUiSpaceToGenerateResource.y }
            target = { x: targetX, y: targetY }
            originPositionType = OriginPositionType.WORLD
        }
        
        resourceInstance = instance_create_layer(posInUiSpaceToGenerateResource.x, posInUiSpaceToGenerateResource.y, "GuiAir", o_gui_resource_instance, initData)
    } else {
        // do a bubble anim over the enemy structure
        with(initData) {
            origin = { x: productionSource.x, y: productionSource.y }
            target = projectionIndependentGuiUp({ x: productionSource.x, y: productionSource.y}, 20)
        }
        resourceInstance = instance_create_layer(initData.origin.x, initData.origin.y, "Ground", o_world_resource_instance, initData) 
    }
    
    
    array_push(resourceInstances[player], resourceInstance)
}

goToBuild = function(){
    if (!o_game_phase_manager.isBattlePhase()) {
        resources = [[0, 0, 0], [0, 0, 0]]
        var player = 0
        var enemy = 1
        for (var i = 0; i < array_length(resourceInstances[player]); i++) {
            instance_destroy(resourceInstances[player][i])
        }
        
        for (var i = 0; i < array_length(resourceInstances[enemy]); i++) {
            instance_destroy(resourceInstances[enemy][i])
        }
        resourceInstances = [[],[]]
    } 
}