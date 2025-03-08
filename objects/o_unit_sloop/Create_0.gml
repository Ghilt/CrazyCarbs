stats = {
    hull: 100,
    damage: 50,
    range: 200,
    speed: 3,
    blockadeRange: 200, // This is a cosmetic value which only affacts how the blockade will look
    blockadeDamage: 1,
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

moveTowards = function(pos, speedModifier) {
    mp_linear_step(pos.x, pos.y, stats.speed * speedModifier, false)
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
        
        var opponent = getOpponentOf(player)
        var enemyBase = o_influence_grid_manager.getRandomPopulatedShoreDistrict(opponent).occupiedBy
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemyBase, origin: id, damage: stats.blockadeDamage })
    } 
}