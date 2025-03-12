if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

if (current_frame == interval) {
    current_frame = 0; 
    if (player == Player.US) {
        onAbilityActivationPlayer()
    } else {
        onAbilityActivationEnemy()
    }

} else {
    current_frame += 1;
}
