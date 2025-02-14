if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

if (current_frame == interval) {
    current_frame = 0; 
    var posInUiSpaceToGenerateResource = o_zoom_manager.convertToGuiSpace(x, y) 
    var resourceInstance = instance_create_layer(posInUiSpaceToGenerateResource.x, posInUiSpaceToGenerateResource.y, "Gui", o_resource_instance)  
    resourceInstance.sprite_index = childResourceSprite
    o_resource_manager.generateResource(childResource, childProductionRate, resourceInstance)
} else {
    current_frame += 1;
}
