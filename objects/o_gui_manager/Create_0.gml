curve = animcurve_get_channel(c_movement, "fast_slow")


uiScooch = function(instance) {
    // Gui manager requires that all utilizing instances store their own different positions
    switch (o_game_phase_manager.state) {
    
        case GameState.BATTLE:
            if (!variable_instance_exists(instance, "mov")) {
                //The ui component does not support auto moving if it has no mov struct
                return;
            }
        
            if (instance.mov.timePassed == instance.mov.duration){
                // Movement finished
                instance.mov.timePassed = 0 
                instance.mov.originX = instance.battlePos.x
                instance.mov.originY = instance.battlePos.y
        
            } else if (instance.battlePos.x == instance.x && instance.battlePos.y == instance.y) {
                // Lie at rest little ui component
                return;    
            } else {
                instance.mov.timePassed += 1
                var interpolation = instance.mov.timePassed / instance.mov.duration 
                
                var position = animcurve_channel_evaluate(curve, interpolation)
                
                instance.x = lerp(instance.mov.originX, instance.battlePos.x, position)
                instance.y = lerp(instance.mov.originY, instance.battlePos.y, position)
            }
        break;
        case GameState.SHOP:
        case GameState.BUILD:
            if (!variable_instance_exists(instance, "mov")) {
                //The ui component does not support auto moving if it has no mov struct
                return;
            }
            
            if (instance.mov.timePassed == instance.mov.duration){
                // Movement finished
                instance.mov.timePassed = 0 
                instance.mov.originX = instance.buildPos.x
                instance.mov.originY = instance.buildPos.y
                
            } else if (instance.buildPos.x == instance.x && instance.buildPos.y == instance.y) {
                // Lie at rest little ui component
                return;
            } else {
                instance.mov.timePassed += 1
                var interpolation = instance.mov.timePassed / instance.mov.duration 
                
                var position = animcurve_channel_evaluate(curve, interpolation)
                instance.x = lerp(instance.mov.originX, instance.buildPos.x, position)
                instance.y = lerp(instance.mov.originY, instance.buildPos.y, position)
            }
        
        break;
    }
    
}