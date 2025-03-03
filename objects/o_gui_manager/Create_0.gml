curve = animcurve_get_channel(c_movement, "fast_slow")


uiScooch = function(instance) {
    // Gui manager requires that all utilizing instances store their own different positions
    switch (o_game_phase_manager.state) {
    
        case GameState.BATTLE:
            if (!variable_instance_exists(instance, "guiState")) {
                //The ui component does not support auto moving if it has no mov struct
                return;
            }
        
            if (instance.guiState.mov.timePassed == instance.guiState.mov.duration){
                // Movement finished
                instance.guiState.mov.timePassed = 0 
                instance.guiState.mov.originX = instance.guiState.battlePos.x
                instance.guiState.mov.originY = instance.guiState.battlePos.y
        
            } else if (instance.guiState.battlePos.x == instance.x && instance.guiState.battlePos.y == instance.y) {
                // Lie at rest little ui component
                return;    
            } else {
                instance.guiState.mov.timePassed += 1
                var interpolation = instance.guiState.mov.timePassed / instance.guiState.mov.duration 
                
                var position = animcurve_channel_evaluate(curve, interpolation)
                
                instance.x = lerp(instance.guiState.mov.originX, instance.guiState.battlePos.x, position)
                instance.y = lerp(instance.guiState.mov.originY, instance.guiState.battlePos.y, position)
            }
        break;
        case GameState.BUILD:
            if (!variable_instance_exists(instance, "guiState")) {
                //The ui component does not support auto moving if it has no mov struct
                return;
            }
            
            if (instance.guiState.mov.timePassed == instance.guiState.mov.duration){
                // Movement finished
                instance.guiState.mov.timePassed = 0 
                instance.guiState.mov.originX = instance.guiState.buildPos.x
                instance.guiState.mov.originY = instance.guiState.buildPos.y
                
            } else if (instance.guiState.buildPos.x == instance.x && instance.guiState.buildPos.y == instance.y) {
                // Lie at rest little ui component
                return;
            } else {
                instance.guiState.mov.timePassed += 1
                var interpolation = instance.guiState.mov.timePassed / instance.guiState.mov.duration 
                
                var position = animcurve_channel_evaluate(curve, interpolation)
                instance.x = lerp(instance.guiState.mov.originX, instance.guiState.buildPos.x, position)
                instance.y = lerp(instance.guiState.mov.originY, instance.guiState.buildPos.y, position)
            }
        
        break;
    }
    
}