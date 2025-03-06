var enemyToEngage = o_pathing_manager.getClosestEnemyWithinEngageRange(id); // TODO later optimaztion to not do this search every step

if (!enemyToEngage || enemyToEngage.distance > range) {
    o_pathing_manager.moveTowardsShipOrBase(id, enemyToEngage ? enemyToEngage.enemy : false)
} else {
    // attack!
}
