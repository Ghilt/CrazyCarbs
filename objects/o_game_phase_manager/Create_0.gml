
var progressButton = object_get_sprite(o_gui_progress_era_button)
instance_create_layer(guiWidth - sprite_get_width(progressButton) / 2, guiYBot - sprite_get_height(progressButton) / 2, "Gui", o_gui_progress_era_button)

enum GameState {
    BUILD,
    BATTLE
}

state = GameState.BUILD
gameRound = 0
battleDuration = 0;


isBuildPhase = function() {
    return state == GameState.BUILD
}

isBattlePhase = function() {
    return state == GameState.BATTLE
}

goToBattle = function() {
    state = GameState.BATTLE

    
    // Load debug enemy
    var spawnTile = o_map_manager.enemySpawnTiles[irandom(array_length(o_map_manager.enemySpawnTiles) - 1)]
    var grid = [
        { x : 0, y : 0, buildingType: Building.STARTING_PORT },
        { x : -2, y : -2, buildingType: Building.LUMBER_MILL },
        { x : -1, y : -2, buildingType: Building.GOLD_MINE },
        { x : -1, y : -1, buildingType: Building.GRAND_OAK },
        { x : -1, y : 0 },
        { x : 0, y : -1 }, 
        { x : 0, y : 1 }, 
        { x : -1, y : 1 }, 
        { x : 0, y : -2 },
        // sea
        { x : 1, y : -1, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 1, y : 0, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 1, y : 1, sea: true, buildingType: Building.SHIP_SLOOP },
        { x : 2, y : -1, sea: true },
        { x : 2, y : 0, sea: true },
        { x : 2, y : 1, sea: true }
    
    ]
    
    
    var _convert = method({ spawnTile }, function (_e, _i)
    {
        var terrain = variable_struct_exists(_e, "sea") ? Terrain.SEA : Terrain.GROUND
        var building = variable_struct_exists(_e, "buildingType") ? _e.buildingType : -1
        
        var rotated = vectorRotateAroundOrigin(_e, Direction.EAST, spawnTile.direction)
        
        ppp("rotation of spawn:", spawnTile.direction, { x: _e.x, y:_e.y }, "->", rotated)
        
        return new SavedCityDistrict(rotated.x, rotated.y, terrain, building, false, false)
    })
    
    var districts = array_map(grid, _convert)
    
    o_stability_manager.goToBattle()
    o_influence_grid_manager.goToBattle(new EnemyCity({ x: spawnTile.x, y: spawnTile.y }, spawnTile.direction, districts))
    o_pathing_manager.goToBattle()
}

goToBuild = function() {
    battleDuration = 0
    state = GameState.BUILD
    gameRound +=1
    o_shop_manager.goToNextRound()
    o_resource_manager.goToBuild()
    o_influence_grid_manager.resetAfterBattle()
    o_atom_manager.resetAfterBattle()
    o_stability_manager.goToBuild()
}

goToEndOfRoundScreen = function(victory) {
    goToBuild()
    
    var roundEndScreen = instance_create_layer(guiXMid, guiYMid, "Gui", o_gui_round_end_message, { victory: victory })
    roundEndScreen.depth = -1000
    roundEndScreen.image_xscale = 20
    roundEndScreen.image_yscale = 10
    
}