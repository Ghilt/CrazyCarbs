function BuildingData(_type, _object, _price, _terrainRequirement, _footprintWidth, _footprintHeight) constructor
{
    type = _type
    footprint = { width: _footprintWidth, height: _footprintHeight }
    price = _price
    terrainRequirement = _terrainRequirement
    object = _object
    
    // Utility method - does not mutate 
    static getRotatedFootprint = function() {
        return { width: footprint.height, height: footprint.width}    
    }
}