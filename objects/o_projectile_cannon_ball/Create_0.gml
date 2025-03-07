/* Damage deliverer, created with:
 * target - instance, unit
 * origin - instance, unit
 * damage - real
 */

duration = one_second * 1.2
timePassed = 0

movement = animcurve_get_channel(c_cannon_ball_arc, "inPlane")
scale = animcurve_get_channel(c_cannon_ball_arc, "arc")

startScale = 0.1
endScale = 0.3
image_xscale = startScale
image_yscale = startScale

lastTargetPos = instancePosition(target)