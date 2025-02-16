// these instances are managed by o_resource_area_manager

if (timePassed == duration){
    // Movement finished
    // play the sound
} else {
    timePassed += 1
    var interpolation = timePassed / duration 
    
    var position = animcurve_channel_evaluate(curveMovement, interpolation)    
    var position2 = animcurve_channel_evaluate(curveScale, interpolation)
    x = lerp(origin.x, target.x, position)
    y = lerp(origin.y, target.y, position)
    
    image_xscale = lerp(0.2, 1, position2)
    image_yscale = lerp(0.2, 1, position2)
}
