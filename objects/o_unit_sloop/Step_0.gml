if (!o_game_phase_manager.isBattlePhase()) {
    return;
}

var enemyToEngage = o_pathing_manager.getClosestEnemyWithinEngageRange(id); // TODO later optimaztion to not do this search every step

if (!enemyToEngage || enemyToEngage.distance > stats.range) {
    o_pathing_manager.moveTowardsShipOrBase(id, enemyToEngage ? enemyToEngage.enemy : false)
} else {
    fireWeapon(enemyToEngage)
}
