
cam = view_get_camera(view_current)
ratio = camera_get_view_width(cam) / camera_get_view_height(cam)

baseWidth = camera_get_view_width(cam)
baseHeight = camera_get_view_height(cam)



scrollSpeed = 0.8

minWidth = 1000 * ratio
minHeight = 1000

previousMouseX = mouse_x
previousMouseY = mouse_y

ppp("Using view: ", view_current, ratio, baseWidth, baseHeight)


getViewportCameraSizeDifferenceRatio = function(){ // only needed if viewPort and camera are different sizes
    return view_get_wport(view_current) / baseWidth;
}

getZoomPercentage = function(){
    return baseWidth / camera_get_view_width(cam);
}

getZoomScale = function(){
    return camera_get_view_width(cam) / baseWidth;
}

convertToGuiSpace = function(pX, pY) {
    var gX = (pX - camera_get_view_x(cam)) / camera_get_view_width(cam)
    var gY = (pY - camera_get_view_y(cam)) / camera_get_view_height(cam)
    return { x: gX * display_get_gui_width(), y: gY * display_get_gui_height() }
}

convertToWorldSpace = function(pos) {
    var currentCameraX = camera_get_view_x(cam)
    var currentCameraY = camera_get_view_y(cam)
    var scaleX = camera_get_view_width(cam) / guiWidth
    var scaleY = camera_get_view_height(cam) / guiHeight
    
    return { x: currentCameraX + pos.x * scaleX, y: currentCameraY + pos.y * scaleY }
}

convertToGuiSpaceDistance = function(pX, pY) {
    var gX = pX / camera_get_view_width(cam)
    var gY = pY / camera_get_view_height(cam)
    return { x: gX * display_get_gui_width(), y: gY * display_get_gui_height() }
}


zoomIt = function(directionIn) {
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
    var noZoomHappened = int64(newWidth) == int64(currentCameraWidth)
    
    if (noZoomHappened || newWidth > room_width || newHeight > room_height) {
        return;
    }
    
    var cameraPosMaxX = room_width - newWidth
    var cameraPosMaxY = room_height - newHeight
    
    var newX = clamp(currentCameraX - zoomTargetXPercent * widthChange , 0, cameraPosMaxX)
    var newY = clamp(currentCameraY - zoomTargetYPercent * heightChange, 0, cameraPosMaxY)
     
    camera_set_view_size(cam, newWidth, newHeight)
    camera_set_view_pos(cam, newX, newY)
    
}

centerOn = function (pos) {
    camera_set_view_pos(cam, pos.x, pos.y)
}

debugChangeProjection = function(isoProjection) {
    var camX = camera_get_view_x(cam) 
    var camY = camera_get_view_y(cam)
    

    
    if (isoProjection) {
        var posInOtherProjection = roomToIso(camX, camY)
        // values to shift the came probably depends on iso ratio
        var moveCamHalfALengthLeft = posInOtherProjection.x - camera_get_view_width(cam) / 4
        var moveCamHalfALengthDown = posInOtherProjection.y + camera_get_view_height(cam) / 1.5
        posInOtherProjection = { x: moveCamHalfALengthLeft, y: moveCamHalfALengthDown}
        camera_set_view_pos(cam, posInOtherProjection.x, posInOtherProjection.y)
    } else {
        var isoToRoomMap = debug_isoToRoom(camX, camY) // important to use the debug version here; since it doesnt get disabled by the debug projection flag
        var tile = { x: isoToRoomMap.x/TILE_SIZE, y: isoToRoomMap.y/TILE_SIZE }
        var posInOtherProjection = tileToIso(tile.x, tile.y)
        
        var moveCamHalfALengthLeft = posInOtherProjection.x - camera_get_view_width(cam) / 8
        var moveCamHalfALengthDown = posInOtherProjection.y - camera_get_view_height(cam) / 2
        posInOtherProjection = { x: moveCamHalfALengthLeft, y: moveCamHalfALengthDown}
        camera_set_view_pos(cam, posInOtherProjection.x, posInOtherProjection.y)
    }
    
}