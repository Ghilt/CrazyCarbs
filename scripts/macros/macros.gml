#macro mouseGuiX device_mouse_x_to_gui(0) 
#macro mouseGuiY device_mouse_y_to_gui(0) 
#macro dprint show_debug_message("Dprint : " + string(303))

#macro guiWidth camera_get_view_width(view_get_camera(view_current))
#macro guiXMid guiWidth / 2
#macro guiYBot camera_get_view_height(view_get_camera(view_current))
#macro guiYMid guiYBot / 2



function ppp(thing1 = "", thing2 = "", thing3 = "", thing4 = "" , thing5 = "") {
    var toPrint ="Debug: "
     if (thing1 == "") {
        show_debug_message("Hit!")
        return;
    } else {
        toPrint = toPrint + string(thing1)
    }
    
    if (thing2 != "") {
        toPrint = toPrint + " | " + string(thing2)
    }
    
    if (thing3 != "") {
        toPrint = toPrint + " | " + string(thing3)
    }
    
    if (thing4 != "") {
        toPrint = toPrint + " : " + string(thing4)
    }
    
        if (thing5 != "") {
        toPrint = toPrint + " | " + string(thing5)
    }
    
    show_debug_message(toPrint)
}