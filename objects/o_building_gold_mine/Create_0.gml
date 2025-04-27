type = Building.GOLD_MINE


childResource = Resource.ORE

event_inherited()


onAbilityActivationPlayer = function(){
    // generate resource in ui layer
    o_resource_manager.generateResource(stats.resource, stats.productionAmount, id)
}

onAbilityActivationEnemy = function(){
    // generate resource in world layer
    o_resource_manager.generateResource(stats.resource, stats.productionAmount, id)
}

everySecondAtom = new TimedTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)