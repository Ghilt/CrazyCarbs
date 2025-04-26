// Inherit the parent event
event_inherited();

var healthInfo = string(o_stability_manager.getCurrentStability(player)) + "/" + string(o_stability_manager.getMaxStability(player)) 
if (player == Player.US) {
    draw_text_ext_transformed(x + 32, y, "Stability: " + healthInfo , 10, 300, 1, 1, -90)
} else {
    draw_text_ext_transformed(x + 32, y, "Enemy Stability: " + healthInfo , 10, 300, 1, 1, -90)
}

