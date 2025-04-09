// https://manual.gamemaker.io/monthly/en/index.htm#t=The_Asset_Editors%2FCode_Editor_Properties%2FFeather_Data_Types.htm


/// @desc Function SavedDistrict. Not loaded into a game map.
/// @param {Real} _relativeX Which tileX holds this district, relative to the city starting position
/// @param {Real} _relativeY Which tileY holds this district, relative to the city starting position
/// @param {Enum.Terrain} _terrain Which terrain this district occupies
/// @param {Enum.Building | Real} _building Which type of building is built on this spot when loaded in. Can be -1, that indicates no building
function SavedCityDistrict(_relativeX, _relativeY, _terrain, _buildingType, _buildingRotated) constructor
{
    relativeX = floor(_relativeX)
    relativeY = floor(_relativeY)
    terrain = _terrain
    buildingType = _buildingType
    buildingRotated = _buildingRotated
    
    static hasBuildingType = function() { 
        return buildingType != -1
    }
}


/**
 * Function Description
 * @param {Real} _relativeX Which tileX holds this district, relative to the city starting position
 * @param {Real} _relativeY Which tileY holds this district, relative to the city starting position
 * @param {Real} _x the actual x coordinate in the room
 * @param {Real} _y the actual y coordinate in the room
 * @param {Id.Instance | Bool} _occupiedBy Description
 * @param {Enum.Terrain} _terrain Description
 */
function CityDistrict(_relativeX, _relativeY, _x, _y, _occupiedBy, _terrain, _buildingRotated = false) 
    : SavedCityDistrict(_relativeX, _relativeY, _terrain, -1 /* would like to propagate type here but dont know if i can*/, _buildingRotated) constructor
{
    x = _x
    y = _y
    occupiedBy = _occupiedBy 
    adjacentDistricts = []
    
    static resetAfterBattle = function() { 
        if (occupiedBy && instance_exists(occupiedBy)) {
            occupiedBy.resetAfterBattle()
        }
    }
        
    static holdsAliveShip = function() { 
        if (occupiedBy && instance_exists(occupiedBy)) {
            return instanceHasTag(occupiedBy, TAG_SHIP) && !occupiedBy.isDefeated
        } else {
            return false
        }
    }
    
}

