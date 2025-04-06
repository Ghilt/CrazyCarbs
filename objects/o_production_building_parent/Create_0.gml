// TODO remove this class, not worth it

event_inherited()


onAbilityActivationPlayer = function(){
    // generate resource in ui layer
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

onAbilityActivationEnemy = function(){
    // generate resource in world layer
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

everySecondAtom = new TimedTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)