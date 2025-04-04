type = Building.STARTING_PORT

// Inherit the parent event
event_inherited();

stats = {
    overproductionHealingPower: 10
}

acceptsOverproduction = true

overproductionTriggered = function(){
    o_stability_manager.stabilize(stats.overproductionHealingPower, player)
}