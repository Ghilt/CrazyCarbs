
enum Building
{
    STARTING_PORT,
    GOLD_MINE,
    LUMBER_MILL,
    // the below is not implemented
    RUM_DISTILLERY,
    SUGAR_PLANTATION,
    FISHING_DOCK,
    SALT_WORKS,
    SPICE_GARDEN,
    COTTON_PLANTATION,
    LIVESTOCK_RANCH
};

global.buildings = ds_map_create()
ds_map_add(global.buildings, Building.STARTING_PORT, { building: o_building_starting_port, price: 0 })
ds_map_add(global.buildings, Building.GOLD_MINE, { building: o_building_gold_mine, price: 4 })
ds_map_add(global.buildings, Building.LUMBER_MILL, { building: o_building_lumber_mill, price: 3 })

// For development
// Will return a random building type, besides starting building
function randomBuilding() {
    return irandom_range(1, 2)
}