ppp("Create MapLoader. MapSize: ", MAP_W, MAP_H)
global.terrainMap = ds_grid_create(MAP_W, MAP_H)

var tileMap = layer_tilemap_get_id("Tiles_map")


// magic values here are tied to the map size and angle of the isometric/dimetric projection
outsideRenderedArea = function(tX, tY) {
    return tY - tX > 74 || tX - tY > 74 || tX + tY < 76 || tX + tY > 273
}


isTileSeaNavigable = function(mapTerrainType) {
    if (mapTerrainType == MapTerrain.SEA ||
        mapTerrainType == MapTerrain.PLAYER_SPAWN ||
        mapTerrainType == MapTerrain.ENEMY_SPAWN) {
        return true    
    } else {
        return false
    }
}

nonSeaNavigableTiles = []

playerSpawnTile = false // not loaded yet
enemySpawnTiles = []

for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++) {
        var tileMapIndex = tilemap_get(tileMap, tX, tY)
        tileMapIndex = tile_get_index(tileMapIndex) // This is step not necessary if the tile map doesnt utilize mirrored or rotated tiles and stuff like that
        
        var thisTile = { 
            pos: {x: tX, y: tY },
            spriteIndex: tileMapIndex, // This value maps onto the enum MapTerrain
            z: (irandom(20) == 1 && tileMapIndex < MapTerrain.SEA) ? (irandom(5) > 2 ? -114 : 114 ): 0,
            mapped: gameSetup_tileToIso(tX, tY)
            
        }
        
        var skipRender = outsideRenderedArea(tX, tY)
        
        if (skipRender) {
            global.terrainMap[# tX, tY] = false
        } else {
            if (!isTileSeaNavigable(tileMapIndex)) {
                array_push(nonSeaNavigableTiles, { x: tX, y: tY })    
            }
            
            if (tileMapIndex == MapTerrain.PLAYER_SPAWN) {
               playerSpawnTile = { x: tX, y: tY } 
            } else if (tileMapIndex == MapTerrain.ENEMY_SPAWN) {
                array_push(enemySpawnTiles, { x: tX, y: tY })
            }
            
            global.terrainMap[# tX, tY] = thisTile
        }
    }
}

// Tile type is an int decided by the tilemap used to create the map
// used for now to epxand building grid
// TODO data class for the mapterain info
convertTileTypeToTerrain = function(mapTile){
    var tileType = mapTile.spriteIndex
    if (tileType == MapTerrain.SEA || tileType == MapTerrain.SEA_SHALLOW) {
        return Terrain.SEA
    } else {
        return Terrain.GROUND
    }
}


// returns absolute coordinates
getPlayerPosition = function(player) {
    var posX = playerSpawnTile.x * TILE_SIZE
    var posY = playerSpawnTile.y * TILE_SIZE
    return { x: posX, y: posY }
}

getNonSeaNavigableTiles = function(){
    return nonSeaNavigableTiles    
}

