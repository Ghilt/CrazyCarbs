stability = [0, 0]
fatigueDamage = 0
fatigueRate = one_second
fatigueTimeLimit = one_second * 20


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

stabilityProgression = function(player) {
    // 7 more max stability each round
    return o_game_phase_manager.gameRound * 7 + 30
}

goToBattle = function (player){
    stability[Player.US] = stabilityProgression(Player.US)
    stability[Player.THEM] = stabilityProgression(Player.THEM)
}

stabilize = function(stabilizeBy, player) {
    stability[player] = clamp(stability[player] + stabilizeBy, 0, stabilityProgression(player))
}

destabilize = function(destabilizeBy, player) {
    stability[player] = clamp(stability[player] - destabilizeBy, 0, stabilityProgression(player))
}

inFatigue = function() {
    return o_game_phase_manager.battleDuration > fatigueTimeLimit
}

takeFatigueDamage = function() {
    fatigueDamage += 1
    destabilize(fatigueDamage, Player.US)
    destabilize(fatigueDamage, Player.THEM)
}