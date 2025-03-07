var progressButton = object_get_sprite(o_gui_progress_era_button)
instance_create_layer(guiWidth - sprite_get_width(progressButton) / 2, guiYBot - sprite_get_height(progressButton) / 2, "Gui", o_gui_progress_era_button)

enum GameState {
    BUILD,
    BATTLE
}

state = GameState.BUILD
gameRound = 0



isBuildPhase = function() {
    return state == GameState.BUILD
}

isBattlePhase = function() {
    return state == GameState.BATTLE
}

goToBattle = function() {
    state = GameState.BATTLE
    o_stability_manager.goToBattle()
    
    // Load debug enemy
    var grid = [
        { x : 0, y : 0, building: Building.STARTING_PORT },
        { x : -2, y : -2, building: Building.LUMBER_MILL },
        { x : -1, y : -2, building: Building.GOLD_MINE },
        { x : -1, y : -1 },
        { x : -1, y : 0 },
        { x : 0, y : -1 }, 
        { x : 0, y : 1 }, 
        { x : -1, y : 1 }, 
        { x : 0, y : -2 },
        // sea
        { x : 1, y : -1, sea: true, building: Building.SHIP_SLOOP },
        { x : 1, y : 0, sea: true, building: Building.SHIP_SLOOP },
        { x : 1, y : 1, sea: true, building: Building.SHIP_SLOOP },
        { x : 2, y : -1, sea: true },
        { x : 2, y : 0, sea: true },
        { x : 2, y : 1, sea: true }
    
    ]
    
    
    var _convert = function (_e, _i)
    {
        var terrain = variable_struct_exists(_e, "sea") ? Terrain.SEA : Terrain.GROUND
        var building = variable_struct_exists(_e, "building") ? _e.building : -1
        
        return new SavedCityDistrict(_e.x, _e.y, terrain, building)
    }
    
    var districts = array_map(grid, _convert)
    
    o_influence_grid_manager.goToBattle(new EnemyCity({ x: 50, y: 50 }, districts))
    o_pathing_manager.goToBattle()
}

goToBuild = function() {
    state = GameState.BUILD
    gameRound +=1
    o_shop_manager.goToNextRound()
    o_resource_manager.goToBuild()
    o_influence_grid_manager.resetAfterBattle()
}

goToEndOfRoundScreen = function(victory) {
    goToBuild()
    
    var roundEndScreen = instance_create_layer(guiXMid, guiYMid, "Gui", o_gui_round_end_message, { victory: victory })
    roundEndScreen.depth = -1000
    roundEndScreen.image_xscale = 20
    roundEndScreen.image_yscale = 10
    
}

