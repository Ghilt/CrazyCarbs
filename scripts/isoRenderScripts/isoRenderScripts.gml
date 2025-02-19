global.isoRenderingOffsetX = (CAMERA_W * 2.75)
global.isoRenderingOffsetY = (CAMERA_W * 0.25)

function tileToRoomX(_tX, _tY) {
    return (_tX - _tY) * TILE_W * 0.5 + global.isoRenderingOffsetX
}

function tileToRoomY(_tX, _tY) {
    return (_tX + _tY) * TILE_H * 0.5 + global.isoRenderingOffsetY
}

function roomToTileX(_rX, _rY) {
    var roomX = _rX - global.isoRenderingOffsetX
    var roomY = _rY - global.isoRenderingOffsetY
    return floor(roomX / TILE_W + roomY / TILE_H)
}

function roomToTileY(_rX, _rY) {
    var roomX = _rX - global.isoRenderingOffsetX
    var roomY = _rY - global.isoRenderingOffsetY
    return floor(roomY / TILE_H - roomX / TILE_W)
}
