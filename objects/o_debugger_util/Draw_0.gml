
depth = -1000
if (true) {
    
    for (var i = 0; i < array_length(o_influence_grid_manager.influenceGrid[Player.US]); i++) {
        var xx = o_influence_grid_manager.influenceGrid[Player.US][i].x
        var yy = o_influence_grid_manager.influenceGrid[Player.US][i].y
        var rY = o_influence_grid_manager.influenceGrid[Player.US][i].relativeX
        var rX = o_influence_grid_manager.influenceGrid[Player.US][i].relativeY
        
        var pos = roomToIso(xx, yy)
        draw_circle(pos.x, pos.y, 5, true)
        draw_text(pos.x, pos.y, string(rX) + "," + string(rY))
    }
}