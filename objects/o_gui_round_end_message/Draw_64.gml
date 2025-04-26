draw_self()
draw_set_font(f_end_round_screen)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_transformed(x, y, victory ? "Victory" : "Defeat", 1, 1, 0)
draw_set_halign(fa_left);
draw_set_valign(fa_top);