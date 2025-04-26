function MapTileData(_x, _y, _mapTerrain, _z = 0) constructor {
    pos = {
        x: _x,
        y: _y
    }
    mapTerrain = _mapTerrain
    z = _z
    mapped = gameSetup_tileToIso(_x, _y)
    
    // persistent random value which can be used to have some randomness in terrain visuals
    var rand =  irandom(100) 
    if (rand > 30) {
        weightedSubTerrainValue = 0
    } else if (rand > 20) {
        weightedSubTerrainValue = 1
    } else if (rand > 10) {
        weightedSubTerrainValue = 2
    } else {
        weightedSubTerrainValue = 3
    }
}


