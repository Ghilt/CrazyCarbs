// Inherit the parent event
event_inherited();

if ( player == Player.US) {
    draw_text_ext_transformed(x + 32, y, "Stability", 10, 300, 1, 1, -90)
} else {
    draw_text_ext_transformed(x + 32, y, "Enemy Stability", 10, 300, 1, 1, -90)
}

