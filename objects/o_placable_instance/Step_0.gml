if (device_mouse_check_button_pressed(0, mb_left) && position_meeting(mouseGuiX, mouseGuiY, event_object)) {
    carried = !carried
    show_debug_message("Should i carry item : " + string(carried))
}

if (carried) {
    x = lerp(x, mouseGuiX - sprite_width / 2, snappiness)
    y = lerp(y, mouseGuiY - sprite_height / 2, snappiness)
} 