/// desc Build the map

layer_set_visible("Tiles_map", false)

global.terrainMap = ds_grid_create(MAP_W, MAP_H)

var tileMap = layer_tilemap_get_id("Tiles_map")

for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++) {
        var tileMapData = tilemap_get(tileMap, tX, tY)
        tileMapData = tile_get_index(tileMapData) // This is step not necessary if the tile map doesnt utilize mirrored or rotated tiles and stuff like that
        // Format [Sprite, Z]
        var thisTile = { 
            spriteIndex: tileMapData, 
            z: irandom(10),
            roomX: tileToRoomX(tX, tY),
            roomY: tileToRoomY(tX, tY)
             
        }
        global.terrainMap[# tX, tY] = thisTile //# is a short hand accessor thing for ds grids, syntax sugar
    }
}