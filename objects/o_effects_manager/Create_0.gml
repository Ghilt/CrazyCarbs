// Manages particle effects of differents kinds


mouseFeedBackParticleSystem = part_system_create()
o_depth_manager.registerParticlesForDepthSorting(mouseFeedBackParticleSystem, { x: room_width, y: room_height })
particleSystems = ds_map_create()

// { x, y } in room space
mouseClickFeedbackAt = function(pos) {
    part_particles_burst(mouseFeedBackParticleSystem, pos.x, pos.y, ps_mouse_feedback);
}

// { x, y } in room space
// play at iso space (god my mental image of how this iso stuff works is low quality, trips me up every time)
buildItemEffectAt = function(pos) {
    var system = particleSystemAt(pos)
    var isoPos = roomToIso(pos.x, pos.y)
    part_particles_burst(system, isoPos.x, isoPos.y, ps_building_place_dust_swirl);
}

particleSystemAt = function(pos) {
    
    if (ds_map_exists(particleSystems, pos)) {
        return particleSystems[? pos]
    }
    
    var system = part_system_create()
    
    particleSystems[? pos] = system
    
    o_depth_manager.registerParticlesForDepthSorting(system, pos)
    
    return system
}

cleanupAllParticleSystems = function() {
    var keys = ds_map_keys_to_array(particleSystems)
    for (var i = 0; i < array_length(keys); i++) {
        var system = particleSystems[? keys[i]]
        o_depth_manager.unRegisterParticlesForDepthSorting(system)
        part_system_destroy(system)
    }
    ds_map_clear(particleSystems)
    part_system_destroy(mouseFeedBackParticleSystem)
}