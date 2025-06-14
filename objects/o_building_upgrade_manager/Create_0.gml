// frequency of effect burst for fulfilling recipies
counter = 0
checkRecipeEvery = 0.5 * one_second

currentlyFulfillingRecipes = ds_map_create() // for easy lookup to not use component for multiple recipies
currentlyFulfillingRecipesMainNodeList = [] // all these nodes will be upgraded when battle phase is over

// Currently does not support recipies with multiple components of the same type IF that type has a large footprint.
// This function may double count that building if it exists on mutliple adjacent districts 
isRecipeFulfilled = function(recipe, adjacentDistrictIndexes) {
    var numberOfAdjacentDistricts = array_length(adjacentDistrictIndexes) 
    
    var requiredComponentBuildingTypes = []
    var usedComponents = []
    array_copy(requiredComponentBuildingTypes, 0, recipe.components, 0, array_length(recipe.components))   
    
    for (var i = 0; i < numberOfAdjacentDistricts; i++) {
        
        var availableDistrictToCombine = o_influence_grid_manager.influenceGrid[Player.US][adjacentDistrictIndexes[i]]
        if (!availableDistrictToCombine.occupiedBy) {
            continue
        }
        
        if (!is_undefined(currentlyFulfillingRecipes[? availableDistrictToCombine.occupiedBy])) {
            continue 
        }

        var typeFoundAndNowSatisfied = arrayRemoveFirst(requiredComponentBuildingTypes, method({ typeFound : availableDistrictToCombine.occupiedBy.type }, function(requiredBuildingType) {
            return requiredBuildingType == typeFound
        }))
        
        if (variable_struct_exists(typeFoundAndNowSatisfied, "removedItem")) {
            array_push(usedComponents, { 
                building: availableDistrictToCombine.occupiedBy, 
                influenceGridIndex : adjacentDistrictIndexes[i], 
                type: typeFoundAndNowSatisfied.removedItem 
            })
        }
    }
    
    if (array_length(requiredComponentBuildingTypes) == 0) {
        return usedComponents  
    } else {
        return false
    }
}

// city district just had a building added or removed
recalculateRecipeFullfillment = function(cityDistrict) {
    ds_map_clear(currentlyFulfillingRecipes)
    currentlyFulfillingRecipesMainNodeList = []
    
    var arrayLength = array_length(o_influence_grid_manager.influenceGrid[Player.US])
    
    for (var influenceGridIndex = 0; influenceGridIndex < arrayLength; influenceGridIndex++) {
    	var district = o_influence_grid_manager.influenceGrid[Player.US][influenceGridIndex]
        
        if (district.occupiedBy) { 
            
            if (!is_undefined(currentlyFulfillingRecipes[? district.occupiedBy])) {
                continue 
            }
            
            var recipiesForType = global.buildingRecipes[? district.occupiedBy.type]
            if (!is_undefined(recipiesForType)) {
                var adjacentDistrictsOfWholeBuilding = getAdjacentDistrictIndexesOfBuilding(district)
                
                for (var recipeIterator = 0; recipeIterator < array_length(recipiesForType); recipeIterator++) {
                    var fullfillmentData = isRecipeFulfilled(recipiesForType[recipeIterator], adjacentDistrictsOfWholeBuilding)
                	if (is_array(fullfillmentData)) {
                        
                        var allPositions = [] // will be a list of lists before being flattened
                        currentlyFulfillingRecipes[? district.occupiedBy] = fullfillmentData
                        array_push(allPositions, getPositionsOfAllDistrictsOfBuilding(district.occupiedBy))
                        
                        for (var fullfillmentDataIndex = 0; fullfillmentDataIndex < array_length(fullfillmentData); fullfillmentDataIndex++) {
                            currentlyFulfillingRecipes[? fullfillmentData[fullfillmentDataIndex].building] = fullfillmentData	
                            array_push(allPositions, getPositionsOfAllDistrictsOfBuilding(fullfillmentData[fullfillmentDataIndex].building))
                        }
                        
                        allPositions = arrayFlatten(allPositions)
                        
                        array_push(currentlyFulfillingRecipesMainNodeList, { mainNode: district, positions: allPositions, recipe: recipiesForType[recipeIterator] })
                        
                        // the district triggering the recalculation is part of this recipe
                        var samePosPredicate = method({ cityDistrict }, function(pos) { return pos.x == cityDistrict.x && pos.y = cityDistrict.y })
                        if (cityDistrict.occupiedBy && array_any(allPositions, samePosPredicate)) {
                            o_effects_manager.recipeActiveEffectAt(allPositions) 
                        }
                    }
                }
            }
        }
    }  
    ppp("RecipeFullfillment recalculated, buildings part of fullfilled recipies:", ds_map_size(currentlyFulfillingRecipes))
}

goToBuild = function() {
    // we need to copy the array here since the removal code updates the adjacency and modifies the original array
    var size = array_length(currentlyFulfillingRecipesMainNodeList)
    var copyOfMainNodes = array_create(size)
    array_copy(copyOfMainNodes, 0, currentlyFulfillingRecipesMainNodeList, 0, size)

    
    for (var i = 0; i < size; i++;)
    {
        
        array_foreach(copyOfMainNodes[i].positions, function(obj){
            var deactivatedInstance = o_influence_grid_manager.removeBuildingAt(obj) 
            instance_destroy(deactivatedInstance)
        })
        
        ppp("Time to upgrade combine!", copyOfMainNodes[i]) // TODO ---> Make reward spawn on map instead of in inventory
        o_inventory_manager.addItem(copyOfMainNodes[i].recipe.result)
        
    }
}