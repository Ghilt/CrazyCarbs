cam = view_get_camera(view_current)
ratio = camera_get_view_width(cam) / camera_get_view_height(cam)

scrollSpeed = 0.5

minHeight = 200
minWidth = 200 * ratio

previousMouseX = mouse_x
previousMouseY = mouse_y

// debug log: show_debug_message("value : " + string())


function zoomIt(directionIn) {
    var currentCameraX = camera_get_view_x(cam)
    var currentCameraY = camera_get_view_y(cam)
    var currentCameraWidth = camera_get_view_width(cam)
    var currentCameraHeight = camera_get_view_height(cam)
    var zoomTargetXPercent = mouseGuiX / display_get_gui_width()
    var zoomTargetYPercent = mouseGuiY / display_get_gui_height()
     
    var widthChange = scrollSpeed * currentCameraWidth * 0.3
    var heightChange = scrollSpeed * currentCameraHeight * 0.3 
     
    if (directionIn) {
        widthChange *= -1
        heightChange *= -1
    } 
    
    // max over clamp here to exit out with '||' below to avoid aspect ratio mattering
    var newWidth = max(currentCameraWidth + widthChange, minWidth)
    var newHeight = max(currentCameraHeight + heightChange, minHeight)
    var noZoomHAppened = int64(newWidth) == int64(currentCameraWidth)
    
    if (noZoomHAppened || newWidth > room_width || newHeight > room_height) {
        return;
    }
    
    var cameraPosMaxX = room_width - newWidth
    var cameraPosMaxY = room_height - newHeight
    
    var newX = clamp(currentCameraX - zoomTargetXPercent * widthChange , 0, cameraPosMaxX)
    var newY = clamp(currentCameraY - zoomTargetYPercent * heightChange, 0, cameraPosMaxY)
     
    camera_set_view_size(cam, newWidth, newHeight)
    camera_set_view_pos(cam, newX, newY)
    
}