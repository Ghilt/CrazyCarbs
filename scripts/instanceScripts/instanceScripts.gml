function instancePosition(instance){
    return { x: instance.x, y: instance.y }
}

function getClosestInstanceWithin(instances, pos, range) {
    var bestDistance = MAX_INT
    var bestInstance = false
    
    var arrayLength = array_length(instances)
    for (var i = 0; i < arrayLength; i++) {
        var distance = point_distance(pos.x, pos.y, instances[i].x, instances[i].y)
        
        if (distance < bestDistance) {
            bestDistance = distance
            bestInstance = instances[i]
        } 
    }

    return bestDistance < range ? { 
        x: bestInstance.x, 
        y: bestInstance.y, 
        distance: bestDistance, 
        instance: bestInstance } : false    
}

function instanceHasTag(instance, tag) {
    var tags = asset_get_tags(instance.object_index, asset_object) 
    return array_contains(tags, tag)
}