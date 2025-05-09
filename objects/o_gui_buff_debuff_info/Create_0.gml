guiState = new GuiState(x, y, x + sprite_width, y - sprite_height)

if (player == Player.US) {
    guiState = new GuiState(x, y, x + sprite_width, y - sprite_height)
} else {
    guiState = new GuiState(x, y, x - sprite_width, y - sprite_height)
}

xOffset = 100
yOffset = 20
columnWidth = 70
rowHeight = 75


var boardAnchorDimensions = { width: sprite_get_width(sprite_index), height: sprite_get_height(sprite_index)}

var types = [
    { player, type: Modifier.PATRIOTISM, initSprite: s_modifier_patriotism, boardAnchorDimensions},
    { player, type: Modifier.WEATHER, initSprite: s_modifier_weather, boardAnchorDimensions},
    { player, type: Modifier.MORALE, initSprite: s_modifier_morale, boardAnchorDimensions},
    { player, type: Modifier.PEACE, initSprite: s_modifier_peace, boardAnchorDimensions},
    { player, type: Modifier.PROSPERITY, initSprite: s_modifier_prosperity, boardAnchorDimensions},
    { player, type: Modifier.MYSTICISM, initSprite: s_modifier_mysticism, boardAnchorDimensions},
    { player, type: Modifier.RECKLESSNESS, initSprite: s_modifier_recklessness, boardAnchorDimensions},
    { player, type: Modifier.SCURVY, initSprite: s_modifier_scurvy, boardAnchorDimensions},
    { player, type: Modifier.DREAD, initSprite: s_modifier_dread, boardAnchorDimensions},
    { player, type: Modifier.FAMINE, initSprite: s_modifier_famine, boardAnchorDimensions},

]

indicators = [
    [
        instance_create_layer(x + xOffset, y + yOffset + 0 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.PATRIOTISM]),
        instance_create_layer(x + xOffset, y + yOffset + 1 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.WEATHER]),
        instance_create_layer(x + xOffset, y + yOffset + 2 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.MORALE]),
        instance_create_layer(x + xOffset, y + yOffset + 3 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.PEACE]),
        instance_create_layer(x + xOffset, y + yOffset + 4 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.PROSPERITY]),
        instance_create_layer(x + xOffset + 2 * columnWidth, y + yOffset + 0 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.MYSTICISM]),
        instance_create_layer(x + xOffset + 2 * columnWidth, y + yOffset + 1 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.RECKLESSNESS]),
        instance_create_layer(x + xOffset + 2 * columnWidth, y + yOffset + 2 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.SCURVY]),
        instance_create_layer(x + xOffset + 2 * columnWidth, y + yOffset + 3 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.DREAD]),
        instance_create_layer(x + xOffset + 2 * columnWidth, y + yOffset + 4 * rowHeight, "Gui", o_gui_buff_indicator, types[Modifier.FAMINE]),
    ]
]