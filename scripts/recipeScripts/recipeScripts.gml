// Would be fun to have terrain types as possible recipe requirement
global.buildingRecipes = ds_map_create()


// See comment in building upgrade manager: Currently does not support recipies with multiple components of the same type IF that type has a large footprint.
// This function may double count that building if it exists on mutliple adjacent districts 

ds_map_add(global.buildingRecipes, Building.BEEKEEPER, 
    [
        new BuildingRecipe(Building.BEEKEEPER, [Building.BEEKEEPER], Building.ORCHARD)
    ]
)       
