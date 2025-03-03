function GuiStateDynamic(originX, originY, buildPosX, buildPosY, battlePosX, battlePosY) constructor
{
    mov = {
        duration: one_second * 1,
        timePassed: 0,
        originX: originX,
        originY: originY
    }
    
    
    buildPos = { x: buildPosX, y: buildPosY }
    battlePos = { x: battlePosX, y: battlePosY }
}

function GuiState(originX, originY, battlePosX, battlePosY) : GuiStateDynamic(originX, originY, originX, originY, battlePosX, battlePosY) constructor
{
    // ui components always start in build mode, there are no interaction which create new ui elements when in battle
}


