function arrayContainsAllTerrainedPos(containerArray, vectors, requiredTerrain) {
    var checkedOfVectors = vectors
    var arrayLength = array_length(containerArray)
    for (var i = 0; i < arrayLength; i++) {
        var check = containerArray[i]
        if (requiredTerrain != check.terrain) {
            continue;
        }
        
        checkedOfVectors = array_filter(checkedOfVectors, method({ check, requiredTerrain  }, function(obj) {
            return check.relativeX != obj.x || check.relativeY != obj.y         
        }))  
        
        if (array_length(checkedOfVectors) == 0) {
            return true
        }  
    }
    return false
}


function footprintUnionedWithInfluenceGridIndex(influenceGridForPlayer, footPrintCoords, requiredTerrain) {
    var arrayLength = array_length(influenceGridForPlayer)
    for (var i = 0; i < arrayLength; i++) {
        var check = influenceGridForPlayer[i]
        if (requiredTerrain != check.terrain) {
            continue;
        }
        
        var foundArray = array_filter(footPrintCoords, method({ check }, function(obj) {
            return check.relativeX == obj.x && check.relativeY == obj.y;         
        }))  
        
        if (array_length(foundArray) == 1) {
            // here we store an influence grid index on the footprint that was previously just { x, y }
            // here it becomes{ x, y, influenceGridIndex }
            foundArray[0].influenceGridIndex = i
        }
        
    }
}

// district with occupiedBy != null
function getAllInfluenceGridIndexesOfBuilding(district){
    var building = district.occupiedBy
    var spots = o_influence_grid_manager.influenceGrid[building.player]
    var arrayLength = array_length(spots)
    var result = []
    for (var i = 0; i < arrayLength; i++) {
        if (spots[i].occupiedBy == building) {
            array_push(result, i)
        }
    }
    return result
}


// district with occupiedBy != null
// eg a building with a 1x2 footprint will have between 0 and 6 adjacent districts
// this function assumes that each districts already have their adjacent districts calculated in their 'adjacentDistricts' array
/// @returns {array} returns indexes for influenceGrid
function getAdjacentDistrictIndexesOfBuilding(district) {
    var building = district.occupiedBy
    var buildingParameters = ds_map_find_value(global.buildings, building.type)
    
    var spots = o_influence_grid_manager.influenceGrid[building.player]
    
    var footprintIndexes = getAllInfluenceGridIndexesOfBuilding(district)
    
    var result = []
    // now we have all districts, just take their adjacent districts stored in each one and concatenate
    for (var i = 0; i < array_length(footprintIndexes); i++) {
        result = array_concat(result, spots[footprintIndexes[i]].adjacentDistricts)
    }
    result = array_unique(result)
    
    // just a bit convoluted way to filter away the districts the building itself occupies
    result = array_filter(result, method({ theFootprintIsNotAdjacentToItself: footprintIndexes }, function(resultingInfluenceGridIndex) {
        //The index is not in the footprint:
        return !arrayContains(theFootprintIsNotAdjacentToItself, method({ resultingInfluenceGridIndex }, function(aFootprintCoord) {
            return resultingInfluenceGridIndex == aFootprintCoord
        }))
        
    })) 

    return result
    
}