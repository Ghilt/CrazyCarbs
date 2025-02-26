path_delete(path)
path = path_add()

mp_grid_path(o_pathing_manager.navigableSeasGrid, path, x, y, target_x, target_y, true)

path_start(path, 5, path_action_stop, true)

alarm[0] = 10