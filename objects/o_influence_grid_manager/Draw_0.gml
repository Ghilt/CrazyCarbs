if (debugGrid) {
    
    for (var i = 0; i < array_length(influenceGrid); i++) {
        draw_circle(x + influenceGrid[i].x * buildingSize , y + influenceGrid[i].y * buildingSize , 5, false)
    }
    //draw_circle
    
}
