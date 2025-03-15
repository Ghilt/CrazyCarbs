function arrayFilterOnIndexes(array, indexesToKeep) {
    return array_filter(array, method({ indexesToKeep }, function(sourceObject, sourceIndex) {
        return array_any(indexesToKeep, method({ sourceIndex }, function(indexToKeep) {
            return indexToKeep == sourceIndex
        }))
    }))
}

function arrayCount(array, predicate){
    var count = 0
    for (var i = 0; i < array_length(array); i++) {
        if (predicate(array[i], i)) {
            count++
        }
    }
    return count
}