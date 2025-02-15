debugGrid = true
buildingSize = 64

initialInfluenceGrid = function(){
    var grid = [
    { x : -2, y : -2 },
    { x : -1, y : -2 },
    { x : -1, y : -1 },
    { x : -1, y : 0 },
    { x : 1, y : 0 },
    { x : 0, y : 0 },
    { x : 0, y : 1 },
    { x : 1, y : 1 },
    { x : 2, y : 2 },
    { x : -6, y : 6 }
    ]
    
    var _convert = function (_element, _index)
    {
        return { 
            rX: _element.x, 
            rY: _element.y, 
            x: x + _element.x * buildingSize, 
            y: y + _element.y * buildingSize, 
            occupiedBy: false
        }
    }
    
    return array_map(grid, _convert)
}

// represents where structures of your city state can be built
influenceGrid = initialInfluenceGrid()

updateInfluenceGrid = function(newGrid) {
    influenceGrid = newGrid
}

getBuildingThatAcceptsOverProduction = function() {
    for (var i = 0; i < array_length(influenceGrid); i++) {
        
        if (!influenceGrid[i].occupiedBy) {
            continue;
        }
        
        if (variable_instance_exists(influenceGrid[i].occupiedBy, "acceptsOverproduction") && influenceGrid[i].occupiedBy.acceptsOverproduction) {
            return influenceGrid[i].occupiedBy
        }
    }
    return false
}


getClosestBuildableSpot = function(pX, pY) {
    var bestDistance = 2147483647
    var bestX = 0
    var bestY = 0
    
    for (var i = 0; i < array_length(influenceGrid); i++) {
        
        if (influenceGrid[i].occupiedBy) {
            continue;
        }
        
        var distance = point_distance(pX, pY, influenceGrid[i].x, influenceGrid[i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGrid[i].x
            bestY = influenceGrid[i].y
        }

    }
    
    return { distance: bestDistance, x: bestX, y: bestY }
}


// Type is a type defined in ItemScripts.Building
buildAt = function(pos, type) { 
    
    with { influenceGrid, pos } // https://yal.cc/gamemaker-diy-closures/
        
    var loc = influenceGrid[
        array_find_index(influenceGrid, function(_element, _index)
           {
               return (_element.x == pos.x && _element.y == pos.y);
           }
        )
    ]
    var newBuilding = instance_create_layer(loc.x, loc.y, "Ground", ds_map_find_value(global.buildings, type).building)
    
    loc.occupiedBy = newBuilding

}

for (var i = 0; i < array_length(influenceGrid); i++) { 
    if (influenceGrid[i].rX == 0 && influenceGrid[i].rY == 0) {
        var starintPortLocation = { x: influenceGrid[i].x, y : influenceGrid[i].y }
        buildAt(starintPortLocation, Building.STARTING_PORT)
    } 
}

