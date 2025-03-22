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

function arrayRemove(array, item){
    return array_filter(array, method({ item }, function(_obj) { return _obj != item }))
}

function arrayFlatten(arrayOfArrays) {
    var flattened = []
    var length = array_length(arrayOfArrays)
    for (var i = 0; i < length; i++) {
        flattened = array_concat(flattened, arrayOfArrays[i])
    }
    return flattened
}