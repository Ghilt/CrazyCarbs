shopWidth = 400
shopHeight = 600
shopX = guiWidth - shopWidth
shopY = guiYMid
shopItemsPadding = itemSize / 4
shopXItems = shopX + shopItemsPadding
shopYItems = shopY + shopItemsPadding

var inventory_sprite = object_get_sprite(o_gui_shop)
var background = instance_create_layer(guiWidth - shopWidth, guiYMid, "Gui", o_gui_shop)

shopPosition = [
    { x: shopXItems + (itemSize + shopItemsPadding) * 0, y: shopYItems + (itemSize + shopItemsPadding) * 0, occupiedBy: false },
    { x: shopXItems + (itemSize + shopItemsPadding) * 1, y: shopYItems + (itemSize + shopItemsPadding) * 0, occupiedBy: false },
    { x: shopXItems + (itemSize + shopItemsPadding) * 0, y: shopYItems + (itemSize + shopItemsPadding) * 1, occupiedBy: false },
    { x: shopXItems + (itemSize + shopItemsPadding) * 1, y: shopYItems + (itemSize + shopItemsPadding) * 1, occupiedBy: false },
    { x: shopXItems + (itemSize + shopItemsPadding) * 0, y: shopYItems + (itemSize + shopItemsPadding) * 2, occupiedBy: false },
    { x: shopXItems + (itemSize + shopItemsPadding) * 1, y: shopYItems + (itemSize + shopItemsPadding) * 2, occupiedBy: false },
]

nextOffer = function() {
    return randomBuilding()
}
