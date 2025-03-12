// Inherit the parent event
event_inherited();

current_frame = 0
interval = 2 * one_second + irandom(20)
particleSystem = part_system_create()
part_system_depth(particleSystem, -14000)



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