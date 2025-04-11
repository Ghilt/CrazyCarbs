/// @desc Triggers on battle phase over and over again. Registering itself for step update and resetAfterBattle at o_atom_manager
/// A payoff is a trigger that consumes resources. It does obey its cooldown, its resource requirement and also that all payoffs need to happen before they cycle 
/// @param {Id.Instance} _instance The instance that is using this atom. Allows it to be cleanuped after instance is destroyed
/// @param {Real} _player Player.US or Player.THEM
/// @param {Function | Real} _cooldownNumberOrFunction Description
/// @param {Function} _activationCallbackPlayer Description
/// @param {Function} _activationCallbackEnemy Description
/// @param {Array} _cost an array of resources [{type, amount}] that will be consumed when this successfully triggers
/// @param {Real} _times How many times this can trigger in asingle battle round. -1 means infinite
function PayoffTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy, _cost, _times = -1) constructor
{
    cost = _cost
    player = _player
    current_frame = 0
    cooldownNumberOrFunction = _cooldownNumberOrFunction
    cooldownPassed = false
    triggerTimes = 0
    maxTriggerTimes = _times
    activationCallbackPlayer = _activationCallbackPlayer
    activationCallbackEnemy = _activationCallbackEnemy
    
    doStep = function() { 
        if (maxTriggerTimes != -1 && triggerTimes >= maxTriggerTimes) {
            return;
        }
        
        // Check if instance still exists
        //if (!instance_exists(_instance)) {
            //return;
        //}
        
        //This allows for children to either have their cooldown as a simple variable or a function
        // Interesting GMS legacy note: is_callable(...) returns true if testing a number
        var childDefinedCooldown = is_method(cooldownNumberOrFunction) ? cooldownNumberOrFunction() : cooldownNumberOrFunction
        
        var buffDebuffedCooldown = o_buff_debuff_manager.getProsperityAndFaminModifiedCooldown(childDefinedCooldown, player)
        if (current_frame == buffDebuffedCooldown) {
            current_frame += 1;
            cooldownPassed = true
        
        } else if (current_frame > buffDebuffedCooldown) { 
            // Do nothing
            // Wait for resource manager to trigger us, in the queue and consume the resources
        } else  {
            current_frame += 1;
        }
    }
    
    isReady = function() { 
        return cooldownPassed
    }
    
    resetAfterBattle = function() { 
        cooldownPassed = false
        current_frame = 0
        triggerTimes = 0
    }
    
    getCost = function() { 
        return cost
    }
    
    getTriggerCount = function() { 
        return triggerTimes
    }
    
    triggerPayoff = function() { 
        if (player == Player.US) {
            activationCallbackPlayer()
        } else {
            activationCallbackEnemy()
        }
        
        cooldownPassed = false
        current_frame = 0
        triggerTimes +=1
    }
    
    o_atom_manager.registerForResetAfterBattle(_instance, resetAfterBattle)
    o_atom_manager.registerForStepPayoff(_instance, doStep, isReady, getCost, getTriggerCount, triggerPayoff)
}

function OncePayoffTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy, _cost)  
    : PayoffTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy, _cost, 1) constructor
{
    
}

