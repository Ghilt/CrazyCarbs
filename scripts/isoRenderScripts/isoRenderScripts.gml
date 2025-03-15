
enum OriginPositionType
{
    GUI,
    WORLD
};

// https://yal.cc/understanding-isometric-grids/
// from 0 to MAP_W, 0 to MAP_H
function tileToIso(tileX, tileY) {
    var roomX = tileX * TILE_SIZE
    var roomY = tileY * TILE_SIZE
    if (!o_debugger_util.isoProjection) {
        return { x: roomX, y: roomY }
    }
    
    return {
        x: ISO_ORIGIN.x + (roomX - roomY) * ISO_W,
        y: ISO_ORIGIN.y + (roomX + roomY) * ISO_H
    }
}

function roomToIso(_rX, _rY) {
    var roomX = _rX
    var roomY = _rY
    if (!o_debugger_util.isoProjection) {
        return { x: _rX, y: _rY }
    }
    
    return {
        x: ISO_ORIGIN.x + (roomX - roomY) * ISO_W,
        y: ISO_ORIGIN.y + (roomX + roomY) * ISO_H
    }
}

function isoToRoom(_rX, _rY) {
    var roomX = _rX
    var roomY = _rY
    if (!o_debugger_util.isoProjection) {
        return { x: _rX, y: _rY }
    }
    
    return {
        x: ((roomY - ISO_ORIGIN.y) / ISO_H + (roomX - ISO_ORIGIN.x) / ISO_W) / 2,
        y: ((roomY - ISO_ORIGIN.y) / ISO_H - (roomX - ISO_ORIGIN.x) / ISO_W) / 2
    }
}

// This is needed when setting up the map. o_debugger_util is not initiated when we set up the terrain before the game started
function gameSetup_tileToIso(tileX, tileY) {
    var roomX = tileX * TILE_SIZE
    var roomY = tileY * TILE_SIZE

    return {
        x: ISO_ORIGIN.x + (roomX - roomY) * ISO_W,
        y: ISO_ORIGIN.y + (roomX + roomY) * ISO_H
    }
}

function debug_roomToIso(_rX, _rY) {
    var roomX = _rX
    var roomY = _rY

    return {
        x: ISO_ORIGIN.x + (roomX - roomY) * ISO_W,
        y: ISO_ORIGIN.y + (roomX + roomY) * ISO_H
    }
}

function debug_isoToRoom(_rX, _rY) {
    var roomX = _rX
    var roomY = _rY

    return {
        x: ((roomY - ISO_ORIGIN.y) / ISO_H + (roomX - ISO_ORIGIN.x) / ISO_W) / 2,
        y: ((roomY - ISO_ORIGIN.y) / ISO_H - (roomX - ISO_ORIGIN.x) / ISO_W) / 2
    }
}


