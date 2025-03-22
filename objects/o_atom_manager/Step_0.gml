if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

var arrayLength = array_length(stepAtoms)
for (var i = 0; i < arrayLength; i++) {
    stepAtoms[i].step()
}

runPayoffTriggers(Player.US)
runPayoffTriggers(Player.THEM)
