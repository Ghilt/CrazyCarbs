if (!o_debugger_util.isoProjection) {
    return;
}

var tileData, roomX, roomY, tileIndex, tileZ


for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++)  {
        tileData = global.terrainMap[# tX, tY]
        
        if (tileData) {
            roomX = tileData.mapped.x
            roomY = tileData.mapped.y
            tileIndex = tileData.mapTerrain
            tileZ = tileData.z
            
            // nukes performance a bit
            //if (roomToTileX(mouse_x, mouse_y) == tX && roomToTileY(mouse_x, mouse_y) == tY) {
                //tileZ -= 100
            //}  
    
    
            if (tileIndex != 0) {
                
                // TEMP test terrain variety
                if (tileIndex == MapTerrain.PLAINS) {
                    draw_sprite(s_iso_terrain_plain, tileData.weightedSubTerrainValue, roomX, roomY + tileZ)
                } else if (tileIndex == MapTerrain.FOREST) {
                    draw_sprite(s_iso_terrain_forest, 0, roomX, roomY + tileZ)
                } else {
                    draw_sprite(s_iso_terrain, tileIndex, roomX, roomY + tileZ)
                }

            } 
        }
    }
}
