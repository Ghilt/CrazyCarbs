
function uiScooch(instance) {
    // Gui manager requires that all utilizing instances store their own different positions
    switch (o_game_phase_manager.state) {
    
        case GameState.BATTLE:
            instance.x = lerp(instance.x, instance.battlePos.x, 0.2)
            instance.y = lerp(instance.y, instance.battlePos.y, 0.2)
        break;
        case GameState.SHOP:
        case GameState.BUILD:
            instance.x = lerp(instance.x, instance.buildPos.x, 0.2)
            instance.y = lerp(instance.y, instance.buildPos.y, 0.2)
        break;
    }
    
}