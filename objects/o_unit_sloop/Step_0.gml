if (!o_game_phase_manager.isBattlePhase() || isDestroyed) {
    return;
}

var enemyToEngageData = o_pathing_manager.getClosestEnemyWithinEngageRange(id); // TODO later optimaztion to not do this search every step

if (!enemyToEngageData || enemyToEngageData.distance > stats.range) {
    o_pathing_manager.moveTowardsShipOrBase(id, enemyToEngageData ? enemyToEngageData.enemy : false)
} else {
    fireWeapon(enemyToEngageData.enemy)
}
