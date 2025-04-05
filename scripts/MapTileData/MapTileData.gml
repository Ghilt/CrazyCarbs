function MapTileData(_x, _y, _mapTerrain, _z = 0) constructor {
    pos = {
        x: _x,
        y: _y
    };
    mapTerrain = _mapTerrain;
    z = _z;
    mapped = gameSetup_tileToIso(_x, _y);
}
