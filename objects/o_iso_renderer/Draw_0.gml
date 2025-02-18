var tileData, roomX, roomY, tileIndex, tileZ


for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++)  {
        tileData = global.terrainMap[# tX, tY]   
        roomX = tileToRoomX(tX, tY)
        roomY = tileToRoomY(tX, tY) 
        
        tileIndex = tileData[TILE.SPRITE]
        tileZ = tileData[TILE.Z]
        
        if (tileIndex != 0) {
            draw_sprite(s_iso_terrain, tileIndex - 1, roomX, roomY + tileZ)
        }
    }
}
