path_delete(path)
path = path_add()

o_pathing_manager.motionPlanToTarget(path, x, y, targetPos.x, targetPos.y)

path_start(path, 5, path_action_stop, true)

alarm[0] = 10