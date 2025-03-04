function CityDistrict(_relativeX, _relativeY, _x, _y, _occupiedBy, _terrain) constructor
{
    relativeX = _relativeX
    relativeY = _relativeY
    x = _x
    y = _y
    occupiedBy = _occupiedBy
    terrain = _terrain
    static resetAfterBattle = function() { 
        if (occupiedBy) {
            occupiedBy.resetAfterBattle({ x, y })
        }
    }
    
}
