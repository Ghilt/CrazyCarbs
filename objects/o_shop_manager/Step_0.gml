for (var i = 0; i < array_length(shopPosition); i++) {
    if (shopPosition[i].occupiedBy) {
        continue;
    }    
    shopPosition[i].occupiedBy = instance_create_layer(shopPosition[i].x, shopPosition[i].y, "Gui", o_placable_instance, { type: nextOffer() }) 
    
}