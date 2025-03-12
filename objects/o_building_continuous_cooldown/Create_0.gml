// Inherit the parent event
event_inherited();

current_frame = 0

onAbilityActivationPlayer = function (){
    // should be overridden by children
    ppp("Parent building reporting use")
}

onAbilityActivationEnemy = function (){
    // should be overridden by children
    ppp("Parent building reporting use")
}