
var spots = o_influence_grid_manager.influenceGrid[Player.US]

for (var i = 0; i < array_length(spots); i++) {
    if (spots[i].occupiedBy) {
        continue;
    }
    o_influence_grid_manager.buildAt(spots[i], irandom_range(1, 2))
}

o_game_phase_manager.goToBattle()
