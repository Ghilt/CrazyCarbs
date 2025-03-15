event_inherited();

numberOfAdjacentNatureTag = 0

adjecencyBoosted = function() {
    return stats.baseCooldown * (1 - numberOfAdjacentNatureTag * 0.1)
}

stats = {
    healingPower: 8,
    baseCooldown: 5 * one_second,
    cooldown: adjecencyBoosted
}

particleSystem = part_system_create()

particlePos = { x, y } // with respect to depth sorting we always go with 'real' position
o_depth_manager.registerParticlesForDepthSorting(particleSystem, particlePos)

onAbilityActivationPlayer = function (){
    o_stability_manager.stabilize(stats.healingPower, player)
    var isoPos = roomToIso(x, y)
    part_particles_burst(particleSystem, isoPos.x, isoPos.y, ps_jiggle);
}

onAbilityActivationEnemy = function (){
    o_stability_manager.stabilize(stats.healingPower, player)
    var isoPos = roomToIso(x, y)
    part_particles_burst(particleSystem, isoPos.x, isoPos.y, ps_jiggle);
}

adjacencyUpdate = function(adjacentDistricts) {
    numberOfAdjacentNatureTag = countBuildingTags(adjacentDistricts, TAG_NATURE)
    ppp("Grand oak adjacency updated:", numberOfAdjacentNatureTag)
}