ppp("Creating building at", x, y)

//
isDefeated = false

resetAfterBattle = function(origin) {
    // No action needed   
}

hitByProjectile = function(damage) {
    o_stability_manager.destabilize(damage, player)
}