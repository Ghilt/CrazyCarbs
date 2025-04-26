if (o_building_info_manager.hovering) {
    draw_self()
    
    draw_set_font(f_building_info)
    
    var lineSpace = font_get_size(f_building_info) + font_get_size(f_building_info) * 0.3
    draw_text_ext(x , y, o_building_info_manager.getEffectDescription(), lineSpace, sprite_width)
    
}