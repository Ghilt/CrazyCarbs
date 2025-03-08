maxStability = [100, 100]
stability = [0, 0]

goToBattle = function (){
    stability[Player.US] = maxStability[Player.US]
    stability[Player.THEM] = maxStability[Player.THEM]
}

var meter = object_get_sprite(o_gui_stability_meter)
var meterWidth = sprite_get_width(meter)
var meterHeight = sprite_get_height(meter)

var stabilityMeterY =  guiYMid - meterHeight / 2
var usPositionData = {
    player: Player.US,
    guiState: new GuiState(-meterWidth, stabilityMeterY, meterWidth/2, stabilityMeterY)
}

var themPositionData = {
    player: Player.THEM,
    guiState: new GuiState(guiWidth, stabilityMeterY, guiWidth - meterWidth * 3/2, stabilityMeterY)

}

meters = [
  instance_create_layer(usPositionData.guiState.buildPos.x, stabilityMeterY, "Gui", o_gui_stability_meter, usPositionData),
  instance_create_layer(themPositionData.guiState.buildPos.x, stabilityMeterY,"Gui", o_gui_stability_meter, themPositionData)
]


stabilize = function(stabilizeBy, player) {
    stability[player] = clamp(stability[player] + stabilizeBy, 0, maxStability[player])
}

destabilize = function(destabilizeBy, player) {
    stability[player] = clamp(stability[player] - destabilizeBy, 0, maxStability[player])
}