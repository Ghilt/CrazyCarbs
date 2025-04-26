o_gui_manager.uiScooch(id)
if (o_game_phase_manager.isBattlePhase()) {

    var currentStability = o_stability_manager.getCurrentStability(player)
    var maxStability = o_stability_manager.getMaxStability(player)
    
    image_yscale = lerp(image_yscale, currentStability / maxStability, 0.2)
}


