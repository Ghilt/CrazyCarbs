/// @desc Convenience function that allows for gui-like animaitons in the world to work in isoProjection and withouth
/// @param {{ x: number, y: number }} pos - The position object containing x and y coordinates.
/// @param {number} pixelsUp how many pixels the returned pos will be moved
/// @returns {{ x: number, y: number }} - A new position object shifted up by the specified pixels (roughly).
function projectionIndependentGuiUp(pos, pixelsUp) {
    if (o_debugger_util.isoProjection) {
        return { x: pos.x - pixelsUp, y: pos.y - pixelsUp }
    } else {
        return { x: pos.x , y: pos.y - pixelsUp } 
    }
}

function isoMouse() {
    var isoSpace = isoToRoom(mouse_x, mouse_y)
    return { x: isoSpace.x, y: isoSpace.y }
}