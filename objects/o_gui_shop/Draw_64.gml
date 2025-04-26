// Inherit the parent event
event_inherited();


// 'other' brings you out of the re scope that you get with 'with'
with (o_shop_manager) {
    draw_set_font(f_shop_info)

    draw_text(other.x, other.y, "Money: " + string(currentMoney))
    
    for (var i = 0; i < array_length(shopPosition); i++) {
        if (!shopPosition[i].occupiedBy) {
            continue;
        }   
        
        var price = ds_map_find_value(global.buildings, shopPosition[i].occupiedBy.type).price
        var pricePosition = other.priceUiPosition(shopPosition[i].x, shopPosition[i].y)
        
        draw_text(pricePosition.x, pricePosition.y, "Price: " + string(price))
        
    }
    
    draw_circle_color(other.x + shopSellPos.x, other.y + shopSellPos.y, shopSellPos.snappingDistance, c_orange, c_yellow, false)
    draw_text_color(other.x + shopSellPos.x - 14, other.y + shopSellPos.y, "Sell", c_black, c_red, c_black, c_black, 1)
}

