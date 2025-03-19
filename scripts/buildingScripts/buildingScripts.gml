
enum Building
{
    STARTING_PORT,
    GOLD_MINE,
    LUMBER_MILL,
    GRAND_OAK,
    ORCHARD,
    BEEKEEPER,
    SHIP_SLOOP,
    // the below is not implemented
    RUM_DISTILLERY,
    SUGAR_PLANTATION,
    FISHING_DOCK,
    SALT_WORKS,
    SPICE_GARDEN,
    COTTON_PLANTATION,
    LIVESTOCK_RANCH
};

enum Terrain
{
    SEA,
    GROUND
}


var buildingData = [
    new BuildingData(Building.STARTING_PORT, o_building_starting_port, 0, Terrain.SEA, 1, 1),
    new BuildingData(Building.GOLD_MINE, o_building_gold_mine, 4, Terrain.GROUND, 1, 1),
    new BuildingData(Building.LUMBER_MILL, o_building_lumber_mill, 3, Terrain.GROUND, 1, 1),
    new BuildingData(Building.GRAND_OAK, o_building_grand_oak, 2, Terrain.GROUND, 1, 1),
    new BuildingData(Building.ORCHARD, o_building_orchard, 1, Terrain.GROUND, 2, 2),
    new BuildingData(Building.BEEKEEPER, o_building_beekeeper, 1, Terrain.GROUND, 2, 1),
    // Ships
    new BuildingData(Building.SHIP_SLOOP, o_unit_sloop, 3, Terrain.SEA, 1, 1)
]


global.buildings = ds_map_create()
for (var i = 0; i < array_length(buildingData); i++) {
    ds_map_add(global.buildings, buildingData[i].type, buildingData[i])        
}


// For development
// Will return a random building type, besides starting building
function randomBuilding(terrain) {
    if (terrain == Terrain.SEA) {
        return irandom_range(6, 6)
    } else {
        return irandom_range(1, 5)
    }
}

function footprintToCoordinates(anchorDistrict, footprint) {
    var coordinates = array_create(footprint.width * footprint.height)
    for (var yy = 0; yy < footprint.height; yy++) {
        for (var xx = 0; xx < footprint.width; xx++) {
            coordinates[xx + footprint.width * yy] = { x: anchorDistrict.relativeX + xx, y: anchorDistrict.relativeY + yy }    
        }
    }
    return coordinates
}

