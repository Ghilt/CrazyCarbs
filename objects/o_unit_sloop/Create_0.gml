type = Building.SHIP_SLOOP

stats = new ShipStats(10, 3, 1, 2 * one_second, 3, 0, 0, 1, 1)

event_inherited()

getBuildingDescription = function(){
     return "Ship"
}