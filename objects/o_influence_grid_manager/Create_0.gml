// If a method in this manager does not take a player argument, then that method only is used for the playing player and not enemy player

debugGrid = true

// Used to
// limit search for tiles for city when iterating on the whole map
roughCitySize = 10


// Holds the order of expansion for the city in relative terms
// {x, y, dist}
areaExpandOrder = getOrderedAreaExpansion(5)


expandToNewSpot = function(currentSpots, allowedTerrain) {
    var newDistrict = false
    for (var i = 0; i < array_length(areaExpandOrder); i++) {
        var tile = global.terrainMap[# o_game_phase_manager.tempUsStartPos.x + areaExpandOrder[i].x, o_game_phase_manager.tempUsStartPos.y + areaExpandOrder[i].y]
        var terrain = o_map_loader_manager.convertTileTypeToTerrain(tile)

        if (terrain != allowedTerrain) {
            continue; 
        }
        
        // No premature optimization here! Harmony, let it be!
        var alreadyHasSpot = false
        for (var j = 0; j < array_length(currentSpots); j++) {
            if (areaExpandOrder[i].x == currentSpots[j].relativeX && currentSpots[j].relativeY == areaExpandOrder[i].y) {
                alreadyHasSpot = true
                continue;
            }
        }
        if (alreadyHasSpot) {
            continue;
        }
        
        newDistrict = relativePosToCityDistrict(areaExpandOrder[i], allowedTerrain)
        
        // insert at the first position, since pos 0 is reserved for starting position (0, 0)
        if (array_length(currentSpots) == 0) throw ("Developer error: This function requires that we have initialized the starting pos at (0, 0)")
        
        if (newDistrict) {
            break;
        }  
    }  
     
    if (newDistrict) {
        ppp("Expanding influence to ", newDistrict)
        array_insert(currentSpots, 1, newDistrict) 
        recalculateAdjacency(Player.US) 
    } else {
        ppp("Failed to expand influence")
    }

}


relativePosToCityDistrict = function(pos, terrain) {
    var posX = (pos.x + o_game_phase_manager.tempUsStartPos.x) * TILE_SIZE
    var posY = (pos.y + o_game_phase_manager.tempUsStartPos.y) * TILE_SIZE
    
    return new CityDistrict(pos.x, pos.y, posX, posY, false, terrain)
}


var startPos = o_map_loader_manager.getPlayerPosition(Player.US)
// represents where structures of your city state can be built
influenceGrid = [[
    // Here be some temp spaghetti: setting up start position here for player
    new CityDistrict(0, 0, startPos.x, startPos.y, false, Terrain.SEA)
], [/*Loaded every battle*/]]

// Type is a type defined in ItemScripts.Building
buildAt = function(pos, type) { 

    var spots = influenceGrid[Player.US]
    
    with { spots, pos } // https://yal.cc/gamemaker-diy-closures/ I like method(...) more now! 
        
    var buildingSiteIndex = array_find_index(spots, function(_e, _i) { return (_e.x == pos.x && _e.y == pos.y); } )
    
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
    recalculateAdjacencyOnNewBuilding(loc)
    return true
}

updateAdjacencyForDistrict = function(district) {
    // Lets try have this 'variable_instance_exists' here for a bit. It feels yucky, but maybe we are in rome.
    if (district.occupiedBy && variable_instance_exists(district.occupiedBy, "adjacencyUpdate")) {
        district.occupiedBy.adjacencyUpdate(arrayFilterOnIndexes(influenceGrid[Player.US], district.adjacentDistricts))    
    }
}

recalculateAdjacencyOnNewBuilding = function(cityDistrict) {
    ppp("Recalculating adjacency for", cityDistrict.relativeX, cityDistrict.relativeY, "as", cityDistrict.adjacentDistricts)
    updateAdjacencyForDistrict(cityDistrict)
    for (var i = 0; i < array_length(cityDistrict.adjacentDistricts); i++) {
        var district = influenceGrid[Player.US][cityDistrict.adjacentDistricts[i]] 
        ppp("Recalculating adjacency for", district.relativeX, district.relativeY, "as", district.adjacentDistricts)
        updateAdjacencyForDistrict(district)
    }
}

// This method completely updates the adjacency information. Required when expanding the grid itself.
// When a building is built, this is not required.
recalculateAdjacency = function(player) { 
    for (var i = 0; i < array_length(influenceGrid[player]); i++) {
        with (influenceGrid[player][i]) {
            adjacentDistricts = [] // clear adjacent list in the cityDistrict
            var pos = { x: relativeX, y: relativeY }
            // Embrace non-premature-optimization, O(n2) ahead:
            for (var j = 0; j < array_length(other.influenceGrid[player]); j++) {
                var potentialNeighbor = other.influenceGrid[player][j]  
                var diff = vectorSubtract(pos, { x: potentialNeighbor.relativeX, y: potentialNeighbor.relativeY })
                if (vectorIsOrthogonalDirection(diff)) {
                    array_push(adjacentDistricts, j) // Dont store the neighbor directly -> leads to 'Recursive stuct' warning
                }
            }
            other.updateAdjacencyForDistrict(self)
        }
    }
}


#region Player setup

buildAt(o_map_loader_manager.getPlayerPosition(Player.US), Building.STARTING_PORT)
repeat (5) {
    expandToNewSpot(influenceGrid[Player.US], Terrain.GROUND)
    expandToNewSpot(influenceGrid[Player.US], Terrain.SEA)
}


// returns city district with x, y, for players relative (0,0) starting position 
getPlayerPosition = function(player) {
    // first position in list is always starting position
    return influenceGrid[player][0]
}

#endregion

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
    
    expandToNewSpot(influenceGrid[Player.US], Terrain.GROUND)
}

distanceToBase = function (pos, player) {
    var base = getPlayerPosition(player)
    var distance = point_distance(pos.x, pos.y, base.x, base.y)
    return distance
}

//TODO this should only give the ships, not do range calcs. move somewhere else
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