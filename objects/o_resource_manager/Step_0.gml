for (var i = 0; i < array_length(resourceInstances); i++) {
    resourceInstances[i].x = lerp(resourceInstances[i].x, 0, 0.02)
    resourceInstances[i].y = lerp(resourceInstances[i].y, 0, 0.02)
}