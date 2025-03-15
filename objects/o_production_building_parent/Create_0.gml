event_inherited()


onAbilityActivationPlayer = function (){
    // generate resource in ui layer
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}

onAbilityActivationEnemy = function (){
    // generate resource in world layer
    o_resource_manager.generateResource(childResource, stats.childProductionRate, id)
}