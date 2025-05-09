draw_self()

draw_set_font(f_building_info)

var lineSpace = font_get_size(f_building_info) + font_get_size(f_building_info) * 0.3

draw_text_ext(x + xTextOffset, y + yTextOffset, string(o_buff_debuff_manager.get(type, player)), lineSpace, sprite_width)