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

/**
 * @return Returns value removed in a struct or an empty struct
 */
function arrayRemoveFirst(array, predicate){
    var arrayLength = array_length(array)
    
    for (var i = 0; i < arrayLength; i++) {
    	if (predicate(array[i])) {
            var removedItem = array_get(array, i)
            array_delete(array, i, 1)
            return { removedItem }
        }
    }
    
    return { /* Empty */ }
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

function arrayContains(array, predicate){
    for (var i = 0; i < array_length(array); i++) {
        if (predicate(array[i], i)) {
            return true
        }
    }
    return false    
}