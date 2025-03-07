stats = {
    hull: 100,
    damage: 100,
    range: 200,
    weaponReadiness: 20, // before firing weapon for the first time
    weaponCooldown: one_second * 2 
}

hull = stats.hull
weaponCooldown = stats.weaponReadiness
isDestroyed = false

resetAfterBattle = function() {
    x = origin.x
    y = origin.y
    isDestroyed = false
}

moveTowards = function(pos) {
    mp_linear_step(pos.x, pos.y, 6, false)
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
    
    if (hull < 0) {
        destroyedByDamage()
    }
}

destroyedByDamage = function() {
    x = origin.x
    y = origin.y
    isDestroyed = true
}