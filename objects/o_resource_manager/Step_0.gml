if (!o_game_phase_manager.isBattlePhase()) {
    resources = [0, 0, 0]
    for (var i = 0; i < array_length(resourceInstances); i++) {
        instance_destroy(resourceInstances[i])
    }
    resourceInstances = []
}