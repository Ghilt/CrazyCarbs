draw_text(shopX, shopY, "Money: " + string(o_shop_manager.currentMoney))

for (var i = 0; i < array_length(shopPosition); i++) {
    if (!shopPosition[i].occupiedBy) {
        continue;
    }   
     
    var price = ds_map_find_value(global.buildings, shopPosition[i].occupiedBy.type).price
    var pricePosition = priceUiPosition(shopPosition[i].x, shopPosition[i].y)
    
    draw_text(pricePosition.x, pricePosition.y, "Price: " + string(price))
    
}