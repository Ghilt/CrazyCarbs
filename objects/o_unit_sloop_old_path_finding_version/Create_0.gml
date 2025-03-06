path = path_add()

alarm[0] = 15

resetAfterBattle = function(origin) {
    path_delete(path)
    path = path_add()
    x = origin.x
    y = origin.y
}