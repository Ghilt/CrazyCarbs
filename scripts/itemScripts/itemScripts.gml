
enum Building
{
    STARTING_PORT,
    GOLD_MINE,
    LUMBER_MILL,
    RUM_DISTILLERY,
    SUGAR_PLANTATION,
    FISHING_DOCK,
    SALT_WORKS,
    SPICE_GARDEN,
    COTTON_PLANTATION,
    LIVESTOCK_RANCH
};

global.buildings = ds_map_create()
ds_map_add(global.buildings, Building.STARTING_PORT, { building: o_building_starting_port})
ds_map_add(global.buildings, Building.GOLD_MINE, { building: o_building_gold_mine})
ds_map_add(global.buildings, Building.LUMBER_MILL, { building: o_building_lumber_mill})