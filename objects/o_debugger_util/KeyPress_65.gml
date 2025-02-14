var spots = o_influence_grid_manager.influenceGrid

for (var i = 0; i < array_length(spots); i++) {
    if (spots[i].occupiedBy) {
        continue;
    }
    o_influence_grid_manager.buildAt(spots[i], irandom_range(0, 1))
}