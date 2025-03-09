// TODO maybe do a constructor for vectors/points instead of using structs

function vectorSubtract(a, b) {
    return { x: a.x - b.x, y: a.y - b.y }
}

function vectorAdd(a, b) {
    return { x: a.x + b.x, y: a.y + b.y }
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

enum Direction
{
    NORTH,
    EAST,
    SOUTH,
    WEST,
};

global.directionVector = [{ x: 0, y: -1 },{ x: 1, y: 0 },{ x: 0, y: 1 },{ x: -1, y: 0 },]

function vectorQuadrant(a) {
    var thetaRadians = arctan2(a.y, a.x)
    var qPi = pi/4
    var qPi3 = 3*qPi
    
    if (-qPi < thetaRadians && thetaRadians < qPi) {
        return Direction.EAST
    } else if ( qPi <= thetaRadians && thetaRadians < qPi3) {
        return Direction.SOUTH
    } else if (thetaRadians <= -qPi3 || thetaRadians >= qPi3) {
        return Direction.WEST 
    } else {
        return Direction.NORTH
    }
}
