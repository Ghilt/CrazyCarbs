function ResourceStore() constructor
{
    resources = ds_map_create()
    
    getResourceCount = function() {
        var resourceTypes = ds_map_values_to_array(resources)
        
        var addSizeOfTypeBucket = function(_accumulator, _current, _index)
        {
            return _accumulator + array_length(_current)
        }
        
        return array_reduce(resourceTypes, addSizeOfTypeBucket, 0)
    }
    
    // This destroys the instances if there are any
    useEveryResource = function(action) {
        var resourceTypes = ds_map_values_to_array(resources)
        var length = array_length(resourceTypes)
        
        // A resource may be represented by a instance. Trigger callback and destroy afterwards.
        var performActionAndDestroy = method({ action }, function(obj) {
            if (obj.instance) {
                action(obj.instance)  
                instance_destroy(obj.instance)                  
            }
        })
        
        array_foreach(arrayFlatten(resourceTypes), performActionAndDestroy)
         
        ds_map_clear(resources)
    }
    
    // This destroys the instances if there are any
    useResources = function(cost, action) {
        
        for (var i = 0; i < array_length(cost); i++) {
            var resourceStructsOfType = resources[? cost[i].type]  
            if (is_undefined(resourceStructsOfType) || array_length(resourceStructsOfType) < cost[i].amount) { 
                throw "Error: Resources did not exist when attempted to use them"
            } 
            
            repeat (cost[i].amount) {
                var resourceStruct = array_pop(resourceStructsOfType)
                if (resourceStruct.instance) {
                    action(resourceStruct.instance)
                    instance_destroy(resourceStruct.instance)    
                } else {
                    action(false) // Call action with false for non-instance resources
                }
            }   
        }
    }
    
    addResource = function(type, instance) {
        // addedAt is used to order the resources when doing things in the ui
        // getTimer() is micro seconds, i had current_time for millies first but then they collide a lot
        var newResource = { addedAt: get_timer(), type, instance } 
        var resourceStructsOfType = resources[? type]
        if (is_undefined(resourceStructsOfType)) {
            ds_map_add(resources, type, [newResource])    
        } else {
            array_push(resourceStructsOfType, newResource)    
        }  
    } 
    
    // cost = [{type, amount}]
    hasResources = function(cost) {
        for (var i = 0; i < array_length(cost); i++) {
            var resourceStructsOfType = resources[? cost[i].type]  
            if (is_undefined(resourceStructsOfType)) { 
                return false
            } else if (array_length(resourceStructsOfType) < cost[i].amount){
                return false    
            }    
        }
        return true
    }
    
    clear = function() {
        var resourceTypes = ds_map_values_to_array(resources)
        var length = array_length(resourceTypes)
        
        // A resource may be represented by a instance. Trigger callback and destroy afterwards.
        var destroyIt = function(obj) {
            if (obj.instance) {
                instance_destroy(obj.instance)                  
            }
        }
        
        array_foreach(arrayFlatten(resourceTypes), destroyIt)
        
        ds_map_clear(resources)
    }
    
    forEeachResourceInCreationOrder = function(callback) {
        var resourceTypes = ds_map_values_to_array(resources)
        var resourceList = arrayFlatten(resourceTypes)
        array_sort(resourceList, function(elm1, elm2)
        {
            return elm1.addedAt - elm2.addedAt;
        })
        array_foreach(resourceList, callback)
    }
}