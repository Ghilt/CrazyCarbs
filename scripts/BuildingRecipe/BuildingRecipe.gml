/// @desc Function Description
/// @param {any*} _mainBuildingNode The recipe trigger on this building. It gets built in this place if it fits
/// @param {any*} _listOfAdditionalIngredients This is a list of buildings types. Those types need to be close to the main building node to combine
function BuildingRecipe(_mainBuildingNode, _listOfAdditionalIngredients, _result) constructor
{
    mainBuildingNode = _mainBuildingNode
    components = _listOfAdditionalIngredients
    result = _result

}