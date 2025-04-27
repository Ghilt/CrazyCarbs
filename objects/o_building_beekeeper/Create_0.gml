type = Building.BEEKEEPER

// Inherit the parent event
event_inherited()

onAbilityActivationPlayer = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionAmount, id)
}

onAbilityActivationEnemy = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionAmount, id)
}

onPayoffActivationPlayer = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionAmount, id)
    
}

onPayoffActivationEnemy = function (){
    o_resource_manager.generateResource(stats.producesResource, stats.productionAmount, id)
}

payoff = new PayoffTrigger(id, player, stats.cooldown, onPayoffActivationPlayer, onPayoffActivationEnemy, [{ type: stats.payoffRequirementType, amount: stats.payoffRequirementAmount }])
onceTrigger = new OnceTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)