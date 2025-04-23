infoBackground = instance_create_layer(0, 0, "Gui", o_gui_building_info)
infoBackground.depth = -1000
infoBackground.image_xscale = 10
infoBackground.image_yscale = 8

hovering = false

hoverData = {
    effectDescription: ""
}

// Accepts placeable instance
// Todo accepts building
hover = function(instance, tile = false){
    if (!hovering){
        o_effects_manager.buildInfoHoverFeedback()
    }
    hoverData.effectDescription = instance.getBuildingDescription()
    hovering = true
}

resetHover = function(){
    hovering = false
}

getEffectDescription = function () {
    return hoverData.effectDescription
}