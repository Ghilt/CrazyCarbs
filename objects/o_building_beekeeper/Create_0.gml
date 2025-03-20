
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

everySecondAtom = new OnceTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)