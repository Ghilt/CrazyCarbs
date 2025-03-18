if (!o_game_phase_manager.isBattlePhase() || isDefeated) {
    return;
}

var enemyToEngageData = o_pathing_manager.getClosestEnemyWithinEngageRange(id); // TODO later optimaztion to not do this search every step

if (!enemyToEngageData || enemyToEngageData.distance > stats.range) {
    var distanceToEnemyBase = o_influence_grid_manager.distanceToBase(id, getOpponentOf(player))
    if (distanceToEnemyBase < stats.blockadeRange) {
        o_pathing_manager.blockade(id)
        participateInBlockade()
    } else {
        o_pathing_manager.moveTowardsShipOrBase(id, enemyToEngageData ? enemyToEngageData.instance : false)
    }
} else {
    fireWeapon(enemyToEngageData.instance)
}