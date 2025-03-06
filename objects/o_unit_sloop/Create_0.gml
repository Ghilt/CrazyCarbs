range = 200

resetAfterBattle = function(origin) {
    x = origin.x
    y = origin.y
}

moveTowards = function(pos) {
    mp_linear_step(pos.x, pos.y, 4, false)
}