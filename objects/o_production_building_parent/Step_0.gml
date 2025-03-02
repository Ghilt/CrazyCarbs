if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

if (current_frame == interval) {
    current_frame = 0; 
    if (player == Player.US) {
        // generate resource in ui layer
        //var posInUiSpaceToGenerateResource = o_zoom_manager.convertToGuiSpace(x, y) 
        var initData = { sprite_index: childResourceSprite }
        // TODO probably move this instance creation to the manager. Why = the manager already is responsible for creating its init struct.
        //var resourceInstance = instance_create_layer(posInUiSpaceToGenerateResource.x, posInUiSpaceToGenerateResource.y, "GuiAir", o_gui_resource_instance, initData) 
        //o_resource_manager.generateResource(childResource, childProductionRate, resourceInstance, Player.US)
        o_resource_manager.generateResource(childResource, childProductionRate, id)
    } else {
        // generate resource in world layer
        var initData = { 
            sprite_index: childResourceSprite 
        }

        //var resourceInstance = instance_create_layer(x, y, "Ground", o_world_resource_instance, initData) 
        //o_resource_manager.generateResource(childResource, childProductionRate, resourceInstance, Player.THEM)
        o_resource_manager.generateResource(childResource, childProductionRate, id)
    }

} else {
    current_frame += 1;
}
