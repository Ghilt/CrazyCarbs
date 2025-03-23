image_speed = 0


hull = stats.hull
weaponCooldown = global.shipTargetingTime
isDefeated = false

// Origin is supplied by the influence manager, which manages where this unit is built
resetAfterBattle = function() {
    x = origin.x
    y = origin.y
    hull = stats.hull
    weaponCooldown = global.shipTargetingTime
    isDefeated = false
}

moveTowards = function(pos, speedModifier) {
    var displacement = vectorSubtract(pos, instancePosition(id))
    
    //image index of sprite lines up with the Direction enum
    image_index = vectorQuadrant(displacement)
    
    var moveSpeed = o_buff_debuff_manager.getWeatherSpeedBoost(stats.getSpeedValue() * speedModifier, player)
    
    mp_linear_step(pos.x, pos.y, moveSpeed, false)
}

fireWeapon = function(enemyInstance) {
    weaponCooldown -= 1
    
    if (weaponCooldown == 0) {
        weaponCooldown = stats.weaponCooldown
        
        var hit = runWeaponHitCalculator(enemyInstance)
        if (hit) {
            // Maybe it would make more sense to have this calculation later, on the actual hit. Can take into consideration damage mitigation and stuff
            o_buff_debuff_manager.triggerPatriotism(stats.damage, player) 
        }
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemyInstance, origin: id, damage: stats.damage, isHit: hit })
    } 
}

hitByProjectile = function(damage){
    hull -= damage
    
    if (hull <= 0) {
        destroyedByDamage()
    }
}

destroyedByDamage = function() {
    x = origin.x
    y = origin.y
    isDefeated = true
}

participateInBlockade = function () {
    weaponCooldown -= 1
    
    if (weaponCooldown == 0) {
        weaponCooldown = stats.weaponCooldown
        
        var opponent = getOpponentOf(player)
        var enemyBase = o_influence_grid_manager.getRandomPopulatedShoreDistrict(opponent).occupiedBy
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemyBase, origin: id, damage: stats.blockadeDamage })
    } 
}

runWeaponHitCalculator = function(enemyInstance) {
    var coinToss = random_range(0, 1)
    var evasion = o_buff_debuff_manager.getWeatherEvasionBoost(enemyInstance.stats.evasion, enemyInstance.player)
    return coinToss > evasion
}