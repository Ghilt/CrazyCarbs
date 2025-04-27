ppp(id, "Creating building at:", x, y, "Rotated:", buildingRotated, type)

isDefeated = false

// Base stats are stored in a struct outside of instance itself for easier access when there e.g. are no instances
stats = global.buildings[? type].baseStats

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
     return global.buildings[? type].getBaseDescription()
}