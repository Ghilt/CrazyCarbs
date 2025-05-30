#macro mouseGuiX device_mouse_x_to_gui(0) 
#macro mouseGuiY device_mouse_y_to_gui(0) 
#macro mousePos { x: mouse_x, y: mouse_y }
#macro mouseGuiPos { x: device_mouse_x_to_gui(0), y: device_mouse_y_to_gui(0) }

#macro guiWidth view_get_wport(view_current)
#macro guiHeight view_get_hport(view_current)
#macro guiXMid guiWidth / 2
#macro guiYBot view_get_hport(view_current)
#macro guiYMid guiYBot / 2

#macro one_second game_get_speed(gamespeed_fps)

#macro itemSize 128 // gui size value

#macro guiResourceSize 32

/// Isometric constants

#macro MAP_W 200
#macro MAP_H 200
#macro TILE_SIZE 256
#macro CAMERA_W 1280
#macro CAMERA_H 720

#macro ISO_ORIGIN { x: TILE_SIZE * MAP_W / 2, y: - 0.38 * MAP_H * TILE_SIZE }
#macro ISO_W (4/3)
#macro ISO_H 1

#macro MAX_INT 2147483647

// Buidling tags - Tag names
#macro TAG_NATURE "nature"
#macro TAG_SHIP "ship"
#macro TAG_INDUSTRY "industry"

// Order of this enum matters; didn't bother with a map when initializing counters in o_gui_buff_debuff_info
enum Modifier
{
    PATRIOTISM, // buffs
    WEATHER,
    MORALE,
    PEACE,
    PROSPERITY,
    MYSTICISM,
    RECKLESSNESS, // debuffs
    SCURVY,
    DREAD,
    FAMINE
};