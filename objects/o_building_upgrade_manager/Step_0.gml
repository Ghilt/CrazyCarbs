if (counter == checkRecipeEvery) {
    counter = 0
} else {
    counter++
    return
}

var arrayLength = array_length(currentlyFulfillingRecipesMainNodeList)
for (var i = 0; i < arrayLength; i++) {
    o_effects_manager.recipeActiveEffectAt2(currentlyFulfillingRecipesMainNodeList[i].positions) 	
}

