#macro mouseGuiX device_mouse_x_to_gui(0) 
#macro mouseGuiY device_mouse_y_to_gui(0) 

#macro guiWidth view_get_wport(view_current)
#macro guiHeight view_get_hport(view_current)
#macro guiXMid guiWidth / 2
#macro guiYBot view_get_hport(view_current)
#macro guiYMid guiYBot / 2

#macro one_second game_get_speed(gamespeed_fps)


function ppp(){
    var _str = "";

    for (var i = 0; i < argument_count; i ++)
    {
        _str += " | "+ string(argument[i]);
    }

    show_debug_message(_str);
}

/// Isometric constants

#macro MAP_W 100
#macro MAP_H 100
#macro TILE_W 64 
#macro TILE_H 32
#macro CAMERA_W 1280
#macro CAMERA_H 720