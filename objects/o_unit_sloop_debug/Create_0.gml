
path = path_add()

targetPos = { x, y }
previousPos = { x, y }

alarm[0] = 90

// So this boat will go into the red mp grid area
// MP grid assumes that your object has a mask that is the same size as the grid cell
// So if your cells are 16x16, it assumes that the object is also a 16x16 sprite with a top left origin
// to make it work well the sprite of the objects using the mp_grid should be the same size or maybe a little bit smaller than the cells

image_speed = 0