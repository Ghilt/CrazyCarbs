tempRange = 200
tempOuterTurnRange = 128

gridWidth = MAP_W
gridHeight = MAP_H
gridCellWidth = room_width / gridWidth
gridCellHeight = room_height / gridHeight

navigableSeasGrid = mp_grid_create(0, 0, gridWidth, gridHeight, gridCellWidth, gridCellHeight)

// two paths, one for Player.US and one for Player.THEM
paths = [path_add(), path_add()]


var tileMap = layer_tilemap_get_id("Tiles_map")

for (var tX = 0; tX < MAP_W; tX++) {
    for (var tY = 0; tY < MAP_H; tY++) {
        var tileMapData = tilemap_get(tileMap, tX, tY)
        tileMapData = tile_get_index(tileMapData)

        if (tileMapData != 3) {
            mp_grid_add_cell(navigableSeasGrid, tX, tY)
        }
    }
}



// non iso cooridnates, real world coordinates
motionPlanToTarget = function(path, unit) {
    var opponent = getOpponentOf(unit.player)
    var target = o_influence_grid_manager.getClosestEnemyShipWithin(unit, tempRange)
    
    if (!target) {
        target = o_influence_grid_manager.getPlayerPosition(opponent)
    }
    
    mp_grid_path(
        navigableSeasGrid,
        path, 
        unit.x, unit.y, target.x, target.y,
        true
    )
}

goToBattle = function() { 
    var ourBase = o_influence_grid_manager.getPlayerPosition(Player.US)
    var enemyBase = o_influence_grid_manager.getPlayerPosition(Player.THEM)
    
    path_delete(paths[Player.US])
    path_delete(paths[Player.THEM])
    paths[Player.US] = path_add()
    paths[Player.THEM] = path_add()
    mp_grid_path(
        navigableSeasGrid,
        paths[Player.US], 
        ourBase.x, ourBase.y, enemyBase.x, enemyBase.y,
        false // TODO support diagonal movement later
    )
    mp_grid_path(
        navigableSeasGrid,
        paths[Player.THEM], 
        ourBase.x, ourBase.y, enemyBase.x, enemyBase.y,
        false // TODO support diagonal movement later
    )
    path_reverse(paths[Player.THEM])
}

getClosestEnemyWithinEngageRange = function(unit) {
    return o_influence_grid_manager.getClosestEnemyShipWithin(unit, tempRange)
}

moveTowardsShipOrBase = function(unit, targetUnit) {
    
    if (targetUnit) {
        ppp("TODO move towards unit ")
    } else {
        // navigate towards base along path
        
        // Get closest point on path
        var path = paths[unit.player]
        var bestDistance = MAX_INT
        var bestX = 0
        var bestY = 0
        var bestPoint = false
        var pathSize = path_get_number(path)
        
        
        for (var i = 0; i < pathSize; i++) {
            var pX = path_get_point_x(path, i)
            var pY = path_get_point_y(path, i)
            var distance = point_distance(unit.x, unit.y, pX, pY)
            
            if (distance < bestDistance) {
                bestDistance = distance
                bestX = pX
                bestY = pY
                bestPoint = i
            } 
        }

        if (bestDistance < MAX_INT) {
            var unitPos = { x: unit.x, y: unit.y }
             
            var previousPoint = { x: path_get_point_x(path, bestPoint - 1), y:  path_get_point_y(path, bestPoint - 1)}
            var closestPoint = { x: path_get_point_x(path, bestPoint), y:  path_get_point_y(path, bestPoint) }
            var nextPoint = { x: path_get_point_x(path, bestPoint + 1), y:  path_get_point_y(path, bestPoint + 1) }
            var farPoint = { x: path_get_point_x(path, bestPoint + 2), y:  path_get_point_y(path, bestPoint + 2) }
            var displacementVector = vectorSubtract(unitPos, nextPoint)

            var previousDirection = vectorSubtract(closestPoint, previousPoint) 
            var nearDirection = vectorSubtract(nextPoint, closestPoint) 
            var farDirection = vectorSubtract(farPoint, closestPoint)
            var futureDirection = vectorSubtract(farPoint, nextPoint)
            
            //var nearCrossProduct = crossProduct(displacementVector, nearDirection)
            //var farCrossProduct = crossProduct(displacementVector, farDirection)

            var nearDotProduct = dotProduct(displacementVector, nearDirection)
            var farDotProduct = dotProduct(displacementVector, farDirection)
            
            // debugg snippet
            //if (unit.player == Player.THEM && bestPoint == 4) {
                //pppp(unit, "points", unit.x, unit.y, closestPoint, farPoint, displacementVector, farDirection, farDotProduct, unit.y < closestPoint.y)
            //}
            
            
            var target 
            
            if (farDotProduct != nearDotProduct && farDotProduct > nearDotProduct) {
                // We are on the inside of a turn. We do not want to overshoot/cross the path, turn now
                target = vectorAdd(unitPos, futureDirection)
            } else if (previousDirection != nearDirection && vectorLength(displacementVector) < tempOuterTurnRange){
                // We are on the outside of a turn
                target = vectorAdd(unitPos, previousDirection)
            } else {
                // TODO need to go one point back on the path to figure out if im on the outside of a turn and act accordingly
                target = vectorAdd(unitPos, nearDirection)
            }
            
            
            unit.moveTowards(target)
        }
    }
}