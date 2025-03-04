if (!o_game_phase_manager.isBattlePhase()) {
    alarm[0] = 30
    
    return;
}

var opponent = getOpponentOf(player)
target = o_influence_grid_manager.getPlayerPosition(opponent)


path_delete(path)
path = path_add()

o_pathing_manager.motionPlanToTarget(path, x, y, target.x, target.y)

path_start(path, 5, path_action_stop, true)

alarm[0] = 30