if (mouse_check_button(mb_right)) {
    
    var deltaX = mouse_x - previousMouseX
    var deltaY = mouse_y - previousMouseY
    
    var cameraPosMaxX = room_width - camera_get_view_width(cam)
    var cameraPosMaxY = room_height - camera_get_view_height(cam)
    
    var newX = clamp(camera_get_view_x(cam) - deltaX, 0, cameraPosMaxX)
    var newY = clamp(camera_get_view_y(cam) - deltaY, 0, cameraPosMaxY)
    
    camera_set_view_pos(cam, newX, newY)
    
    previousMouseX = mouse_x
    previousMouseY = mouse_y
}