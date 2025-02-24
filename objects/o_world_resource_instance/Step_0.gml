// these instances are managed by o_resource_area_manager

if (timePassed == duration){
    // Movement finished
    timePassed = 0 
    instance_destroy(id)
    
} else {
    timePassed += 1
    var interpolation = timePassed / duration 
    
    var position = animcurve_channel_evaluate(movement, interpolation)    
    var position2 = animcurve_channel_evaluate(scale, interpolation)
    x = lerp(origin.x, target.x, position)
    y = lerp(origin.y, target.y, position)
    
    image_xscale = lerp(1, targetScale, -position2)
    image_yscale = lerp(1, targetScale, -position2)
}
