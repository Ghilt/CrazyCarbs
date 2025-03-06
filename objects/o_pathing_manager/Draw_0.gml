if (o_debugger_util.showNavigableSeasGrid) {
    draw_set_alpha(0.5);
    mp_grid_draw(navigableSeasGrid)
    draw_set_alpha(1);
    draw_path(paths[Player.US], 0, 0, true)
    
    for (var i = 0; i < path_get_number(paths[Player.US]); i++) {
        draw_circle(path_get_point_x(paths[Player.US], i), path_get_point_y(paths[Player.US], i), 5, false)
    }
}