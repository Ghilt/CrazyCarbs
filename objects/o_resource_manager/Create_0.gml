// This resource manager is responsible for managing prodouced resources during the battle phase

var resourceArea = object_get_sprite(o_gui_resource_area)
var resourceAreaWidth = sprite_get_width(resourceArea)

instance_create_layer(guiXMid - resourceAreaWidth / 2, -sprite_get_height(resourceArea), "Gui", o_gui_resource_area)

resourceAreaResourceStartX = guiXMid - resourceAreaWidth / 2 + 64
resourceAreaResourceStartY = 8
storageSize = 45
storageRowSize = 15

resources = [new ResourceStore(), new ResourceStore()]


generateResource = function(type, amount, productionSource) {
    var player = productionSource.player
    
    var currentResourceCount = resources[player].getResourceCount()
    
    #region Overproduction trigger
    if (currentResourceCount == storageSize) {
        // City have over produced, good job city
        
        var consumer = o_influence_grid_manager.getBuildingThatAcceptsOverProduction(player) // TODO handle if there is no consumer

        if (player == Player.US) {
            // animate goods going to consumer
            
            resources[player].useEveryResource(method({ consumer }, function(instance) {
                var detachFromUiPos = o_zoom_manager.convertToWorldSpace({ x: instance.x, y: instance.y })
                
                var initData = {
                    origin: { x: detachFromUiPos.x, y: detachFromUiPos.y },
                    target: { x: consumer.x, y: consumer.y },
                    timePassed: 0,
                    duration: one_second,
                    sprite_index : instance.sprite_index,
                    image_xscale: o_zoom_manager.getZoomScale(),
                    image_yscale: o_zoom_manager.getZoomScale(),
                    originPositionType: OriginPositionType.GUI
                }
                
                var sendToConsumerInstance = instance_create_layer(detachFromUiPos.x, detachFromUiPos.y, "Ground", o_world_resource_instance, initData)
            }))
        } else {
            resources[player].useEveryResource(function(){ })
            // do nothing for enemy resource instances, the instances are destroyed by themselves when they have finished animating
        }
        
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
        sprite_index: global.resourceTypes[? type].sprite,
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
        resources[player].addResource(type, resourceInstance)
    } else {
        // do a bubble anim over the enemy structure
        with(initData) {
            origin = { x: productionSource.x, y: productionSource.y }
            target = projectionIndependentGuiUp({ x: productionSource.x, y: productionSource.y }, 20)
        }
        resourceInstance = instance_create_layer(initData.origin.x, initData.origin.y, "Ground", o_world_resource_instance, initData)
        resources[player].addResource(type, false)
    }
    
    
}

goToBuild = function(){
    if (!o_game_phase_manager.isBattlePhase()) {
        resources[Player.US].clear()
        resources[Player.THEM].clear()
    } 
}


// cost = [{type, amount}]
resourcesExist = function(player, cost) {
    // TODO tier system
    return resources[player].hasResources(cost)
}

compactifyResourceInstances = function() {

    resources[Player.US].forEeachResourceInCreationOrder(function(resourceStruct, index) {
        var row = index div o_resource_manager.storageRowSize
        var column = index mod o_resource_manager.storageRowSize
        var targetX = o_resource_manager.resourceAreaResourceStartX + column * guiResourceSize
        var targetY = o_resource_manager.resourceAreaResourceStartY + row * guiResourceSize
        
         //this is janky
        if (resourceStruct.instance.timePassed == resourceStruct.instance.duration) {
            // resource is at rest. Give it a new origin and a new target
            resourceStruct.instance.animateScale = false
            resourceStruct.instance.origin.x = resourceStruct.instance.target.x 
            resourceStruct.instance.origin.y = resourceStruct.instance.target.y
            resourceStruct.instance.timePassed = 0
            resourceStruct.instance.target.x = targetX
            resourceStruct.instance.target.y = targetY    
        } else {
            // resource is in motion, just change its target
            resourceStruct.instance.target.x = targetX
            resourceStruct.instance.target.y = targetY
        } 

    })
}

instanceUseResources = function(buildingInstance, cost) {
    if (buildingInstance.player == Player.US) {
        // animate goods going to instance; temp
        
        resources[buildingInstance.player].useResources(cost, method({ buildingInstance }, function(resourceInstance) {
            var detachFromUiPos = o_zoom_manager.convertToWorldSpace({ x: resourceInstance.x, y: resourceInstance.y })
            
            var initData = {
                origin: { x: detachFromUiPos.x, y: detachFromUiPos.y },
                target: { x: buildingInstance.x, y: buildingInstance.y },
                timePassed: 0,
                duration: one_second,
                sprite_index : resourceInstance.sprite_index,
                image_xscale: o_zoom_manager.getZoomScale(),
                image_yscale: o_zoom_manager.getZoomScale(),
                originPositionType: OriginPositionType.GUI
            }
            
            var sendToConsumerInstance = instance_create_layer(detachFromUiPos.x, detachFromUiPos.y, "Ground", o_world_resource_instance, initData)
        }))
        
        o_resource_manager.compactifyResourceInstances()
    } else {
        resources[buildingInstance.player].useResources(cost, function(){ })
        // do nothing for enemy resource instances, the instances are destroyed by themselves when they have finished animating
    }
}
