// Manages  effects of differents kinds
// heres a sound site: https://opengameart.org/content/jump-landing-sound


// Pope says to never use ds_ structure, just use strucs
// As soon as you think "Ah, I'll use a data structure" just don't


//// THE below text is from the pixelated pope about not using emitters:
//I design the actual particle in the particle editor, then manually create my part system and manually create instances of the particle I designed using part_particles_burst
//All you would need to do is a use a bit of code to find a point on either line to create the particle
//Which shouldn't be difficult
//Something like this:
//var _angle = choose(45, 135)
//var _length = random(600);
//var _x = v_center_x + lengthdir_x(_length, _angle)
//var _y = v_center_y + lengthdir_y(_length, _angle)
//part_particles_burst(<Your particle asset>, _x, _y, <your part system>)
 //
//v_center being where you want that bottom point of the V to be

groundParticleSystem = part_system_create() // hugs the ground
o_depth_manager.registerParticlesForDepthSorting(groundParticleSystem, { x: -10000, y: -10000 })
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

buildInfoHoverFeedback = function() {
    audio_play_sound(snd_click, 0, false, 0.1, 0, random_range(0.6, 0.9))
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

// pos = { x, y } in room space
// effect cover exactly 1 tile
recipeActiveEffectAt = function(listOfPos) {
    audio_play_sound(snd_recipe_fulfilled, 0, false, 0.3, 0, random_range(0.8, 1.2))

    var arrayLength = array_length(listOfPos)
    for (var i = 0; i < arrayLength; i++) {
        var pos = listOfPos[i]
        var system = particleSystemAt(pos)
        var isoPos = roomToIso(pos.x, pos.y)
        part_particles_burst(system, isoPos.x, isoPos.y, ps_recipe_fulfilled)
    }
    
}

recipeActiveEffectAt2 = function(listOfPos) {
    var arrayLength = array_length(listOfPos)
    for (var i = 0; i < arrayLength; i++) {
        var pos = listOfPos[i]
        var system = groundParticleSystem
        var isoPos = roomToIso(pos.x, pos.y)
        part_particles_burst(system, isoPos.x, isoPos.y, ps_recipe_active_district)
    }
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