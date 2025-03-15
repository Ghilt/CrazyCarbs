// Inherit the parent event
event_inherited();

current_frame = 0
interval = 2 * one_second + irandom(20)
particleSystem = part_system_create()

particlePos = { x, y } // with respect to depth sorting we always go with 'real' position
o_depth_manager.registerParticlesForDepthSorting(particleSystem, particlePos)



onAbilityActivationPlayer = function (){
    o_stability_manager.stabilize(8, player)
    var isoPos = roomToIso(x, y)
    part_particles_burst(particleSystem, isoPos.x, isoPos.y, ps_jiggle);
}

onAbilityActivationEnemy = function (){
    o_stability_manager.stabilize(8, player)
    var isoPos = roomToIso(x, y)
    part_particles_burst(particleSystem, isoPos.x, isoPos.y, ps_jiggle);
}