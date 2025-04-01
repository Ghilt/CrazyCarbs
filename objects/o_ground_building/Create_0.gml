ppp("Creating building at:", x, y, "Rotated:", buildingRotated)

isDefeated = false

resetAfterBattle = function(origin) {
    // No action needed
}

hitByProjectile = function(damage) {
    o_stability_manager.destabilize(damage, player)
}

adjacencyUpdate = function(adjacentDistricts) {
    // Implemented in children    
}