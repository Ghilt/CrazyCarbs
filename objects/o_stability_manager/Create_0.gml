maxStability = 100
stability = 0

goToBattle = function (){
    stability = 100
}

var meter = object_get_sprite(o_gui_stability_meter)
var meterHeight = sprite_get_width(meter)

instance_create_layer(0 - 64, guiYMid - meterHeight / 2, "Gui", o_gui_stability_meter)