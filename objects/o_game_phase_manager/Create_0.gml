enum GameState {
    BUILD,
    BATTLE,
    SHOP
}

state = GameState.BUILD



function isBuildPhase() {
    return state == GameState.BUILD
}

function isBattlePhase() {
    return state == GameState.BATTLE
}

function goToBattleState() {
    state = GameState.BATTLE
    
}