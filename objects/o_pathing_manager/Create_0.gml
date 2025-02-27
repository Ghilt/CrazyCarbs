gridWidth = MAP_W
gridHeight = MAP_H
gridCellWidth = room_width / gridWidth
gridCellHeight = room_height / gridHeight


// make the collision grid twice as large as the isoGrid. 
navigableSeasGrid = mp_grid_create(0, 0, gridWidth, gridHeight, gridCellWidth, gridCellHeight)

var tileMap = layer_tilemap_get_id("Tiles_map")

for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++) {
        var tileMapData = tilemap_get(tileMap, tX, tY)
        tileMapData = tile_get_index(tileMapData)

        if (tileMapData != 3) {
            mp_grid_add_cell(navigableSeasGrid, tX, tY)
        }
    }
}

// non iso cooridnates, real world coordinates
motionPlanPathToIsometricSpace = function(path, startX, startY, targetX, targetY) {
    // TODO fix after isometric projection rework
    //var startPosProjectedToMpGridSpace = { x: startX / gridCellWidth, y: startY / gridCellHeight }
    //var targetPosProjectedToMpGridSpace = { x: targetX / gridCellWidth, y: targetY / gridCellHeight }
    
    //var startPosProjectedToMpGridSpace = { x: roomToTileX(startX, startY) * gridCellWidth, y: roomToTileY(startX, startY) * gridCellHeight}
    //var targetPosProjectedToMpGridSpace = { x: roomToTileX(targetX, targetY) * gridCellWidth, y: roomToTileY(targetX, targetY) * gridCellHeight}
    //
    //mp_grid_path(
        //navigableSeasGrid, 
        //path, 
        //startPosProjectedToMpGridSpace.x, startPosProjectedToMpGridSpace.y, 
        //targetPosProjectedToMpGridSpace.x, targetPosProjectedToMpGridSpace.y, 
        //true
    //)
    //
    //for (var i = 0; i < path_get_number(path); i++) {
        //var pathPoint = { x: path_get_point_x(path, i), y: path_get_point_y(path, i)  }
        //var newX = tileToRoomX(pathPoint.x / gridCellWidth, pathPoint.y / gridCellHeight)
        //var newY = tileToRoomY(pathPoint.x / gridCellWidth, pathPoint.y / gridCellHeight)
        //
        //path_change_point(path, i, newX, newY, 9)
    //}
    //
    //
}
