o_gui_manager.uiScooch(id)
image_yscale = lerp(image_yscale, o_stability_manager.stability / o_stability_manager.maxStability, 0.2)

if (o_stability_manager.stability < 0) {
    o_game_phase_manager.goToBuild()
}