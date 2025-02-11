var inventory = object_get_sprite(o_gui_inventory)
var progressButton = object_get_sprite(o_gui_progress_era_button)

instance_create_layer(guiXMid - sprite_get_width(inventory) / 2, guiYBot - sprite_get_height(inventory), "Gui", o_gui_inventory)

instance_create_layer(guiWidth - sprite_get_width(progressButton), guiYBot - sprite_get_height(progressButton), "Gui", o_gui_progress_era_button)