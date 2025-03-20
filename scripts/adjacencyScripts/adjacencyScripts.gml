function countBuildingTags(adjacentDistrictsArray, buildingTag) {
    return arrayCount(adjacentDistrictsArray, method({ buildingTag }, function(_obj){
        if (_obj.occupiedBy) {
            return instanceHasTag(_obj.occupiedBy, buildingTag)
        } else {
            return false
        }
    }))
}