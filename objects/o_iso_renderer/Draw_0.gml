var tileData, roomX, roomY, tileIndex, tileZ


for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++)  {
        tileData = global.terrainMap[# tX, tY]   
        roomX = tileData.roomX
        roomY = tileData.roomY
        tileIndex = tileData.spriteIndex
        tileZ = tileData.z
        
        // nukes performance a bit
        //if (roomToTileX(mouse_x, mouse_y) == tX && roomToTileY(mouse_x, mouse_y) == tY) {
            //tileZ -= 100
        //}  


        if (tileIndex != 0) {
            draw_sprite(s_iso_terrain, tileIndex - 1, roomX, roomY + tileZ)
        }
    }
}
