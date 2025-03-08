tempRange = 400 // target acquiring
tempOuterTurnRange = 100

gridWidth = MAP_W
gridHeight = MAP_H
gridCellWidth = room_width / gridWidth
gridCellHeight = room_height / gridHeight

navigableSeasGrid = mp_grid_create(0, 0, gridWidth, gridHeight, gridCellWidth, gridCellHeight)

// two paths, one for Player.US and one for Player.THEM
paths = [path_add(), path_add()]

// used to sail the fleets together (clump them up a bit)
furthestCheckpointReached = [0, 0]


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

goToBattle = function() { 
    furthestCheckpointReached = [0, 0]
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
        true
    )
    mp_grid_path(
        navigableSeasGrid,
        paths[Player.THEM], 
        ourBase.x, ourBase.y, enemyBase.x, enemyBase.y,
        true
    )
    path_reverse(paths[Player.THEM])
}

getClosestEnemyWithinEngageRange = function(unit) {
    return o_influence_grid_manager.getClosestShipWithin(unit, tempRange, getOpponentOf(unit.player))
}

clippedIntoShipInstance = function(unit) {
    var closestFriendlyShipData = o_influence_grid_manager.getClosestShipWithin(unit, itemSize / 2, unit.player)
    return closestFriendlyShipData ? closestFriendlyShipData.enemy : false
}

blockade = function(unit) {
    // do nothing for now, maybe some pacing animation later
}

moveTowardsShipOrBase = function(unit, targetUnit) {
    
    var unitPos = instancePosition(unit)
    
    var entangledInstance = clippedIntoShipInstance(unit)
    if (entangledInstance) {
        
        var entangledPos = instancePosition(entangledInstance)    
        var unentagleDisplacementVector = vectorSubtract(unitPos, entangledInstance)
        unit.moveTowards(vectorAdd(unitPos, unentagleDisplacementVector), 1)
        //return;
    }
    
    
    if (targetUnit) {
        unit.moveTowards(instancePosition(targetUnit), 1)
    } else {
        // navigate towards base along path
        
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
        
        if (bestPoint > furthestCheckpointReached[unit.player]) {
            furthestCheckpointReached[unit.player] = bestPoint
        }

        if (bestDistance < MAX_INT) {
             
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
                target = vectorAdd(unitPos, nearDirection)
            }
            
            var speedFactor; // could probably do this with a curve ^^
            if (bestPoint == furthestCheckpointReached[unit.player]) {
                speedFactor = 0.9
            } else if (bestPoint == furthestCheckpointReached[unit.player] - 1) {
                speedFactor = 1
            } else {
                speedFactor = 1.5
            }
            
            unit.moveTowards(target, speedFactor)
        }
    }
}