// Instance can have been removed from enemy fleet here. Mainly due to debug circumstances, deleting the old enemy is a WIP thing. 
var isDeleted = !instance_exists(target)

if (timePassed == duration){
    // Movement finished
    timePassed = 0 
    if (!isDeleted && !target.isDefeated) {
        // Target may have been defeated
        target.hitByProjectile(damage)
    }
    instance_destroy(id)
    
} else {
    if (!isDeleted && !target.isDefeated) {
        lastTargetPos = instancePosition(target)
    }
    
    timePassed += 1
    var interpolation = timePassed / duration 
    
    var position = animcurve_channel_evaluate(movement, interpolation)    
    var position2 = animcurve_channel_evaluate(scale, interpolation)
    x = lerp(firedFromPos.x, lastTargetPos.x, position)
    y = lerp(firedFromPos.y, lastTargetPos.y, position)
    
    image_xscale = lerp(startScale, endScale, position2)
    image_yscale = lerp(startScale, endScale, position2)
}
