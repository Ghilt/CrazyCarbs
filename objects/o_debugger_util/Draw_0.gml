
depth = -1000
if (true) {
    
    for (var i = 0; i < array_length(o_influence_grid_manager.influenceGrid[Player.US]); i++) {
        var pos = o_influence_grid_manager.influenceGrid[Player.US][i]
        var xx = pos.x
        var yy = pos.y
        var rX = pos.relativeX
        var rY = pos.relativeY
        
        var isoPos = roomToIso(xx, yy)
        
        if (pos.terrain == Terrain.SEA) {
            draw_circle_color(isoPos.x, isoPos.y, 20, c_aqua, c_blue, false)
            draw_text(isoPos.x, isoPos.y, string(rX) + "," + string(rY))
        } else {
            draw_circle(isoPos.x, isoPos.y, 20, false)
            draw_text_color(isoPos.x, isoPos.y, string(rX) + "," + string(rY), c_black, c_black, c_black, c_black, c_white)
        }
    }
}