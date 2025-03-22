
enum Resource
{
    LUMBER,
    HONEY,
    ORE
}

var resourceData = [
    { type: Resource.LUMBER, sprite: s_resource_lumber },
    { type: Resource.HONEY, sprite: s_resource_honey },
    { type: Resource.ORE, sprite: s_resource_ore }
]

global.resourceTypes = ds_map_create()
for (var i = 0; i < array_length(resourceData); i++) {
    ds_map_add(global.resourceTypes, resourceData[i].type, resourceData[i])        
}