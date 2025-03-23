function ShipStats(_hull, _damage, _salvoCount, _weaponCooldown, _range, _evasion, _armor, _blockadeDamage, _inventorySlots) constructor {
    hull = _hull
    damage = _damage
    salvoCount = _salvoCount
    weaponCooldown = _weaponCooldown
    range = _range
    evasion = _evasion
    armor = _armor
    blockadeDamage = _blockadeDamage
    inventorySlots = _inventorySlots
    
    // Value methods are 'ingame maths' conversions which will be used in calculations
    getRangeValue = function() {
        return range * TILE_SIZE
    }
    
    getSpeedValue = function() {
        return global.shipBaseSpeed * TILE_SIZE
    }
    
    getBlockadeRangeValue = function() {
        return range * TILE_SIZE
    }
    
    getRangeValue = function() {
        return range * TILE_SIZE    
    }
}