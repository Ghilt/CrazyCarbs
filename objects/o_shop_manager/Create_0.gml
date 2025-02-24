
shopWidth = 400
shopHeight = 600
shopX = guiWidth - shopWidth
shopY = guiYMid
shopItemsPadding = itemSize / 8
shopXItems = shopX + shopItemsPadding * 4
shopYItems = shopY + shopItemsPadding * 4

var inventory_sprite = object_get_sprite(o_gui_shop)
var background = instance_create_layer(guiWidth - shopWidth, guiYMid, "Gui", o_gui_shop)
var separation = itemSize + shopItemsPadding

// x,y here is relative offsett compared to shopX and shopY
shopPosition = [
    { x: separation * 0, y: separation * 0, occupiedBy: false },
    { x: separation * 1, y: separation * 0, occupiedBy: false },
    { x: separation * 0, y: separation * 1, occupiedBy: false },
    { x: separation * 1, y: separation * 1, occupiedBy: false },
    { x: separation * 0, y: separation * 2, occupiedBy: false },
    { x: separation * 1, y: separation * 2, occupiedBy: false },
]

moneyProgression = function() {
    return o_game_phase_manager.gameRound + 10
}

currentMoney = moneyProgression()

nextOffer = function() {
    return randomBuilding()
}


canAfford = function(type) {
    return ds_map_find_value(global.buildings, type).price <= currentMoney
}

// common function name for when the item is placed from the inventory
// this could be named 'purchaseItem'
removeItem = function(item) {
    currentMoney -= ds_map_find_value(global.buildings, item.type).price
    
    with { shopPosition, item }
    var index = array_find_index(shopPosition, function(_e, _i) { 
            return _e.occupiedBy == item; 
        } 
    )
    
    shopPosition[index].occupiedBy = false
    instance_destroy(item.id)
}


goToNextRound = function() {
    currentMoney += moneyProgression()
}