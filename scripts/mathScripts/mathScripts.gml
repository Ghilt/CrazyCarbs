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