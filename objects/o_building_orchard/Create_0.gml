type = Building.ORCHARD

// Inherit the parent event
event_inherited()


onAbilityActivationPlayer = function(){
    // generate resource in ui layer
    o_buff_debuff_manager.gain(1, stats.buff, player)
}

onAbilityActivationEnemy = function(){
    // generate resource in world layer
    o_buff_debuff_manager.gain(1, stats.buff, player)
}

everySecondAtom = new TimedTrigger(id, player, stats.cooldown, onAbilityActivationPlayer, onAbilityActivationEnemy)