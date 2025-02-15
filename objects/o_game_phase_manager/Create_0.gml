enum GameState {
    BUILD,
    BATTLE,
    SHOP
}

state = GameState.BUILD



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
}