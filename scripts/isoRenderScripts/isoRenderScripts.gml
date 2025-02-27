
// https://yal.cc/understanding-isometric-grids/
// from 0 to MAP_W, 0 to MAP_H
function tileToIso(tileX, tileY) {
    var roomX = tileX * tileSize
    var roomY = tileY * tileSize
    if (!o_debugger_util.isoProjection) {
        return {x: roomX, y: roomY}
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
        return {x: _rX, y: _rY}
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
        return {x: _rX, y: _rY}
    }
    
    return {
        x: ((roomY - ISO_ORIGIN.y) / ISO_H + (roomX - ISO_ORIGIN.x) / ISO_W) / 2,
        y: ((roomY - ISO_ORIGIN.y) / ISO_H - (roomX - ISO_ORIGIN.x) / ISO_W) / 2
    }
}


