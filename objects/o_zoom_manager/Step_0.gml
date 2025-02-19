// Not that this depth storing really belongs in this object. But it'll go here for now 
// Remember the tag belongs to the object, not to individual instances. That is why with(...) does such good work here
var _objects = tag_get_asset_ids("depth_sorted", asset_object)
array_foreach(_objects, function(_obj){
    with(_obj) depth = -bbox_bottom;
})
