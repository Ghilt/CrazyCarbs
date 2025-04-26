function BuildingData(_type, _object, _price, _terrainRequirement, _footprintWidth, _footprintHeight, _baseStats, _name, _descriptionGenerator) constructor
{
    type = _type
    footprint = { width: _footprintWidth, height: _footprintHeight }
    price = _price
    terrainRequirement = _terrainRequirement
    object = _object
    baseStats = _baseStats
    name = _name
    descriptionGenerator = _descriptionGenerator
    
    // Utility method - does not mutate 
    static getRotatedFootprint = function() {
        return { width: footprint.height, height: footprint.width}    
    }
    
    static getBaseDescription = function() {
        return descriptionGenerator(baseStats)
    }
}