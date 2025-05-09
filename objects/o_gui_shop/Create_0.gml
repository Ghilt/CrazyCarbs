image_xscale = o_shop_manager.shopWidth
image_yscale = o_shop_manager.shopHeight
image_alpha = 0.8


// acts as anchor for related ui components
guiState = new GuiState(x, y, x, guiYBot)

priceUiPosition = function(buildXOfOffer, buildYOfOffer) {
    return { x: buildXOfOffer + x, y: buildYOfOffer + y }
}