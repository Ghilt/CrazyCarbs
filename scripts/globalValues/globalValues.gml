#macro mouseGuiX device_mouse_x_to_gui(0) 
#macro mouseGuiY device_mouse_y_to_gui(0) 

#macro guiWidth view_get_wport(view_current)
#macro guiHeight view_get_hport(view_current)
#macro guiXMid guiWidth / 2
#macro guiYBot view_get_hport(view_current)
#macro guiYMid guiYBot / 2

#macro one_second game_get_speed(gamespeed_fps)

#macro itemSize sprite_get_height(object_get_sprite(o_placable_instance))

/// Isometric constants

#macro MAP_W 100
#macro MAP_H 100
#macro tileSize 64
#macro CAMERA_W 1280
#macro CAMERA_H 720

#macro ISO_ORIGIN { x: 3200, y: -2432 }
#macro ISO_W (4/3)
#macro ISO_H 1

#macro MAX_INT 2147483647