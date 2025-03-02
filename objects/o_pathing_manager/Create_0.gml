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
motionPlanToTarget = function(path, startX, startY, targetX, targetY) {
    mp_grid_path(
        navigableSeasGrid, 
        path, 
        startX, startY, 
        targetX, targetY, 
        true
    )
    
}
