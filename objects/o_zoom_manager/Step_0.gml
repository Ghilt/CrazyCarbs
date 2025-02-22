// Not that this depth storing really belongs in this object. But it'll go here for now 
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

array_foreach(objectsInAir, method(ctx, function(_obj){
    with(_obj) depth = other.shallowest - bbox_bottom;
}))
