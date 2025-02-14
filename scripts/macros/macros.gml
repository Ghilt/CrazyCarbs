#macro mouseGuiX device_mouse_x_to_gui(0) 
#macro mouseGuiY device_mouse_y_to_gui(0) 
#macro dprint show_debug_message("Dprint : " + string(303))

#macro guiWidth view_get_wport(view_current)
#macro guiXMid guiWidth / 2
#macro guiYBot view_get_hport(view_current)
#macro guiYMid guiYBot / 2

#macro one_second game_get_speed(gamespeed_fps)


function ppp(){
    var _str = "";

    for (var i = 0; i < argument_count; i ++)
    {
        _str += string(argument[i]);
    }

    show_debug_message(_str);
}
