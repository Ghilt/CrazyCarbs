type = Building.STARTING_PORT

// Inherit the parent event
event_inherited();

acceptsOverproduction = true

overproductionTriggered = function(){
    o_stability_manager.stabilize(stats.overproductionHealingPower, player)
}