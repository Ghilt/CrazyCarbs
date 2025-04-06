/// @function PlayerData
/// @description Creates a new PlayerData struct to store player information
/// @param {Direction} _direction The direction the player is facing (NORTH, EAST, SOUTH, or WEST)
/// @param {string} _name The name of the player
function PlayerData(_direction, _name, _wins, _losses) constructor
{
    direction = _direction
    version = 1 // Current game version, integer
    name = _name
    wins = _wins
    losses = _losses
    gameRound = _wins + _losses
    
}