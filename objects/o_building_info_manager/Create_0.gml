infoBackground = instance_create_layer(0, 0, "Gui", o_gui_building_info)
infoBackground.depth = -1000
infoBackground.image_xscale = 6
infoBackground.image_yscale = 4

hovering = false

hoverData = {
    effectDescription: ""
}

// Accepts placeable instance
// TODO accepts building
hover = function(instance, tile = false){
    if (!hovering){
        o_effects_manager.buildInfoHoverFeedback()
    }
    
    var xPos = mouseGuiX - infoBackground.sprite_width - 220 * o_zoom_manager.getZoomPercentage()
    if (xPos < 0) {
        xPos = mouseGuiX + 220 * o_zoom_manager.getZoomPercentage()
    }
    
    var yPos = clamp(mouseGuiY - infoBackground.sprite_height / 2, 0, guiHeight - infoBackground.sprite_height)
    

    infoBackground.x = xPos
    infoBackground.y = yPos
    
    hoverData.effectDescription = instance.getBuildingDescription()
    hovering = true
}

resetHover = function(){
    hovering = false
}

getEffectDescription = function () {
    return hoverData.effectDescription
}

