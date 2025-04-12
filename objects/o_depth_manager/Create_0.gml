particleSystems = []

// pose is {x, y} in ordinary space
registerParticlesForDepthSorting = function(particleSystem, pos) {
    array_push(particleSystems, { particleSystem, pos })
}

unRegisterParticlesForDepthSorting = function(particleSystem) {
    var ctx = { systemToBeUnregistered: particleSystem }
    particleSystems = array_filter(particleSystems, method(ctx, function(_obj){
        return _obj.particleSystem != systemToBeUnregistered
    }))
}
