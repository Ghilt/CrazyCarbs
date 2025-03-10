var displacement = vectorSubtract(instancePosition(id), previousPos)

image_index = vectorQuadrant(displacement)


previousPos = instancePosition(id)