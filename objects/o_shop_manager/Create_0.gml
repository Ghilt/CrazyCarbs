rerollPrice = 1
shopWidth = 400
shopHeight = guiHeight / 2
shopX = guiWidth - shopWidth
shopY = guiYMid
shopItemsPadding = itemSize / 8
shopXItems = shopX + shopItemsPadding * 4
shopYItems = shopY + shopItemsPadding * 4

//anchored to shop x,y
shopSellPos = { 
    x: -80, 
    y: shopHeight - 80, 
    snappingDistance: 80 }

var inventory_sprite = object_get_sprite(o_gui_shop)
var background = instance_create_layer(guiWidth - shopWidth, guiYMid, "Gui", o_gui_shop)
var separation = itemSize + shopItemsPadding

// x,y here is relative offsett compared to shopX and shopY
shopPosition = [
    { x: separation * 0, y: shopItemsPadding + separation * 0, occupiedBy: false },
    { x: separation * 1, y: shopItemsPadding + separation * 0, occupiedBy: false },
    { x: separation * 0, y: shopItemsPadding + separation * 1, occupiedBy: false },
    { x: separation * 1, y: shopItemsPadding + separation * 1, occupiedBy: false },
    { x: separation * 0, y: shopItemsPadding + separation * 2, occupiedBy: false },
    { x: separation * 1, y: shopItemsPadding + separation * 2, occupiedBy: false },
]

moneyProgression = function() {
    return o_game_phase_manager.gameRound + 10
}

currentMoney = moneyProgression()

nextOffer = function() {
    return randomBuilding(irandom_range(0, 1))
}

rerollShop = function(){
    if (currentMoney >= rerollPrice) {
        currentMoney -= rerollPrice
        for (var i = 0; i < array_length(shopPosition); i++) {
            var shopItem = shopPosition[i].occupiedBy
            if (shopItem) {
                shopPosition[i].occupiedBy = false
                instance_destroy(shopItem)
            }
        }
    }
}

getSellIntent = function(mouseX, mouseY) {
    var actualSellX = shopX + shopSellPos.x
    var actualSellY = shopY + shopSellPos.y
    
    var distance = point_distance(mouseX, mouseY, actualSellX, actualSellY)

    return { sellIt: distance < shopSellPos.snappingDistance, x: actualSellX, y: actualSellY}
}

sellItem = function(type) {
    // selling gives half purchase price rounded up
    var thePriceRoundUp = ds_map_find_value(global.buildings, type).price + 1
    currentMoney += thePriceRoundUp div 2
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