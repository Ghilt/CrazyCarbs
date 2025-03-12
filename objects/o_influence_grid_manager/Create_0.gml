// If a method in this manager does not take a player argument, then that method only is used for the playing player and not enemy player

debugGrid = true


initialInfluenceGrid = function(player){
    // This is all very temp
    var grid = [
        { x : 0, y : 0 },
        { x : -10, y : -10 },
        { x : -2, y : -2 },
        { x : -1, y : -2 },
        { x : -1, y : -1 },
        { x : -1, y : 0 },
        { x : 0, y : -1 }, 
        { x : 0, y : 1 }, 
        { x : -1, y : 1 }, 
        { x : 0, y : -2 },
        { x : -6, y : 6 },
        // sea
        { x : 1, y : -1, sea: true },
        { x : 1, y : 0, sea: true },
        { x : 1, y : 1, sea: true },
        { x : 2, y : -1, sea: true },
        { x : 2, y : 0, sea: true },
        { x : 2, y : 1, sea: true }
    
    ]
    
    var _convert = function (_e, _i)
    {
        var terrain = variable_struct_exists(_e, "sea") ? Terrain.SEA : Terrain.GROUND
        
        var posX = (_e.x + o_game_phase_manager.tempUsStartPos.x) * TILE_SIZE
        var posY = (_e.y + o_game_phase_manager.tempUsStartPos.y) * TILE_SIZE
        
        return new CityDistrict(_e.x, _e.y, posX, posY, false, terrain)
    }
    
    return array_map(grid, _convert)
}

// represents where structures of your city state can be built
influenceGrid = [initialInfluenceGrid(Player.US), [/*Loaded every battle*/]]


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

getRandomPopulatedShoreDistrict = function (player){
    // TODO algo for finding suitable districts
    return influenceGrid[player][0]
}


getClosestBuildableSpot = function(pX, pY, terrain = Terrain.GROUND) {
    var bestDistance = MAX_INT
    var bestX = 0
    var bestY = 0
     
    for (var i = 0; i < array_length(influenceGrid[Player.US]); i++) {
        
        if (influenceGrid[Player.US][i].occupiedBy) {
            continue;
        }
        
        if (influenceGrid[Player.US][i].terrain != terrain) {
            continue;
        }
        
        var isoMappedMouse = isoToRoom(pX, pY)
        var isoMapped = roomToIso(influenceGrid[Player.US][i].x, influenceGrid[Player.US][i].y)
        var roomt = isoToRoom(influenceGrid[Player.US][i].x, influenceGrid[Player.US][i].y) 
        
        var distance = point_distance(isoMappedMouse.x, isoMappedMouse.y, influenceGrid[Player.US][i].x, influenceGrid[Player.US][i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGrid[Player.US][i].x
            bestY = influenceGrid[Player.US][i].y
        }

    }
     
    return { distance: bestDistance, x: bestX, y: bestY }
}


// Type is a type defined in ItemScripts.Building
buildAt = function(pos, type) { 
 
  
    var buildings = influenceGrid[Player.US]
    
    with { buildings, pos } // https://yal.cc/gamemaker-diy-closures/
        
    var buildingSiteIndex = array_find_index(buildings, function(_e, _i) { return (_e.x == pos.x && _e.y == pos.y); } )
    
    if (buildingSiteIndex == -1) {
        // This can happen when picking upp multiple placable buildings at once and placing them all at the same time, Bit of a side behavior really
        return false
    }
    
    var loc = influenceGrid[Player.US][buildingSiteIndex]
    
    var newBuilding = instance_create_layer(
        loc.x, 
        loc.y, 
        "Ground", 
        ds_map_find_value(global.buildings, type).building, 
        { player: Player.US, origin: { x: loc.x, y: loc.y } }
    )
    
    loc.occupiedBy = newBuilding
    return true

}

// temp create a starting building at 0,0
for (var i = 0; i < array_length(influenceGrid[Player.US]); i++) { 
    if (influenceGrid[Player.US][i].relativeX == 0 && influenceGrid[Player.US][i].relativeY == 0) {
        var staringPortLocation = { x: influenceGrid[Player.US][i].x, y : influenceGrid[Player.US][i].y }
        buildAt(staringPortLocation, Building.STARTING_PORT)
    } 
}


// returns city district with x, y
getPlayerPosition = function(player) {
    // first position in list is always starting position
    return influenceGrid[player][0]
}

resetAfterBattle = function() {
    for (var i = 0; i < array_length(influenceGrid[Player.US]); i++) {
        influenceGrid[Player.US][i].resetAfterBattle()
    }
    
    for (var i = 0; i < array_length(influenceGrid[Player.THEM]); i++) {
        influenceGrid[Player.THEM][i].resetAfterBattle()
        // For now, just delete old enemy
        if (influenceGrid[Player.THEM][i].occupiedBy) {
            instance_destroy(influenceGrid[Player.THEM][i].occupiedBy)
        }
    }
}

distanceToBase = function (pos, player) {
    var base = influenceGrid[player][0]
    var distance = point_distance(pos.x, pos.y, base.x, base.y)
    return distance
}

getClosestShipWithin = function(unit, range, owningPlayer) {
    
    with { unit }
    var seaFilter = function passed_the_test(element, index)
    {
        return element.terrain == Terrain.SEA && 
                element.occupiedBy && 
                !element.occupiedBy.isDefeated &&
                element.occupiedBy != unit;
    }
    
    var bestDistance = MAX_INT
    var bestDistrict = false
    var seaDistricts = array_filter(influenceGrid[owningPlayer], seaFilter) 
    
    for (var i = 0; i < array_length(seaDistricts); i++) {
        var distance = point_distance(unit.x, unit.y, seaDistricts[i].occupiedBy.x, seaDistricts[i].occupiedBy.y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestDistrict = seaDistricts[i]
        } 
    }

    return bestDistance < range ? { 
        x: bestDistrict.occupiedBy.x, 
        y: bestDistrict.occupiedBy.y, 
        distance: bestDistance, 
        enemy: bestDistrict.occupiedBy } : false
}

goToBattle = function(enemyCitySavedData) {
    var startPos = enemyCitySavedData.pos
    
    with { startPos }
        
    var loadIntoMap = function (_savedDistrict, _i)
    {
        var pos = { 
           x: (_savedDistrict.relativeX + startPos.x) * TILE_SIZE, 
           y: (_savedDistrict.relativeY + startPos.y) * TILE_SIZE 
        }
        
        var building = _savedDistrict.hasBuildingType() ? instance_create_layer(
            pos.x, 
            pos.y, 
            "Ground", 
            ds_map_find_value(global.buildings, _savedDistrict.buildingType).building, 
            { player: Player.THEM, origin: pos }
        ) : false
        
        return new CityDistrict(_savedDistrict.relativeX, _savedDistrict.relativeY, pos.x, pos.y, building, _savedDistrict.terrain)
    }
    
    influenceGrid[Player.THEM] = array_map(enemyCitySavedData.districts, loadIntoMap)
}