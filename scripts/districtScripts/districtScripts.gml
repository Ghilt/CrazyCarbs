/// @desc Function Description
/// @param {array} districtList These are SavedDistricts. Not yet loaded into map
/// @param {Real} fromRotation as defined in Direction in mathsScripts
/// @param {Real} toRotation as defined in Direction in mathsScripts
/// @returns {array} Description The districts rotated to the new direction
function rotateCity(districtList, fromRotation, toRotation) {
    
    var _convert = method({ fromRotation, toRotation }, function (_district, _i)
    {
        var districtPos = { x:_district.relativeX, y:_district.relativeY }
        var rotated = vectorRotateAroundOrigin(districtPos, fromRotation, toRotation)
        
        // The rotation values will be either 0, 2, 4, 6. See Direction enum NORTH=0, NORTH_EAST=1, EAST=2 etc
        // when rotating the city the buildings will be rotated also every step, we only need to know if the whole thing is rotated an even or uneven amount of steps
        var rotatationSteps = abs(fromRotation - toRotation)/2
        var buildingRotation = rotatationSteps mod 2 == 0 ? _district.buildingRotated : !_district.buildingRotated
        
        return new SavedCityDistrict(rotated.x, rotated.y, _district.terrain, _district.buildingType, buildingRotation)
    })
    
    return array_map(districtList, _convert)
}


function orderCityDistrictFromTopLeft(districtList){
    array_sort(districtList, function(elm1, elm2)
    {
        var yDiff = elm1.relativeY - elm2.relativeY
        if (yDiff != 0) return yDiff
        return elm1.relativeX - elm2.relativeX
    });
}

function placeStartingDistrictFirstInList(districtList){
    var newList = array_create(0)
    var startingDistrict = undefined
    
    for (var i = 0; i < array_length(districtList); i++) {
        var district = districtList[i]
        if (district.relativeX == 0 && district.relativeY == 0) {
            startingDistrict = district
        } else {
            array_push(newList, district)
        }
    }
    
    if (startingDistrict != undefined) {
        array_insert(newList, 0, startingDistrict)
    }
    
    return newList
}

