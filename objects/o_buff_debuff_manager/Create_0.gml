

peaceRate = 2 * one_second
dreadRate = 2 * one_second

modifierList = [array_create(10, 0), array_create(10, 0)]

get = function(modifier, player){
    return modifierList[player][modifier]
}

gain = function(number, modifier, player){
    var newAmount = modifierList[player][modifier] + number
    modifierList[player][modifier] = newAmount
}

lose = function(number, modifier, player){
    modifierList[player][modifier] = modifierList[player][modifier] - number
}

triggerPatriotism = function(damage, player) {
    o_stability_manager.stabilize(min(modifierList[player][Modifier.PATRIOTISM], damage), player)
}

triggerPeace = function(player) {
    o_stability_manager.stabilize(modifierList[player][Modifier.PEACE], player)
}

triggerDread = function(player) {
    o_stability_manager.destabilize(modifierList[player][Modifier.DREAD], player)
}

getWeatherSpeedBoost = function(speed, player) {
    var asPercent = modifierList[player][Modifier.WEATHER] / 100
    return speed * (1 + asPercent)
}

getWeatherEvasionBoost = function(evasion, player) {
    var asPercent = modifierList[player][Modifier.WEATHER] / 100
    return evasion * (1 + asPercent)
}

getMoraleDamageBoost = function(damage, player) {
    return damage + modifierList[player][Modifier.MORALE]
}

getProsperityAndFamineModifiedCooldown = function(cooldown, player) {
    var prosperityPercent = modifierList[player][Modifier.PROSPERITY] / 100
    var faminePercent = modifierList[player][Modifier.FAMINE] / 100
    
    if (prosperityPercent > faminePercent) {
        return (cooldown / (1 + prosperityPercent - faminePercent))
    } else if (prosperityPercent < faminePercent) {
        return (cooldown * (1 + faminePercent - prosperityPercent))
    } else {
        return cooldown
    }
    
}

triggerMysticism = function(player) {
    var opponent = getOpponentOf(player)
    // TODO tie it to number of spiritual buildings 
    o_stability_manager.destabilize(modifierList[player][Modifier.MYSTICISM] * 1 , opponent)
}

resetAfterBattle = function() {
    modifierList = [array_create(10, 0), array_create(10, 0)]
}

#region Setup ui display of buff debuffs

var inventory_sprite = object_get_sprite(o_gui_buff_debuff_info)
instance_create_layer(0 - sprite_get_width(inventory_sprite), guiYBot, "Gui", o_gui_buff_debuff_info, { player: Player.US})

instance_create_layer(guiWidth, guiYBot, "Gui", o_gui_buff_debuff_info, { player: Player.THEM})

#endregion
