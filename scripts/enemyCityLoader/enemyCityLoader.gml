function loadDebugEnemy(gameRound) {
    // Base debug enemy grid - same for all rounds
    var grid = [
        { x : 0, y : 0, buildingType: Building.STARTING_PORT },
        { x : -2, y : -2, buildingType: Building.LUMBER_MILL },
        { x : -1, y : -2, buildingType: Building.GOLD_MINE },
        { x : -1, y : -1, buildingType: Building.GRAND_OAK },
        { x : -1, y : 0, buildingType: Building.BEEKEEPER, buildingRotated: true },
        { x : 0, y : -1 }, 
        { x : 0, y : 1 }, 
        { x : -1, y : 1, buildingType: Building.BEEKEEPER, buildingRotated: true }, 
        { x : 0, y : -2 },
        // sea
        { x : 1, y : -1, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 1, y : 0, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 1, y : 1, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 2, y : -1, sea: true },
        { x : 2, y : 0, sea: true },
        { x : 2, y : 1, sea: true }
    ]
    
    var _convert = function (_e, _i) {
        var terrain = variable_struct_exists(_e, "sea") ? Terrain.SEA : Terrain.GROUND
        var building = variable_struct_exists(_e, "buildingType") ? _e.buildingType : -1
        var buildingRotated = variable_struct_exists(_e, "buildingRotated") ? _e.buildingRotated : false
        
        return new SavedCityDistrict(_e.x, _e.y, terrain, building, buildingRotated)
    }
    
    return array_map(grid, _convert)
}

function loadRandomEnemy(gameRound) {
    var directoryPath = getSavedBuildPathForRound(gameRound)
    var enemyBuildFileName = getRandomFilenameFromDirectory(directoryPath)
    
    if (enemyBuildFileName == "") {
        return loadDebugEnemy(gameRound)
    }
    
    var savedData = loadDistrictsFromFile(directoryPath, enemyBuildFileName)
    ppp("Loading enemy: ", enemyBuildFileName, savedData)
    return savedData.districts
}