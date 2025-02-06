cam = view_get_camera(view_current)
ratio = camera_get_view_width(cam) / camera_get_view_height(cam)

scrollSpeed = 1

minHeight = 100
maxHeight = 10000
minWidth = 100 * ratio
maxWidth = 10000 * ratio

function zoomIt(directionIn) {
    var currentCameraX = camera_get_view_x(cam)
    var currentCameraY = camera_get_view_y(cam)
    var currentCameraWidth = camera_get_view_width(cam)
    var currentCameraHeight = camera_get_view_height(cam)
    var zoomTargetXPercent = device_mouse_x_to_gui(0) / display_get_gui_width()
    var zoomTargetYPercent = device_mouse_y_to_gui(0) / display_get_gui_height()
     
    var widthChange = scrollSpeed * currentCameraWidth * 0.3
    var heightChange = scrollSpeed * currentCameraHeight * 0.3 
     
    if (directionIn) {
        widthChange *= -1
        heightChange *= -1
    } 
    
    var newWidth = clamp(currentCameraWidth + widthChange, minWidth, maxWidth)
    var newHeight = clamp(currentCameraHeight + heightChange, minHeight, maxHeight)
    
    var newX = clamp(currentCameraX - zoomTargetXPercent * widthChange , 0, maxWidth)
    var newY = clamp(currentCameraY - zoomTargetYPercent * heightChange, 0, maxHeight)
    
    camera_set_view_size(cam, newWidth, newHeight)
    camera_set_view_pos(cam, newX, newY)
}