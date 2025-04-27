
enum Building
{
    STARTING_PORT,
    GOLD_MINE,
    LUMBER_MILL,
    GRAND_OAK,
    ORCHARD,
    BEEKEEPER,
    SHIP_SLOOP,
    // the below is not implemented
    RUM_DISTILLERY,
    SUGAR_PLANTATION,
    FISHING_DOCK,
    SALT_WORKS,
    SPICE_GARDEN,
    COTTON_PLANTATION,
    LIVESTOCK_RANCH
};

// Terrain used by the game logic
enum Terrain
{
    SEA,
    GROUND
}

// Fine grained terrain used in map creation visually. Maps onto Terrain enum
enum MapTerrain
{
    NONE,
    BRUSH,
    PLAINS,
    SEA,
    SEA_SHALLOW,
    UNK1,
    SAND,
    PLAYER_SPAWN,
    MOUNTAIN,
    RIVER,
    SWAMP,
    FOREST,
    UNK2,
    ENEMY_SPAWN,
    UNK3,
    UNK4
}


/*
 * Enum, asset
 * price, terrain, footprint_width, footprint_height
 * stats
 * name, descriptionGenerator 
*/

var buildingData = [
    new BuildingData(Building.STARTING_PORT, o_building_starting_port, 
        0, Terrain.SEA, 1, 1,
        { overproductionHealingPower: 10 }, 
        "Port", getDescriptionGenerator("Overproduction trigger: Consume all resources and gain |overproductionHealingPower| stability.")),
    new BuildingData(Building.GOLD_MINE, o_building_gold_mine, 
        4, Terrain.GROUND, 1, 1,
        { productionAmount: 1, cooldown: 3 * one_second, resource: Resource.ORE }, 
        "Ore Mine", getDescriptionGenerator("Every |cooldown| ms: Generate |productionAmount| ore.")),
    new BuildingData(Building.LUMBER_MILL, o_building_lumber_mill, 
        3, Terrain.GROUND, 1, 1,
        { productionAmount: 1, cooldown: 1 * one_second, resource: Resource.LUMBER }, 
        "Lumber mill", getDescriptionGenerator("Every |cooldown| ms: Generate |productionAmount| |resource|.")),
    new BuildingData(Building.GRAND_OAK, o_building_grand_oak, 
        2, Terrain.GROUND, 1, 1,
        {
            healingPower: 8,
            baseCooldown: 5 * one_second,
            adjacencyCooldownReductionBonus: 0.1
        }, 
        "Grand Oak", getDescriptionGenerator("Every |baseCooldown| ms: Gain |healingPower|. Gets reduced by mult_percent(|adjacencyCooldownReductionBonus|) for every adjacent nature building.")),
    new BuildingData(Building.ORCHARD, o_building_orchard, 
        1, Terrain.GROUND, 2, 2,
        { productionAmount: 1, cooldown: 7 * one_second, resource: Resource.ORE }, 
        "Orchard", getDescriptionGenerator("Does nothing but has a 2x2 footprint atm")),
    new BuildingData(Building.BEEKEEPER, o_building_beekeeper, 
        1, Terrain.GROUND, 2, 1,
        {
            productionAmount: 1,
            cooldown: 3 * one_second,
            payoffRequirementAmount: 3,
            payoffRequirementType: Resource.LUMBER,
            producesResource: Resource.HONEY
        }, 
        "Beekeeper", getDescriptionGenerator("Every |cooldown| ms: Do stuff. Payoff |cooldown| ms: convert 3 |payoffRequirementType| into 1 |producesResource|")),
    // Ships
    new BuildingData(Building.SHIP_SLOOP, o_unit_sloop, 
        3, Terrain.SEA, 1, 1,
        { todo: 100000 }, 
        "Sloop", getDescriptionGenerator("Todo, Im a ship!")),
]


global.buildings = ds_map_create()
for (var i = 0; i < array_length(buildingData); i++) {
    ds_map_add(global.buildings, buildingData[i].type, buildingData[i])        
}


// For development
// Will return a random building type, besides starting building
function randomBuilding(terrain) {
    if (terrain == Terrain.SEA) {
        return irandom_range(6, 6)
    } else {
        return irandom_range(1, 5)
    }
}

function footprintToCoordinates(anchorDistrict, footprint) {
    var coordinates = array_create(footprint.width * footprint.height)
    for (var yy = 0; yy < footprint.height; yy++) {
        for (var xx = 0; xx < footprint.width; xx++) {
            coordinates[xx + footprint.width * yy] = { x: anchorDistrict.relativeX + xx, y: anchorDistrict.relativeY + yy }    
        }
    }
    return coordinates
}


/**
 * Function Returns a function that is a generator of descriptions with the escape '|variableName|'. 
 * Example: 'Every |cooldown| seconds gain 5 health.'
 */
function getDescriptionGenerator(textTemplate) {
    // splitting and assuming that every other split is text and other templated value
    var splitIt = string_split(textTemplate, "|")
    
    return method({ splitIt }, function(stats) {
        
        var _str = ""
        var subStringsLength = array_length(splitIt)
        for (var i = 0; i < subStringsLength; i++)
        {
            if (i % 2 == 0) {
               _str += splitIt[i] 
            } else {
                _str += string(struct_get(stats, splitIt[i]))
            }
        }
        return _str
    })
}

