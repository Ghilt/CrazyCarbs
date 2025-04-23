ppp(id, "Creating building at:", x, y, "Rotated:", buildingRotated, type)

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

getBuildingDescription = function(){
     return "todo " + string(id)
}