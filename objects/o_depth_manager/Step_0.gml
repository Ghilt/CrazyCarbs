// TODO -> solve that my room is larger than 16k pixels high

// Remember the tag belongs to the object, not to individual instances. That is why with(...) does such good work here
var objectsOnGround = tag_get_asset_ids("depth_sorted_ground", asset_object)
var objectsInAir = tag_get_asset_ids("depth_sorted_air", asset_object)

// the below code is an alternative to faking closures with 'with {localVariable}'

var ctx = { shallowest: 0 }
array_foreach(objectsOnGround, method(ctx, function(_obj){
    with(_obj) {
        depth = -bbox_bottom
        other.shallowest = min(-bbox_bottom, other.shallowest)
    }
}))

array_foreach(particleSystems, method(ctx, function(_obj){
    part_system_depth(_obj.particleSystem, shallowest -_obj.pos.y)
    shallowest = min(-_obj.pos.y, shallowest)
}))

array_foreach(objectsInAir, method(ctx, function(_obj){
    with(_obj) depth = other.shallowest - bbox_bottom;
}))
