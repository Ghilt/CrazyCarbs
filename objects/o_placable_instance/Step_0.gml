if (device_mouse_check_button(0, mb_left)) {
    time = max(time, 0)
    time++;
}
else if (time > 0) {
    time = -1;
}
else {
    time = 0;
}

switch (carry) {
    case Carry.None:
        if (position_meeting(mouseGuiX, mouseGuiY, event_object) && time == 1) {
            carry = Carry.ClickCarry;
        } else {
            // return to inventory
            x = lerp(x, originX, smoothCarry * 0.2)
            y = lerp(y, originY, smoothCarry * 0.2)
            
            image_xscale = lerp(image_xscale, 1, smoothScale * 0.2)
            image_yscale = lerp(image_yscale, 1, smoothScale * 0.2)
        }
    break;

    case Carry.ClickCarry:
        if (time > pickupFrameThreshold)
            carry = 2
    
        if (time == 1)
            carry = 0
    break;

    case Carry.HoldCarry:
        if (time == -1)
            carry = 0;
    break;
}


var closestPos = o_influence_grid_manager.getClosestBuildableSpot(mouse_x - sprite_width / 2, mouse_y - sprite_height / 2)


 if (carry == Carry.ClickCarry || carry == Carry.HoldCarry) {
    
    if (closestPos.distance < buildSnappingRange) {
        var inGuiSpace = o_zoom_manager.convertToGuiSpace(closestPos.x, closestPos.y)
        
        x = lerp(x, inGuiSpace.x, smoothCarry)
        y = lerp(y, inGuiSpace.y, smoothCarry)
    } else {
        x = lerp(x, mouseGuiX - sprite_width / 2, smoothCarry)
        y = lerp(y, mouseGuiY - sprite_height / 2, smoothCarry)
    }
    
    
    image_xscale = lerp(image_xscale, o_zoom_manager.getZoomPercentage(), smoothScale)
    image_yscale = lerp(image_yscale, o_zoom_manager.getZoomPercentage(), smoothScale)
} 