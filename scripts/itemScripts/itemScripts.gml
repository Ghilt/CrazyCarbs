
enum Building
{
    STARTING_PORT,
    GOLD_MINE,
    LUMBER_MILL,
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
};

global.buildings = ds_map_create()
ds_map_add(global.buildings, Building.STARTING_PORT, { building: o_building_starting_port, price: 0, terrainRequirement: Terrain.GROUND })
ds_map_add(global.buildings, Building.GOLD_MINE, { building: o_building_gold_mine, price: 4, terrainRequirement: Terrain.GROUND })
ds_map_add(global.buildings, Building.LUMBER_MILL, { building: o_building_lumber_mill, price: 3, terrainRequirement: Terrain.GROUND })
ds_map_add(global.buildings, Building.SHIP_SLOOP, { building: o_unit_sloop, price: 3, terrainRequirement: Terrain.SEA })

// For development
// Will return a random building type, besides starting building
function randomBuilding() {
    return irandom_range(1, 3)
}