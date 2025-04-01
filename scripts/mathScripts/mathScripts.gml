// TODO maybe do a constructor for vectors/points instead of using structs

function vectorSubtract(a, b) {
    return { x: a.x - b.x, y: a.y - b.y }
}

function vectorAdd(a, b) {
    return { x: a.x + b.x, y: a.y + b.y }
}

function vectorEquals(a, b) {
    return a.x == b.x && a.y == b.y
}

function vectorScale(a, scalar) {
    return { x: a.x * scalar, y: a.y * scalar }
}

function crossProduct(a, b) {
    return  a.x * b.y - a.y + b.x
}

function dotProduct(a, b) {
    return dot_product(a.x, a.y, b.x, b.y)
}

function vectorLength(a) {
    return sqrt(power(a.x, 2) + power(a.y, 2))
}

function vectorIsOrthogonalDirection(a) {
    return vectorEquals(a, global.directionVector[Direction.NORTH]) 
        || vectorEquals(a, global.directionVector[Direction.EAST])
        || vectorEquals(a, global.directionVector[Direction.SOUTH]) 
        || vectorEquals(a, global.directionVector[Direction.WEST])
}

function vectorGetOrthogonal(a) {
    return [
        vectorAdd(a, global.directionVector[Direction.NORTH]), 
        vectorAdd(a, global.directionVector[Direction.EAST]), 
        vectorAdd(a, global.directionVector[Direction.SOUTH]), 
        vectorAdd(a, global.directionVector[Direction.WEST])
    ]
}

// directions assumed to be orthogonal NORTH, EAST, SOUTH, WEST
function vectorRotateAroundOrigin(a, currentDirection, newDirection) {

    // Compute how many 90-degree steps we need to rotate
    var steps = (newDirection - currentDirection) / 2
    steps = steps < 0 ? 4 + steps : steps // always rotate clockwise
    var newX = a.x
    var newY = a.y
    repeat (steps) {
        var tempX = newX
        var tempY = newY
        newX = -tempY
        newY = tempX       
    }   
    return { x: newX, y: newY } 
}

// Take notice, some tech debt here, a is not normalized in anyway and the global direction vector expects normalized vector
function vectorToDirection(a) {
    return array_find_index(global.directionVector, method({ a }, function(_ele) { 
        return a.x == _ele.x && a.y == _ele.y
    }))
}



enum Direction
{
    NORTH,
    NORTH_EAST,
    EAST,
    SOUTH_EAST,
    SOUTH,
    SOUTH_WEST,
    WEST,
    NORTH_WEST,
};

global.directionVectorOld = [{ x: 0, y: -1 },{ x: 1, y: 0 },{ x: 0, y: 1 },{ x: -1, y: 0 }]
global.directionVector = [
    { x: 0, y: -1 },      // NORTH
    { x: 0.707, y: -0.707 },  // NORTHEAST
    { x: 1, y: 0 },       // EAST
    { x: 0.707, y: 0.707 },   // SOUTHEAST
    { x: 0, y: 1 },       // SOUTH
    { x: -0.707, y: 0.707 },  // SOUTHWEST
    { x: -1, y: 0 },      // WEST
    { x: -0.707, y: -0.707 }  // NORTHWEST
]

function vectorQuadrant(a) {
    var thetaRadians = arctan2(a.y, a.x)
    var oPi = pi/8
    
    if (-oPi < thetaRadians && thetaRadians < oPi) {
        return Direction.EAST
    } else if ( oPi <= thetaRadians && thetaRadians < 3 * oPi) {
        return Direction.SOUTH_EAST
    } else if ( 3 * oPi <= thetaRadians && thetaRadians < 5 * oPi) {
        return Direction.SOUTH
    } else if ( 5 * oPi <= thetaRadians && thetaRadians < 7 * oPi) {
        return Direction.SOUTH_WEST
    } else if (thetaRadians >= 7 * oPi || thetaRadians <= -7 * oPi) {
        return Direction.WEST 
    } else if (-7 * oPi < thetaRadians && thetaRadians <= -5 * oPi) {
        return Direction.NORTH_WEST 
    } else if (-5 * oPi < thetaRadians && thetaRadians <= -3 * oPi) {
        return Direction.NORTH 
    } else {
        return Direction.NORTH_EAST
    }
}
