if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

if (irandom_range(0, 20) = 1) {
    stability[Player.US] -= 1
}


// only the player can lose for now
if (stability[Player.US] < 0) {
    o_game_phase_manager.goToBuild()
}