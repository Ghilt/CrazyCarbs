if (o_stability_manager.inFatigue()) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_ext_transformed(guiWidth/2, guiHeight/2, "Fatigue " + string(o_stability_manager.fatigueDamage), 10, 3000, 2, 2, 0)
}