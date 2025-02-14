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

goToBattleState = function() {
    state = GameState.BATTLE
    
}