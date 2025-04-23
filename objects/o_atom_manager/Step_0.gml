if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

var arrayLength = array_length(stepAtoms)
for (var i = 0; i < arrayLength; i++) {
    // Instances become inactive when in the ui layer, this checks for that
    if (instance_exists(stepAtoms[i].instance)) {
        stepAtoms[i].step()
    }
}

runPayoffTriggers(Player.US)
runPayoffTriggers(Player.THEM)
