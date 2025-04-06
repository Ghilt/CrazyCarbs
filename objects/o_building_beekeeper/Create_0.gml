type = Building.BEEKEEPER

stats = {
    productionRate: 1,
    cooldown: 3 * one_second
}

resource = Resource.HONEY

// Inherit the parent event
event_inherited()

onAbilityActivationPlayer = function (){
    o_resource_manager.generateResource(resource, stats.productionRate, id)
}

onAbilityActivationEnemy = function (){
    o_resource_manager.generateResource(resource, stats.productionRate, id)
}

onPayoffActivationPlayer = function (){
    o_resource_manager.generateResource(resource, stats.productionRate, id)
    
}

onPayoffActivationEnemy = function (){
    o_resource_manager.generateResource(resource, stats.productionRate, id)
}

payoff = new PayoffTrigger(id, player, stats.cooldown, onPayoffActivationPlayer, onPayoffActivationEnemy, [{ type: Resource.LUMBER, amount: 3 }])
onceTrigger = new OnceTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)