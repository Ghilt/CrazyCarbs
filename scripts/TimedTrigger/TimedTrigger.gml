/// @desc Triggers on battle phase over and over again. Registering itself for step update and resetAfterBattle at o_atom_manager
/// @param {Id.Instance} _instance The instance that is using this atom. Allows it to be cleanuped after instance is destroyed
/// @param {Real} _player Player.US or Player.THEM
/// @param {Function | Real} _cooldownNumberOrFunction Description
/// @param {Function} _activationCallbackPlayer Description
/// @param {Function} _activationCallbackEnemy Description
/// @param {Real} _times How many times this can trigger in asingle battle round. -1 means infinite
function TimedTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy, _times = -1) constructor
{
    player = _player
    current_frame = 0
    cooldownNumberOrFunction = _cooldownNumberOrFunction
    triggerTimes = 0
    maxTriggerTimes = _times
    activationCallbackPlayer = _activationCallbackPlayer
    activationCallbackEnemy = _activationCallbackEnemy
     
    doStep = function() { 
        if (maxTriggerTimes != -1 && triggerTimes >= maxTriggerTimes) {
            return;
        }
        
        if (current_frame == getCurrentCooldown()) {
            current_frame = 0; 
            triggerTimes += 1
            if (player == Player.US) {
                activationCallbackPlayer()
            } else {
                activationCallbackEnemy()
            }
        
        } else {
            current_frame += 1;
        }
    }
    
    resetAfterBattle = function() { 
        current_frame = 0
        triggerTimes = 0
    }
    
    getCurrentCooldown = function() {
        //This allows for children to either have their cooldown as a simple variable or a function
        // Interesting GMS legacy note: is_callable(...) returns true if testing a number
        var childDefinedCooldown = is_method(cooldownNumberOrFunction) ? cooldownNumberOrFunction() : cooldownNumberOrFunction
        return o_buff_debuff_manager.getProsperityAndFamineModifiedCooldown(childDefinedCooldown, player)
    }
    
    o_atom_manager.registerForResetAfterBattle(_instance, resetAfterBattle)
    o_atom_manager.registerForStep(_instance, doStep)
}

function OnceTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy)  
    : TimedTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy, 1) constructor
{
    
}

