if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

//This allows for children to either have their cooldown as a simple variable or a function

// Interesting GMS legacy note: is_callable(...) returns true if testing a number
var childDefinedCooldown = is_method(stats.cooldown) ? stats.cooldown() : stats.cooldown
var buffDebuffedCooldown = o_buff_debuff_manager.getProsperityAndFaminModifiedCooldown(childDefinedCooldown, player)
if (current_frame == childDefinedCooldown) {
    current_frame = 0; 
    if (player == Player.US) {
        onAbilityActivationPlayer()
    } else {
        onAbilityActivationEnemy()
    }

} else {
    current_frame += 1;
}
