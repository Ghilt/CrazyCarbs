/// @desc Triggers on battle phase over and over again. Registering itself for step update and resetAfterBattle at o_atom_manager
/// @param {Id.Instance} _instance The instance that is using this atom. Allows it to be cleanuped after instance is destroyed
/// @param {Real} _player Player.US or Player.THEM
/// @param {Function | Real} _cooldownNumberOrFunction Description
/// @param {Function} _activationCallbackPlayer Description
/// @param {Function} _activationCallbackEnemy Description
function EveryXSecondTrigger(_instance, _player, _cooldownNumberOrFunction, _activationCallbackPlayer, _activationCallbackEnemy) constructor
{
    player = _player
    current_frame = 0
    cooldownNumberOrFunction = _cooldownNumberOrFunction
    activationCallbackPlayer = _activationCallbackPlayer
    activationCallbackEnemy = _activationCallbackEnemy
     
    doStep = function() { 
        if (!o_game_phase_manager.isBattlePhase()) {
            return;
        }
        
        //This allows for children to either have their cooldown as a simple variable or a function
        // Interesting GMS legacy note: is_callable(...) returns true if testing a number
        var childDefinedCooldown = is_method(cooldownNumberOrFunction) ? cooldownNumberOrFunction() : cooldownNumberOrFunction
        var buffDebuffedCooldown = o_buff_debuff_manager.getProsperityAndFaminModifiedCooldown(childDefinedCooldown, player)
        if (current_frame == childDefinedCooldown) {
            current_frame = 0; 
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
    }
    
    o_atom_manager.registerForResetAfterBattle(_instance, resetAfterBattle)
    o_atom_manager.registerForStep(_instance, doStep)
}