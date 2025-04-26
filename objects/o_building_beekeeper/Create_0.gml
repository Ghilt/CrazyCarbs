type = Building.BEEKEEPER

stats = {
    productionRate: 1,
    cooldown: 3 * one_second,
    payoffRequirementAmount: 3,
    payoffRequirementType: Resource.LUMBER,
    producesResource: Resource.HONEY
}


// Inherit the parent event
event_inherited()

onAbilityActivationPlayer = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionRate, id)
}

onAbilityActivationEnemy = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionRate, id)
}

onPayoffActivationPlayer = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionRate, id)
    
}

onPayoffActivationEnemy = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionRate, id)
}

payoff = new PayoffTrigger(id, player, stats.cooldown, onPayoffActivationPlayer, onPayoffActivationEnemy, [{ type: stats.payoffRequirementType, amount: stats.payoffRequirementAmount }])
onceTrigger = new OnceTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)