path_delete(path)
path = path_add()

o_pathing_manager.motionPlanPathToIsometricSpace(path, x, y, target_x, target_y)

path_start(path, 5, path_action_stop, true)

alarm[0] = 10