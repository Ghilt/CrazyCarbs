debugGrid = true
buildingSize = 64

initialInfluenceGrid = function(player){
    // This is all very temp
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
    
    with {player}
    
    array_map_ext(grid, function(_e, _i) { return { x: _e.x + player * 20, y: _e.y + player * 20}})
    
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
influenceGrid = [initialInfluenceGrid(0), initialInfluenceGrid(1)]


getBuildingThatAcceptsOverProduction = function(player) {
    for (var i = 0; i < array_length(influenceGrid[player]); i++) {
        
        if (!influenceGrid[player][i].occupiedBy) {
            continue;
        }
        
        if (variable_instance_exists(influenceGrid[player][i].occupiedBy, "acceptsOverproduction") && influenceGrid[player][i].occupiedBy.acceptsOverproduction) {
            return influenceGrid[player][i].occupiedBy
        }
    }
    return false
}


getClosestBuildableSpot = function(pX, pY) {
    player = 0
    var bestDistance = 2147483647
    var bestX = 0
    var bestY = 0
    
    for (var i = 0; i < array_length(influenceGrid[player]); i++) {
        
        if (influenceGrid[player][i].occupiedBy) {
            continue;
        }
        
        var distance = point_distance(pX, pY, influenceGrid[player][i].x, influenceGrid[player][i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGrid[player][i].x
            bestY = influenceGrid[player][i].y
        }

    }
    
    return { distance: bestDistance, x: bestX, y: bestY }
}


// Type is a type defined in ItemScripts.Building
buildAt = function(pos, type) { 
    var player = 0
    
    var buildings = influenceGrid[player]
    
    with { buildings, pos } // https://yal.cc/gamemaker-diy-closures/
        
    var buildingSiteIndex = array_find_index(buildings, function(_e, _i) { return (_e.x == pos.x && _e.y == pos.y); } )
    
    if (buildingSiteIndex == -1) {
        // This can happen when picking upp multiple placable buildings at once and placing them all at the same time, Bit of a side behavior really
        return false
    }
    
    var loc = influenceGrid[player][buildingSiteIndex]
    
    var newBuilding = instance_create_layer(loc.x, loc.y, "Ground", ds_map_find_value(global.buildings, type).building, { player })
    
    loc.occupiedBy = newBuilding
    return true

}

for (var i = 0; i < array_length(influenceGrid[0]); i++) { 
    if (influenceGrid[0][i].rX == 0 && influenceGrid[0][i].rY == 0) {
        var staringPortLocation = { x: influenceGrid[0][i].x, y : influenceGrid[0][i].y }
        buildAt(staringPortLocation, Building.STARTING_PORT)
    } 
}

