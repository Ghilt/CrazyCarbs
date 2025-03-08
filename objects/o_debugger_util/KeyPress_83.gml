if (o_game_phase_manager.isBattlePhase()) {
    ppp("Not supported right now, but could be usefull to spawn stuff in the middle of battle properly")
    return;
}

var spots = o_influence_grid_manager.influenceGrid[Player.US]

for (var i = 0; i < array_length(spots); i++) {
    if (spots[i].occupiedBy) {
        continue;
    }
    o_influence_grid_manager.buildAt(spots[i], randomBuilding(spots[i].terrain))
}

o_game_phase_manager.goToBattle()
