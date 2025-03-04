var progressButton = object_get_sprite(o_gui_progress_era_button)
instance_create_layer(guiWidth - sprite_get_width(progressButton) / 2, guiYBot - sprite_get_height(progressButton) / 2, "Gui", o_gui_progress_era_button)

enum GameState {
    BUILD,
    BATTLE
}

state = GameState.BUILD
gameRound = 0



isBuildPhase = function() {
    return state == GameState.BUILD
}

isBattlePhase = function() {
    return state == GameState.BATTLE
}

goToBattle = function() {
    state = GameState.BATTLE
    o_stability_manager.goToBattle()
}

goToBuild = function() {
    state = GameState.BUILD
    gameRound +=1
    o_shop_manager.goToNextRound()
    o_resource_manager.goToBuild()
    o_influence_grid_manager.resetAfterBattle()
}

goToEndOfRoundScreen = function(victory) {
    goToBuild()
    
    var roundEndScreen = instance_create_layer(guiXMid, guiYMid, "Gui", o_gui_round_end_message, { victory: victory })
    roundEndScreen.depth = -1000
    roundEndScreen.image_xscale = 20
    roundEndScreen.image_yscale = 10
    
}

