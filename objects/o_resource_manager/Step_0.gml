if (!o_game_phase_manager.isBattlePhase()) {
    resources = [[0, 0, 0], [0, 0, 0]]
    var player = 0
    var enemy = 1
    for (var i = 0; i < array_length(resourceInstances[player]); i++) {
        instance_destroy(resourceInstances[player][i])
    }
    
    for (var i = 0; i < array_length(resourceInstances[enemy]); i++) {
        instance_destroy(resourceInstances[enemy][i])
    }
    resourceInstances = [[],[]]
}