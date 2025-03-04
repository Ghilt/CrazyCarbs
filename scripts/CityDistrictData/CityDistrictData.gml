function CityDistrict(_relativeX, _relativeY, _x, _y, _occupiedBy, _terrain) constructor
{
    relativeX = _relativeX
    relativeY = _relativeY
    x = _x
    y = _y
    occupiedBy = _occupiedBy
    terrain = _terrain
    resetAfterBattle = function() { 
        if (occupiedBy) {
                        ppp("sdf", occupiedBy, occupiedBy.player, occupiedBy.x, occupiedBy.y, relativeX, relativeY, terrain)

            occupiedBy.resetAfterBattle({ x, y })
        }
    }
    
}
