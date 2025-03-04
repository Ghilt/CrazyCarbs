enum Player {
    US, THEM
}

function getOpponentOf(player) {
    if (player == Player.US) {
        return Player.THEM
    } else {
        return Player.US
    }
}
