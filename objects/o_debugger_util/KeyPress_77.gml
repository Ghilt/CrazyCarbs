
show_debug_message("camera details: x" + string(camera_get_view_x(cam)) + " y: " + string(camera_get_view_y(cam)))
show_debug_message("Mouse x: " + string(mouse_x) + " y: " + string(mouse_y) )
show_debug_message("Display space  x: " + string(display_mouse_get_x()) + " y: " + string(display_mouse_get_y()))
show_debug_message("gui space  x: " + string(mouseGuiX) + "/" + string(display_get_gui_width()) + 
                            " y: " + string(mouseGuiY) + "/" + string(display_get_gui_height()))
var convertedXY = convertToGuiSpace(mouse_x, mouse_y)
show_debug_message("x/y to gui x/y: " + string(mouse_x) + ", " + string(mouse_y) + " -> " + string(convertedXY.x) + ", " + string(convertedXY.y) + " real mouse gui x/y: " + string(mouseGuiX) + ", " + string(mouseGuiY))