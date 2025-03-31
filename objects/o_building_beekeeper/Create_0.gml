
stats = {
    childProductionRate: 1,
    cooldown: 3 * one_second
}

childResourceSprite = s_resource_honey
childResource = Resource.HONEY

// Inherit the parent event
event_inherited()

onAbilityActivationPlayer = function (){
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

onAbilityActivationEnemy = function (){
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

onPayoffActivationPlayer = function (){
    o_resource_manager.generateResource(Resource.HONEY, stats.childProductionRate, id)
    
}

onPayoffActivationEnemy = function (){
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

payoff = new PayoffTrigger(id, player, stats.cooldown, onPayoffActivationPlayer, onPayoffActivationEnemy, [{ type: Resource.LUMBER, amount: 3 }])
everySecondAtom = new OnceTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)