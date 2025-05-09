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
    // Save the build of the player to match it up against other players.
    storeBuild(o_influence_grid_manager.influenceGrid[Player.US], new PlayerData(Direction.EAST, "BlackCalder", gameRound, 0)) // TODO keep track of win/lose con
    
    state = GameState.BATTLE

    // Load debug enemy
    var enemySpawnPosIndex = gameRound mod array_length(o_map_manager.enemySpawnTiles)
    var spawnTile = o_map_manager.enemySpawnTiles[enemySpawnPosIndex]
    
    var tryDebugStuff = false
    var districts = tryDebugStuff ? loadDebugEnemy(gameRound) : loadRandomEnemy(gameRound)
    var rotatedDistricts = rotateCity(districts, Direction.EAST, spawnTile.direction)
    
    o_stability_manager.goToBattle()
    o_influence_grid_manager.goToBattle(new EnemyCity({ x: spawnTile.x, y: spawnTile.y }, spawnTile.direction, rotatedDistricts))
    o_pathing_manager.goToBattle()
}

goToBuild = function() {
    battleDuration = 0
    state = GameState.BUILD
    gameRound += 1
    o_shop_manager.goToNextRound()
    o_resource_manager.goToBuild()
    o_influence_grid_manager.resetAfterBattle()
    o_buff_debuff_manager.resetAfterBattle()
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