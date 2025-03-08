if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

// only the player can lose for now
if (stability[Player.THEM] <= 0 || stability[Player.US] <= 0) {
    o_game_phase_manager.goToEndOfRoundScreen(stability[Player.THEM] == 0)
    return
}

var fatigueTick = o_game_phase_manager.battleDuration mod fatigueRate == 0
if (inFatigue() && fatigueTick) {
    takeFatigueDamage()
}