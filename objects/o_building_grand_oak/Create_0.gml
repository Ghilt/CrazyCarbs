type = Building.GRAND_OAK

event_inherited();

numberOfAdjacentNatureTag = 0

particleSystem = part_system_create()

particlePos = { x, y } // with respect to depth sorting we always go with 'real' position
o_depth_manager.registerParticlesForDepthSorting(particleSystem, particlePos)

adjecencyBoosted = function() {
    return stats.baseCooldown * (1 - numberOfAdjacentNatureTag * stats.adjacencyCooldownReductionBonus)
}

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

everySecondAtom = new TimedTrigger(id, player, adjecencyBoosted, onAbilityActivationPlayer, onAbilityActivationEnemy)


adjacencyUpdate = function(adjacentDistricts) {
    numberOfAdjacentNatureTag = countBuildingTags(adjacentDistricts, TAG_NATURE)
}