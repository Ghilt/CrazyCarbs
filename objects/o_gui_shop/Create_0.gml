image_xscale = o_shop_manager.shopWidth
image_yscale = o_shop_manager.shopHeight
image_alpha = 0.8

mov = {
    duration: one_second * 1,
    timePassed: 0,
    originX: x,
    originY: y
}

// acts as anchor for related ui components
buildPos = { x, y }
battlePos = { x, y : guiYBot - 60 }

priceUiPosition = function(buildXOfOffer, buildYOfOffer) {
    return { x: buildXOfOffer + x, y: buildYOfOffer + y }
}