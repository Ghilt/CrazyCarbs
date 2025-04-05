/// @function PlayerData
/// @description Creates a new PlayerData struct to store player information
/// @param {Direction} _direction The direction the player is facing (NORTH, EAST, SOUTH, or WEST)
/// @param {string} _name The name of the player
function PlayerData(_direction, _name) constructor
{
    direction = _direction
    version = 1 // Current game version, integer
    name = _name
    wins = 0
    losses = 0
    
    // Utility method to increment wins
    static incrementWins = function() {
        wins++
    }
    
    // Utility method to increment losses
    static incrementLosses = function() {
        losses++
    }
}