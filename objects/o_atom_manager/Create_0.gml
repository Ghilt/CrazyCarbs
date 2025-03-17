// Manages atoms needing callbacks similar to the built in events

stepAtoms = []
resetAfterBattleAtoms = []

// Called by game phase manager and propagated to atoms
resetAfterBattle = function() {
    var arrayLength = array_length(resetAfterBattleAtoms)
    for (var i = 0; i < arrayLength; i++) {
        resetAfterBattleAtoms[i].reset()
    }
}

registerForResetAfterBattle = function(instance, atomReset) {
    array_push(resetAfterBattleAtoms, { instance, reset: atomReset })
}

registerForStep = function(instance, atomStep) {
    array_push(stepAtoms, { instance, step: atomStep })
}

cleanUpInstance = function(instance) {
    var equalityFilter = method({ instance }, function(_obj) {
        return _obj.instance != instance
    })
    stepAtoms = array_filter(stepAtoms, equalityFilter)
    resetAfterBattleAtoms = array_filter(resetAfterBattleAtoms, equalityFilter)
}