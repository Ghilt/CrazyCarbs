stats = {
    hull: 100,
    damage: 50,
    range: 200,
    speed: 3,
    blockadeRange: 200, // This is a cosmetic value which only affacts how the blockade will look
    weaponReadiness: 20, // before firing weapon for the first time
    weaponCooldown: one_second * 2 
}

hull = stats.hull
weaponCooldown = stats.weaponReadiness
isDefeated = false

resetAfterBattle = function() {
    x = origin.x
    y = origin.y
    isDefeated = false
}

moveTowards = function(pos) {
    mp_linear_step(pos.x, pos.y, stats.speed, false)
}

fireWeapon = function(enemy) {
    weaponCooldown -= 1
    
    if (weaponCooldown == 0) {
        weaponCooldown = stats.weaponCooldown
        
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemy, origin: id, damage: stats.damage })
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
        
        var enemyBase = o_influence_grid_manager.getRandomPopulatedShoreDistrict(getOpponentOf(player)).occupiedBy
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemyBase, origin: id, damage: stats.damage })
    } 
}