debugGrid = true
buildingSize = 64

influenceGrid = initialInfluenceGrid()


function initialInfluenceGrid(){
    var grid = [
    { x : -2, y : -2 },
    { x : -1, y : -2 },
    { x : -1, y : -1 },
    { x : -1, y : 0 },
    { x : 1, y : 0 },
    { x : 0, y : 1 },
    { x : 1, y : 1 },
    { x : 2, y : 2 },
    { x : -6, y : 6 }
    ]
    
    var _convert = function (_element, _index)
    {
        return { rX: x, rY: y, x: x + _element.x * buildingSize, y: y + _element.y * buildingSize}
    }
    
    return array_map(grid, _convert)
}

function updateInfluenceGrid(newGrid) {
    influenceGrid = newGrid
}


function getClosestBuildableSpot(pX, pY) {
    var bestDistance = 2147483647
    var bestX = 0
    var bestY = 0
    
    for (var i = 0; i < array_length(influenceGrid); i++) {
        
        var distance = point_distance(pX, pY, influenceGrid[i].x, influenceGrid[i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGrid[i].x
            bestY = influenceGrid[i].y
        }

    }
    
    return { distance: bestDistance, x: bestX, y: bestY }
}

function buildAt(pos) { 
    
    with { influenceGrid, pos } // https://yal.cc/gamemaker-diy-closures/
        
    var loc = influenceGrid[
        array_find_index(influenceGrid, function(_element, _index)
           {
               return (_element.x == pos.x && _element.y == pos.y);
           }
        )
    ]
    var newBuilding = instance_create_layer(loc.x, loc.y, "Instances", o_building_parent)
    
    loc.occupiedBy = newBuilding
    
    ppp("Built at", pos)

}