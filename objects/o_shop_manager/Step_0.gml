for (var i = 0; i < array_length(shopPosition); i++) {
    if (shopPosition[i].occupiedBy) {
        continue;
    }    
    
    // shop position empty, refill it for now
    var buildPos = { x: shopXItems + shopPosition[i].x, y: shopYItems + shopPosition[i].y }
    var battlePos = { x : buildPos.x, y: buildPos.y + guiHeight - shopYItems }
    var guiState = new GuiState(buildPos.x, buildPos.y, battlePos.x, battlePos.y)
    
    shopPosition[i].occupiedBy = instance_create_layer(buildPos.x, buildPos.y, "Gui", o_placable_instance, { type: nextOffer(), owner: id, guiState }) 
    
}