
path = path_add()

targetPos = { x, y }

alarm[0] = 15

function resetAfterBattle(origin) {
    path_delete(path)
    path = path_add()
    x = origin.x
    y = origin.y
}