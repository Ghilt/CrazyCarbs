// Would be fun to have terrain types as possible recipe requirement
global.buildingRecipes = ds_map_create()

ds_map_add(global.buildingRecipes, Building.BEEKEEPER, 
    [
        new BuildingRecipe(Building.BEEKEEPER, [Building.BEEKEEPER])
    ]
)       
