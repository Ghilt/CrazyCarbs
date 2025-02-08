debugGrid = true
buildingSize = 64

influenceGrid = [
{ x : -2, y : -2 },
{ x : -1, y : -2 },
{ x : -1, y : -1 },
{ x : -1, y : 0 },
{ x : 1, y : 0 },
{ x : 0, y : 1 },
{ x : 1, y : 1 },
{ x : 2, y : 2 },
{ x : 6, y : 6 }
]


influenceGridAbs = getInfluenceGridRealPositions()

function getInfluenceGridRealPositions() {
    var _convert = function (_element, _index)
    {
        return { x: x + _element.x * buildingSize, y: y + _element.y * buildingSize}
    }
    return array_map(influenceGrid, _convert)
}

function getClosestBuildableSpot(pX, pY) {
    var bestDistance = 2147483647
    var bestX = 0
    var bestY = 0
    
    for (var i = 0; i < array_length(influenceGrid); i++) {
        
        var distance = point_distance(pX, pY, influenceGridAbs[i].x, influenceGridAbs[i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGridAbs[i].x
            bestY = influenceGridAbs[i].y
        }

    }
    
    // show_debug_message("best distance : " + string(bestDistance))
    
    return {distance: bestDistance, x: bestX, y: bestY}
}