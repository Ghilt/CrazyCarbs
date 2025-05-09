sprite_index = initSprite
depth = -1000 // this is a bit dirty temp fix; I jsut set this depth whenever a ui layer instance is not drawn ontop of what i want
// searching in code base on 'depth = -1000' should be good if i ever want to clean this shorcut up 

if (player == Player.US) {
    guiState = new GuiState(x, y, x + boardAnchorDimensions.width, y - boardAnchorDimensions.height)
} else {
    guiState = new GuiState(x, y, x - boardAnchorDimensions.width, y - boardAnchorDimensions.height)
}


xTextOffset = 92
yTextOffset = 2