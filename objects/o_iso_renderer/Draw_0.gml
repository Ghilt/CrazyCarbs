var tileData, roomX, roomY, tileIndex, tileZ

if (o_debugger_util.showIsoMap) {
    return;
}


for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++)  {
        tileData = global.terrainMap[# tX, tY]   
        roomX = tileToRoomX(tX, tY)
        roomY = tileToRoomY(tX, tY) 
        
        tileIndex = tileData[TILE.SPRITE]
        tileZ = tileData[TILE.Z]
        
        // nukes performance
        if (roomToTileX(mouse_x, mouse_y) == tX && roomToTileY(mouse_x, mouse_y) == tY) {
            tileZ -= 100
        }  


        if (tileIndex != 0) {
            draw_sprite(s_iso_terrain, tileIndex - 1, roomX, roomY + tileZ)
        }
    }
}
