gridWidth = MAP_W * 1.28
gridHeight = MAP_H * 1.28// nicely divides current room size of 6400
gridCellWidth = room_width / gridWidth
gridCellHeight = room_height / gridHeight


// make the collision grid twice as large as the isoGrid. 
navigableSeasGrid = mp_grid_create(0, 0, gridWidth, gridHeight, gridCellWidth, gridCellHeight)

var tileMap = layer_tilemap_get_id("Tiles_map")

for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++) {
        var tileMapData = tilemap_get(tileMap, tX, tY)
        tileMapData = tile_get_index(tileMapData)
        var worldX = tileToRoomX(tX, tY)
        var worldY = tileToRoomY(tX, tY)
        
        var collisionGridX = gridWidth * worldX / room_width 
        var collisionGridY = gridHeight * worldY / room_height
        
        if (tileMapData != 3) {
            mp_grid_add_cell(navigableSeasGrid, collisionGridX, collisionGridY)
            mp_grid_add_cell(navigableSeasGrid, collisionGridX - 1, collisionGridY )     
            mp_grid_add_cell(navigableSeasGrid, collisionGridX, collisionGridY - 1)      
            mp_grid_add_cell(navigableSeasGrid, collisionGridX - 1, collisionGridY - 1)      
            mp_grid_add_cell(navigableSeasGrid, collisionGridX + 1, collisionGridY - 1)   
            mp_grid_add_cell(navigableSeasGrid, collisionGridX, collisionGridY - 2)
            mp_grid_add_cell(navigableSeasGrid, collisionGridX - 1, collisionGridY - 2)
            mp_grid_add_cell(navigableSeasGrid, collisionGridX + 1, collisionGridY - 2)                       
        }
    }
}
