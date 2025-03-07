stats = {
    hull: 100,
    damage: 100,
    range: 200,
    weaponReadiness: 20, // before firing weapon for the first time
    weaponCooldown: one_second * 2 
}

weaponCooldown = stats.weaponReadiness

resetAfterBattle = function(origin) {
    x = origin.x
    y = origin.y
}

moveTowards = function(pos) {
    mp_linear_step(pos.x, pos.y, 4, false)
}

fireWeapon = function(enemy) {
    weaponCooldown -= 1
    
    if (weaponCooldown == 0) {
        weaponCooldown = stats.weaponCooldown
        
        instance_create_layer(x, y, "Ground", o_projectile_cannon_ball, { target: enemy, origin: id, damage: stats.damage })
    } 
}