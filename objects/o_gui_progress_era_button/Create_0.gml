// TODO skip this button entirely and have it diagetic instead?

pressed = 0

guiState = new GuiState(x, y, x, guiYBot + sprite_height )

//mov = {
    //duration: one_second * 1,
    //timePassed: 0,
    //originX: x,
    //originY: y
//}
//
//buildPos = { x, y }
//battlePos = { x, y : guiYBot + sprite_height }

pressedButton = function pressedButton() {
    o_game_phase_manager.goToBattle()
}

