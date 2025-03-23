o_inventory_manager.addItem(Building.LUMBER_MILL)
o_inventory_manager.addItem(Building.BEEKEEPER)
o_inventory_manager.addItem(Building.ORCHARD)

showNavigableSeasGrid = false

ppp("Debug util centering camera on hardcoded coordinates: 2960,390")
camera_set_view_pos(view_get_camera(view_current), 2960, 390)

isoProjection = true


// give enemy fully stacked city
//var randomBuildingType = _i == 0 ? Building.STARTING_PORT : randomBuilding(terrain)
//createBuilding = instance_create_layer(posX, posY, "Ground", ds_map_find_value(global.buildings, randomBuildingType).building, { player: Player.THEM })
  