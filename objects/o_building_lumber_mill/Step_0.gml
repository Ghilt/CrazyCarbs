if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

//step
if (current_frame == interval) {
  current_frame = 0;
  
    var posInUiSpaceToGenerateResource = o_zoom_manager.convertToGuiSpace(x, y)
  var lumber = instance_create_layer(posInUiSpaceToGenerateResource.x, posInUiSpaceToGenerateResource.y, "Gui", o_resource_instance)  
  lumber.sprite_index = s_resource_lumber
  o_resource_manager.generateResource(Resource.LUMBER, 1, lumber)
} else {
    current_frame += 1;
}
