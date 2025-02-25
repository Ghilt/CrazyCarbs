if (position_meeting(mouseGuiX, mouseGuiY, id) && device_mouse_check_button(0, mb_left)) {
    instance_destroy(id)
}