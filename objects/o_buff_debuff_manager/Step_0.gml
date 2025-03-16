var peaceTick = o_game_phase_manager.battleDuration mod o_buff_debuff_manager.peaceRate == 0
if (peaceTick) {
    triggerPeace(Player.THEM)
    triggerPeace(Player.US)
}

var dreadTick = o_game_phase_manager.battleDuration mod o_buff_debuff_manager.dreadRate == 0
if (dreadTick) {
    triggerDread(Player.THEM)
    triggerDread(Player.US)
}