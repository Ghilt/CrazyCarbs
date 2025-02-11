if (device_mouse_check_button(0, mb_left) && position_meeting(mouseGuiX, mouseGuiY, id) ) {
    pressed = max(pressed, 1)   
    image_xscale = lerp(image_xscale, 0.8, 0.7)
    image_yscale = lerp(image_yscale, 0.8, 0.7)
} else if (pressed != 0) {
    pressed = 0
    pressedButton()
} else {
    image_xscale = lerp(image_xscale, 1, 0.7)
    image_yscale = lerp(image_yscale, 1, 0.7)
}