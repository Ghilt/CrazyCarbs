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

function footprintUnionedWithInfluenceGridIndex(containerArray, vectors, requiredTerrain) {
    var arrayLength = array_length(containerArray)
    for (var i = 0; i < arrayLength; i++) {
        var check = containerArray[i]
        if (requiredTerrain != check.terrain) {
            continue;
        }
        
        var foundArray = array_filter(vectors, method({ check, requiredTerrain  }, function(obj) {
            return check.relativeX == obj.x && check.relativeY == obj.y         
        }))  
        
        if (array_length(foundArray) == 1) {
            foundArray[0].influenceGridIndex = i
        }
        
    }
    return vectors
}
