show_debug_message("Mouse x: " + string(mouse_x) + " y: " + string(mouse_y) )
show_debug_message("Display space  x: " + string(display_mouse_get_x()) + " y: " + string(display_mouse_get_y()))
show_debug_message("gui space  x: " + string(device_mouse_x_to_gui(0)) + "/" + string(display_get_gui_width()) + 
                             " y: " + string(device_mouse_y_to_gui(0)) + "/" + string(display_get_gui_height()))