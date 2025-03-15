// Inherit the parent event
event_inherited();

stats = {
    overpdocutionHealingPower: 10
}

acceptsOverproduction = true

overproductionTriggered = function(){
    o_stability_manager.stabilize(stats.overpdocutionHealingPower, player)
}