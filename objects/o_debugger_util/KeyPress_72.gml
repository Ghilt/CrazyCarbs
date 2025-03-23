if (o_game_phase_manager.isBuildPhase()) {
    o_shop_manager.rerollShop()
} else {
    if (global.shipBaseSpeed == 0.2) {
        global.shipBaseSpeed = 0.01  
    } else { 
        global.shipBaseSpeed = 0.2
    }
        
}