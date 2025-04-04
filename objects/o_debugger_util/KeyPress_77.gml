var cam = view_get_camera(view_current)
ppp("________________ |")

// this is not it chief, show_debug_message("Display space  x: " + string(display_mouse_get_x()) + " y: " + string(display_mouse_get_y()))

show_debug_message("Mouse world space x: " + string(mouse_x) + "/" + string(room_width) + " y: " + string(mouse_y) + "/" + string(room_height))
show_debug_message("Mouse gui space  x: " + string(mouseGuiX) + "/" + string(display_get_gui_width()) + 
                            " y: " + string(mouseGuiY) + "/" + string(display_get_gui_height()))

var convertedXY = o_zoom_manager.convertToGuiSpace(mouse_x, mouse_y)
show_debug_message("x/y to gui x/y: " + string(mouse_x) + ", " + string(mouse_y) + " -> " + string(convertedXY.x) 
                        + ", " + string(convertedXY.y) + "  -->  real mouse gui x/y: " + string(mouseGuiX) + ", " + string(mouseGuiY))

var convertedToWorldXY = o_zoom_manager.convertToWorldSpace({ x: mouseGuiX, y: mouseGuiY })
show_debug_message("gui x/y to x/y: " + string(mouseGuiX) + ", " + string(mouseGuiY) + " -> " + string(convertedToWorldXY.x) 
                        + ", " + string(convertedToWorldXY.y) + "  -->  real mouse world x/y: " + string(mouse_x) + ", " + string(mouse_y))

show_debug_message("Camera     x/y : " + string(camera_get_view_x(cam)) + "/" + string(camera_get_view_y(cam)))
show_debug_message("Camera gui w/h : " + string(display_get_gui_width()) + "/" + string(display_get_gui_height()))
show_debug_message("Camera     w/h : " + string(camera_get_view_width(cam)) + "/" + string(camera_get_view_height(cam)))

var isoToRoomMap = isoToRoom(mouse_x, mouse_y)
show_debug_message("IsoToRoom     x/y : " + string(isoToRoomMap) )
show_debug_message("Tile          x/y : " + string(isoToRoomMap.x div TILE_SIZE) + "/" + string(isoToRoomMap.y div TILE_SIZE) )

var camIsoToRoomMap = isoToRoom(camera_get_view_x(cam), camera_get_view_y(cam))
show_debug_message("Cam topleft Tile          x/y : " + string(camIsoToRoomMap.x div TILE_SIZE) + "/" + string(camIsoToRoomMap.y div TILE_SIZE) )

show_debug_message("closest buildable spot: " + string(o_influence_grid_manager.getClosestBuildableSpot(mouse_x, mouse_y, { width: 1, height: 1})))

