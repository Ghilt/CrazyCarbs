enum GameState {
    BUILD,
    BATTLE,
    SHOP
}

state = GameState.BUILD



function isBuildPhase() {
    return state == GameState.BUILD
}

function goToBattleState() {
    state = GameState.BATTLE
    
}