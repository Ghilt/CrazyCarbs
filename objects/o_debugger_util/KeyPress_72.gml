if (o_game_phase_manager.isBuildPhase()) {
    o_shop_manager.rerollShop()
} else {
    with (o_unit) {
        if (stats.speed == 12) {
            stats.speed = 1  
        } else { 
            stats.speed = 12
        }
        
    }
}