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
#macro TAG_INDUSTRY "industry"

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