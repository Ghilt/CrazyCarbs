// Manages  effects of differents kinds
// heres a sound site: https://opengameart.org/content/jump-landing-sound

mouseFeedBackParticleSystem = part_system_create()
o_depth_manager.registerParticlesForDepthSorting(mouseFeedBackParticleSystem, { x: room_width, y: room_height })
particleSystems = ds_map_create()
buildingDustParticleBursts = ds_map_create()
buildingDustParticleBursts[? "1x1"] = ps_building_1x1_place_dust_swirl
buildingDustParticleBursts[? "2x1"] = ps_building_2x1_place_dust_swirl
buildingDustParticleBursts[? "1x2"] = ps_building_1x2_place_dust_swirl
buildingDustParticleBursts[? "2x2"] = ps_building_2x2_place_dust_swirl

// { x, y } in room space
mouseClickFeedbackAt = function(pos) {
    audio_play_sound(snd_click, 0, false, 0.1, 0, random_range(0.6, 0.9))
    part_particles_burst(mouseFeedBackParticleSystem, pos.x, pos.y, ps_mouse_feedback)
}

// pos = { x, y } in room space
// footprint = { width, height }
// play at iso space (god my mental image of how this iso stuff works is low quality, trips me up every time)
buildItemEffectAt = function(pos, footprint) {
    var system = particleSystemAt(pos)
    var isoPos = roomToIso(pos.x, pos.y)
    var key = string(footprint.width) + "x" + string(footprint.height)
    audio_play_sound(snd_build, 0, false, 0.3, 0, random_range(0.8, 1.2))
    part_particles_burst(system, isoPos.x, isoPos.y, buildingDustParticleBursts[? key])
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