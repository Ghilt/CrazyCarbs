path_delete(path)
path = path_add()

mp_grid_path(
    o_pathing_manager.navigableSeasGrid,
    path, 
    x, y, targetPos.x, targetPos.y,
    true
)

path_start(path, 10, path_action_stop, true)

alarm[0] = 10