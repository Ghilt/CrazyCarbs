function countBuildingTags(adjacentDistrictsArray, buildingTag) {
    return arrayCount(adjacentDistrictsArray, method({ buildingTag }, function(_obj){
        if (_obj.occupiedBy) {
            var tags = asset_get_tags(_obj.occupiedBy.object_index, asset_object) 
            return array_contains(tags, buildingTag)
        } else {
            return false
        }    
    }))
}