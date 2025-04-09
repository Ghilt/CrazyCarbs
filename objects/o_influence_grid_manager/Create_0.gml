// If a method in this manager does not take a player argument, then that method only is used for the playing player and not enemy player

debugGrid = true


// Holds the order of expansion for the city in relative terms
// {x, y, dist}
areaExpandOrder = getOrderedAreaExpansion(5)


expandToNewSpot = function(currentSpots, allowedTerrain) {
    var newDistrict = false
    for (var i = 0; i < array_length(areaExpandOrder); i++) {
        var tile = global.terrainMap[# o_map_manager.playerSpawnTile.x + areaExpandOrder[i].x, o_map_manager.playerSpawnTile.y + areaExpandOrder[i].y]
        var terrain = o_map_manager.convertTileTypeToTerrain(tile)

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


relativePosToCityDistrict = function(tile, terrain) {
    var posX = (tile.x + o_map_manager.playerSpawnTile.x) * TILE_SIZE
    var posY = (tile.y + o_map_manager.playerSpawnTile.y) * TILE_SIZE
    
    return new CityDistrict(tile.x, tile.y, posX, posY, false, terrain, false)
}


var startPos = o_map_manager.getPlayerPosition(Player.US)
// represents where structures of your city state can be built
influenceGrid = [[
    // Here be some temp spaghetti: setting up start position here for player
    new CityDistrict(0, 0, startPos.x, startPos.y, false, Terrain.SEA, false)
], [/*Loaded every battle*/]]

// Type is a type defined in ItemScripts.Building
buildAt = function(pos, type, buildingRotated) { 
        
    var buildingParameters = ds_map_find_value(global.buildings, type)

    var spots = influenceGrid[Player.US]
    
    with { spots, pos } // https://yal.cc/gamemaker-diy-closures/ I like method(...) more now! 
        
    var buildingSiteIndex = array_find_index(spots, function(_e, _i) { return (_e.x == pos.x && _e.y == pos.y) } )
    
    if (buildingSiteIndex == -1) {
        // This can happen when picking upp multiple placable buildings at once and placing them all at the same time, Bit of a side behavior really
        return false
    }
    
    var district = spots[buildingSiteIndex]
    var footprintCoordinates = footprintToCoordinates(district, buildingRotated ? buildingParameters.getRotatedFootprint() : buildingParameters.footprint)
    
    // terrain already checked, so it is not strictly required to be checked here
    footprintUnionedWithInfluenceGridIndex(spots, footprintCoordinates, buildingParameters.terrainRequirement)
    
    // Check that all spots are unoccupied (and in the grid when called by debug function)
    for (var i = 0; i < array_length(footprintCoordinates); i++) {
        if (!variable_struct_exists(footprintCoordinates[i], "influenceGridIndex")) {
            // the spot required isn't even on grid, this was called from debug function that is a bit lax
            return false    
        } else if (spots[footprintCoordinates[i].influenceGridIndex].occupiedBy) {
            var building = spots[footprintCoordinates[i].influenceGridIndex].occupiedBy
            var buildingRemovedInfo = removeBuildingAt({ x: building.x, y: building.y })
            if (buildingRemovedInfo) {
                var isoSpace = roomToIso(buildingRemovedInfo.x, buildingRemovedInfo.y)
                var newItemInInventoryInitData = o_zoom_manager.convertToGuiSpace(isoSpace.x, isoSpace.y)
                // TODO whats up here: flickery
                newItemInInventoryInitData.carry = Carry.None
                newItemInInventoryInitData.action = Action.None
                //newItemInInventoryInitData.carry = Carry.ClickCarry
                //newItemInInventoryInitData.action = Action.Build
                o_inventory_manager.addItem(buildingRemovedInfo.type, newItemInInventoryInitData)
            }
        }
    }
    
    
    var newBuilding = instance_create_layer(
        district.x, 
        district.y, 
        "Ground", 
        buildingParameters.object, 
        { player: Player.US, origin: { x: district.x, y: district.y }, buildingRotated }
    )
    
    
    for (var i = 0; i < array_length(footprintCoordinates); i++) {
        spots[footprintCoordinates[i].influenceGridIndex].occupiedBy = newBuilding
    }
    recalculateAdjacencyOnNewBuilding(district)
    return true
}

removeBuildingAt = function(pos) {
    var spots = influenceGrid[Player.US]
    var buildingSiteIndex = array_find_index(spots, method( { pos }, function(_e, _i) { return (_e.x == pos.x && _e.y == pos.y) }))
    
    if (buildingSiteIndex == -1) {
        return false
    }
    
    var district = spots[buildingSiteIndex]
    if (!district.occupiedBy) {
        return false
    }
    
    var building = district.occupiedBy
    var footprintCoordinates = []
    for (var i = 0; i < array_length(spots); i++) {
        if (spots[i].occupiedBy == building) {
            array_push(footprintCoordinates, { influenceGridIndex: i })
        }
    }
    // Clear occupiedBy references
    for (var i = 0; i < array_length(footprintCoordinates); i++) {
        spots[footprintCoordinates[i].influenceGridIndex].occupiedBy = false
    }
    
    recalculateAdjacencyOnNewBuilding(district)
    
    var destroyedBuildingInfo = {
        type: building.type,
        x: building.x,
        y: building.y
    }

    instance_destroy(building)
    return destroyedBuildingInfo
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

buildAt(o_map_manager.getPlayerPosition(Player.US), Building.STARTING_PORT, false)
repeat (9) {
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

getClosestBuildableSpot = function(pX, pY, footprint, terrain = Terrain.GROUND) {
    var bestDistance = MAX_INT
    var bestX = 0
    var bestY = 0
    
    for (var i = 0; i < array_length(influenceGrid[Player.US]); i++) {
        
        if (influenceGrid[Player.US][i].occupiedBy) {
            // TODO just skip this check and make sure to unbuild the occupying structure and send it to inventory
            continue;
        }
        
        if (influenceGrid[Player.US][i].terrain != terrain) {
            continue;
        }
        
        if (!footprintFitsInGrid(influenceGrid[Player.US][i], footprint, influenceGrid[Player.US][i].terrain)) {
            continue;
        }
        
        var isoMappedMouse = isoToRoom(pX, pY)
        
        var distance = point_distance(isoMappedMouse.x, isoMappedMouse.y, influenceGrid[Player.US][i].x, influenceGrid[Player.US][i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestX = influenceGrid[Player.US][i].x
            bestY = influenceGrid[Player.US][i].y
        }
    }
    
    return { distance: bestDistance, x: bestX, y: bestY }
}

footprintFitsInGrid = function(anchorDistrict, footprint, requiredTerrain) {
    // refactor influence grid data structure some day
    var listOfRequiredCoordinates = footprintToCoordinates(anchorDistrict, footprint)
    
    var fits = arrayContainsAllTerrainedPos(influenceGrid[Player.US], listOfRequiredCoordinates, requiredTerrain)
    return fits
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

getClosestShipWithin = function(unit, range, owningPlayer) {
    
    var seaFilter = function(district, index) { return district.holdsAliveShip(); }
    
    var filteredDistricts = array_filter(influenceGrid[owningPlayer], seaFilter)
    var shipInstances = array_map(filteredDistricts, function(_obj) { return _obj.occupiedBy }) 
    var filteredSelf = array_filter(shipInstances, equalityFilter(unit))

    return getClosestInstanceWithin(filteredSelf, instancePosition(unit), range)
}

goToBattle = function(enemyCitySavedData) {
    var startPos = enemyCitySavedData.pos
    
    // Map to track buildings by their coordinates
    var buildingMap = ds_map_create()
    
    var loadIntoMap = method({ buildingMap, startPos }, function (_savedDistrict, _i)
    {
        var pos = { 
           x: (_savedDistrict.relativeX + startPos.x) * TILE_SIZE, 
           y: (_savedDistrict.relativeY + startPos.y) * TILE_SIZE 
        }
        
        // Use absolute coordinates for the coordKey
        var absX = _savedDistrict.relativeX + startPos.x
        var absY = _savedDistrict.relativeY + startPos.y
        var coordKey = string(absX) + "," + string(absY)
        var existingBuilding = buildingMap[? coordKey]
        
        if (existingBuilding != undefined) {
            // This coordinate is part of an already created building
            return new CityDistrict(_savedDistrict.relativeX, _savedDistrict.relativeY, pos.x, pos.y, existingBuilding, _savedDistrict.terrain, _savedDistrict.buildingRotated)
        }
        
        var building = false
        if (_savedDistrict.hasBuildingType()) {
            building = instance_create_layer(
                pos.x, 
                pos.y, 
                "Ground", 
                ds_map_find_value(global.buildings, _savedDistrict.buildingType).object, 
                { player: Player.THEM, origin: pos, buildingRotated: _savedDistrict.buildingRotated }
            )
            
            // Store building reference for all coordinates it occupies
            var buildingData = global.buildings[? _savedDistrict.buildingType]
            var footprint = _savedDistrict.buildingRotated ? buildingData.getRotatedFootprint() : buildingData.footprint
            
            // Generate all coordinates for the footprint
            for (var yy = 0; yy < footprint.height; yy++) {
                for (var xx = 0; xx < footprint.width; xx++) {
                    var footprintAbsX = absX + xx
                    var footprintAbsY = absY + yy
                    var footprintKey = string(footprintAbsX) + "," + string(footprintAbsY)
                    buildingMap[? footprintKey] = building
                }
            }
        }
        
        return new CityDistrict(_savedDistrict.relativeX, _savedDistrict.relativeY, pos.x, pos.y, building, _savedDistrict.terrain, _savedDistrict.buildingRotated)
    })
    
    // need to order the districts temporarily(remember the (0,0) starting district is promised to be first in the list. Need to restore afterwards
    orderCityDistrictFromTopLeft(enemyCitySavedData.districts)
    var loadedIntoMap = array_map(enemyCitySavedData.districts, loadIntoMap) 
    
    influenceGrid[Player.THEM] = placeStartingDistrictFirstInList(loadedIntoMap)
    
    ds_map_destroy(buildingMap)
    
    recalculateAdjacency(Player.THEM)
}