if (device_mouse_check_button(0, mb_left) ) {
    time = max(time, 0)
    time++;
}
else if (time > 0) {
    time = -1;
}
else {
    time = 0;
}

var closestPos = o_influence_grid_manager.getClosestBuildableSpot(mouse_x - originalWidth / 2, mouse_y - originalHeight / 2)

switch (carry) {
    case Carry.None:
        if (position_meeting(mouseGuiX, mouseGuiY, self) && time == 1) {
            carry = Carry.ClickCarry
        } else if (action == Action.None) {
            // return to inventory
            x = lerp(x, originX, smoothCarry * 0.2)
            y = lerp(y, originY, smoothCarry * 0.2)
            
            image_xscale = lerp(image_xscale, 1, smoothScale * 0.2)
            image_yscale = lerp(image_yscale, 1, smoothScale * 0.2)
        } else {
            placeInstance(closestPos) // Allow slight graphical inconsistency here for now; if you click before it has lerped all the way to the building site. IT will still work
        }
    break;
    case Carry.ClickCarry:
        if (time > pickupFrameThreshold)
            carry = Carry.HoldCarry
    
        if (time == 1)
            carry = Carry.None
    break;

    case Carry.HoldCarry:
        if (time == -1)
            carry = Carry.None
    break;
}

if (carry == Carry.ClickCarry || carry == Carry.HoldCarry) {
    
    if (closestPos.distance < buildSnappingRange) {
        // Lets prepare to build it!
        var inGuiSpace = o_zoom_manager.convertToGuiSpace(closestPos.x, closestPos.y)
        x = lerp(x, inGuiSpace.x, smoothCarry)
        y = lerp(y, inGuiSpace.y, smoothCarry)
        action = Action.Build
    } else {
        x = lerp(x, mouseGuiX - sprite_width / 2, smoothCarry)
        y = lerp(y, mouseGuiY - sprite_height / 2, smoothCarry)
        action = Action.None
    }
    
    var zoomPercent = o_zoom_manager.getZoomPercentage()
    var cameraViewPortDiff = o_zoom_manager.getViewportCameraSizeDifferenceRatio()
    
    image_xscale = lerp(image_xscale, zoomPercent * cameraViewPortDiff, smoothScale)
    image_yscale = lerp(image_yscale, zoomPercent * cameraViewPortDiff, smoothScale)
} 