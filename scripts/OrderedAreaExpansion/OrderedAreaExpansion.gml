// this is the order the available building spots for a player grows
// It goes eg: (0, 0) -> (0, 1) -> (-1, 0) etc, orthogonal first
// It is map independent and must be filtered to comply with the map
function getOrderedAreaExpansion(size)
{
    var areaExpandOrder = []
    for (var xx = -size; xx < size; xx++) {
        for (var yy = -size; yy < size; yy++) {
            array_push(areaExpandOrder, { x: xx, y: yy, dist: point_distance(xx, yy, 0, 0) } )
        }
    }
    
    array_sort(areaExpandOrder, function(elm1, elm2)
    {
        // The order of the points with the same distance is not stable. But I dont care atm
        return sign(elm1.dist - elm2.dist);
    });
    
    return areaExpandOrder
}


