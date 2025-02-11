
function Item(_x, _y) constructor {
    x = _x
    y = _y
}

enum Building
{
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
ds_map_add(global.buildings, Building.GOLD_MINE, { building: o_building_gold_mine})
ds_map_add(global.buildings, Building.LUMBER_MILL, { building: o_building_lumber_mill})