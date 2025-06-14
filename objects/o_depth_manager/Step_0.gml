// TODO -> solve that my room is larger than 16k pixels high

// Remember the tag belongs to the object, not to individual instances. That is why with(...) does such good work here
var objectsOnGround = tag_get_asset_ids("depth_sorted_ground", asset_object)
var objectsInAir = tag_get_asset_ids("depth_sorted_air", asset_object)


var ctx = { shallowest: 0 }
array_foreach(objectsOnGround, method(ctx, function(_obj){
    with(_obj) {
        var depthSortedDepth = -y * 100 - x // Objects on ground are buildings. On tiles, which is ordered by y first and then x second
        depth = depthSortedDepth
        other.shallowest = min(depthSortedDepth, other.shallowest)
    }
}))

// TODO something is wrong here; the ground particle system of the effect manager is at -10000 and its behaving super weird
array_foreach(particleSystems, method(ctx, function(_obj){
    part_system_depth(_obj.particleSystem, shallowest - _obj.pos.y)
    shallowest = min(-_obj.pos.y, shallowest)
}))

array_foreach(objectsInAir, method(ctx, function(_obj){
    with(_obj) depth = other.shallowest - bbox_bottom;
}))
