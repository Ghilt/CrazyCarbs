for (var i = 0; i < array_length(shopPosition); i++) {
    if (shopPosition[i].occupiedBy) {
        continue;
    }    
    var buildPos = { x: shopPosition[i].x, y: shopPosition[i].y }
    var battlePos = {x : buildPos.x, y: buildPos.y + itemSize}
    shopPosition[i].occupiedBy = instance_create_layer(buildPos.x, buildPos.y, "Gui", o_placable_instance, { type: nextOffer(), owner: id, buildPos, battlePos }) 
    
}