#macro pp ppp("Reached!")


// Quick debug print
function ppp(){
    var _str = "";

    for (var i = 0; i < argument_count; i ++)
    {
        _str += " | "+ string(argument[i]);
    }

    show_debug_message(_str);
}


global.debugInstanceCapture = false 

// Debug printer for inserting in code where many instances runs and you simply want to inspect one of them.
// This 'captures' the first instance, and just prints for that one
// Put the instance as the first 
function pppp(){
    
    if (!global.debugInstanceCapture) {
        global.debugInstanceCapture = argument[0]
    } else if (global.debugInstanceCapture != argument[0]) {
        return;
    }
    
    var _str = "Captured: ";

    for (var i = 0; i < argument_count; i ++)
    {
        _str += " | "+ string(argument[i]);
    }

    show_debug_message(_str);
}

global.debugInstanceCount = [] 

// Debug printing and counting unique instances 
// only prints if it is a fresh instance encountered
function ppu(){
    
    var exists = array_contains(global.debugInstanceCount, argument[0])
    if (!exists) {
        array_push(global.debugInstanceCount, argument[0])
    } else {
        return;
    }
    
    var currenctCount = array_length(global.debugInstanceCount)

    
    var _str = "Counted: " + string(currenctCount);

    for (var i = 0; i < argument_count; i ++)
    {
        _str += " | "+ string(argument[i]);
    }

    show_debug_message(_str);
}