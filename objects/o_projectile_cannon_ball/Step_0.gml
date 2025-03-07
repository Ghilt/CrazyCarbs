if (timePassed == duration){
    // Movement finished
    timePassed = 0 
    if (!target.isDestroyed) {
        // Target may have been destroyed
        target.hitByProjectile(damage)
    }
    instance_destroy(id)
    
} else {
    if (!target.isDestroyed) {
        lastTargetPos = instancePosition(target)
    }
    
    timePassed += 1
    var interpolation = timePassed / duration 
    
    var position = animcurve_channel_evaluate(movement, interpolation)    
    var position2 = animcurve_channel_evaluate(scale, interpolation)
    x = lerp(origin.x, lastTargetPos.x, position)
    y = lerp(origin.y, lastTargetPos.y, position)
    
    image_xscale = lerp(startScale, endScale, position2)
    image_yscale = lerp(startScale, endScale, position2)
}
