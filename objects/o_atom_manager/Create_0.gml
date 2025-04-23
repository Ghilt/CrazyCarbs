// Manages atoms needing callbacks similar to the built in events
// Current Atoms : Triggers

stepAtoms = []
resetAfterBattleAtoms = []

// The trigger counter is used to ensure that all triggers trigger before any of them are triggered again.
payoffTriggerCounter = [0, 0]
payoffTriggers = [[],[]]

// Called by game phase manager and propagated to atoms
resetAfterBattle = function() {
    payoffTriggerCounter = [0, 0]
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

registerForStepPayoff = function(instance, atomStep, atomIsReady, atomResourceCost, atomTriggerCount, atomTriggerPayoff) {
    array_push(payoffTriggers[instance.player], { 
        instance, 
        step: atomStep,
        isReady: atomIsReady,
        resourceCost: atomResourceCost, 
        triggerCount: atomTriggerCount,
        triggerPayoff: atomTriggerPayoff 
    })
}

cleanUpInstance = function(instance) {
    
    // Why is this var prefixed with an underscore?
    // This is a monument to a bug and a realization about how things may go down in game maker
    // in another script there is a function called 'equalityFilter', that function was used instead of this one when their name collided
    // but even within this method i could get the code to call both equality functions at the same time, wild
    var _equalityFilter = method({ instance }, function(_obj) {
        return _obj.instance != instance
    })
    
    stepAtoms = array_filter(stepAtoms, _equalityFilter)
    payoffTriggers[instance.player] = array_filter(payoffTriggers[instance.player], _equalityFilter)
    resetAfterBattleAtoms = array_filter(resetAfterBattleAtoms, _equalityFilter)
}

runPayoffTriggers = function(player) {
    var triggerLength = array_length(payoffTriggers[player])
    
    // Bool used to detect when all triggers have been triggered and a new cycle can begin
    var allTriggered = true
    for (var i = 0; i < triggerLength; i++) {
        var payoff = payoffTriggers[player][i]
        // Instances become inactive when in the ui layer, this checks for that
        if (instance_exists(payoff.instance)) {
            payoff.step()
        
            if (payoff.triggerCount() == payoffTriggerCounter[player]) {
                allTriggered = false
                if (payoff.isReady() && o_resource_manager.resourcesExist(player, payoff.resourceCost())) {
                    o_resource_manager.instanceUseResources(payoff.instance, payoff.resourceCost())
                    payoff.triggerPayoff()    
                }
            }    
        }

    }
    
    if (allTriggered ) {
        // All payoffs has triggered, next cycle starts next step
        payoffTriggerCounter[player] += 1
    }  
}