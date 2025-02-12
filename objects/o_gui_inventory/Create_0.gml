

buildPos = { x, y }
battlePos = { x, y : guiYBot - 60 }


function initialize() {
    var inventory = object_get_sprite(o_gui_inventory)
    instance_create_layer(guiXMid - sprite_get_width(inventory) / 2, guiYBot - sprite_get_height(inventory), "Gui", o_gui_inventory)
}