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
        }
    break;

    case Carry.ClickCarry:
        if (time > threshold)
            carry = 2
    
        if (time == 1)
            carry = 0
    break;

    case Carry.HoldCarry:
        if (time == -1)
            carry = 0;
    break;
}

if (carry > 0) {
    x = lerp(x, mouseGuiX - sprite_width / 2, smoothCarry)
    y = lerp(y, mouseGuiY - sprite_height / 2, smoothCarry)
    
    image_xscale = lerp(image_xscale, o_zoom_manager.getZoomPercentage(), smoothScale)
    image_yscale = lerp(image_yscale, o_zoom_manager.getZoomPercentage(), smoothScale)
    
} 