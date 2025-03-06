if (!o_game_phase_manager.isBattlePhase()) {
    alarm[0] = 30
    
    return;
}

path_delete(path)
path = path_add()

o_pathing_manager.motionPlanToTarget(path, id)


path_start(path, 5, path_action_stop, true)

alarm[0] = 15