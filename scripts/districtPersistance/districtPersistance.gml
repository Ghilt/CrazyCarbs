/// @function convertToSavedCityDistrict
/// @description Converts a CityDistrict to a SavedCityDistrict
/// @param {CityDistrict} district The CityDistrict to convert
/// @returns {SavedCityDistrict} The converted SavedCityDistrict
function convertToSavedCityDistrict(district) {
    var buildingType = -1
    if (district.occupiedBy != false) {
        ppp("ass", district.relativeX, district.relativeY)
        buildingType = district.occupiedBy.type
    }
    return new SavedCityDistrict(district.relativeX, district.relativeY, district.terrain, buildingType, district.buildingRotated)
}

/// @function saveDistrictsToFile
/// @description Saves a list of districts and player info to a JSON file
/// @param {array} districts The array of districts to save
/// @param {struct} playerInfo Information about the player
/// @param {string} filename The name of the file to save to (without extension)
/// @returns {bool} True if save was successful, false otherwise
function saveDistrictsToFile(districts, playerInfo, filename) {
    // Create saves directory if it doesn't exist
    if (!directory_exists(working_directory + "/saves")) {
        directory_create(working_directory + "/saves")
    }
    
    // Convert districts to SavedCityDistrict
    var savedDistricts = array_map(districts, convertToSavedCityDistrict)
    
    // Create a struct to hold both districts and player info
    var saveData = {
        districts: savedDistricts,
        playerInfo: playerInfo
    }
    
    // Convert to JSON
    var json_string = json_stringify(saveData)
    
    // Open file for writing
    var file = file_text_open_write(working_directory + "/saves/" + filename + ".json")
    if (file == -1) {
        show_debug_message("Failed to open file for writing: " + filename)
        return false
    }
    
    // Write the JSON string
    file_text_write_string(file, json_string)
    
    // Close the file
    file_text_close(file)
    
    show_debug_message("Saved build to file: " + filename)
    return true
}

/// @function loadDistrictsFromFile
/// @description Loads districts and player info from a JSON file
/// @param {string} filename The name of the file to load from (without extension)
/// @returns {struct} A struct containing districts and playerInfo, or undefined if loading failed
function loadDistrictsFromFile(filename) {
    var file_path = working_directory + "/saves/" + filename + ".json"
    
    // Check if file exists
    if (!file_exists(file_path)) {
        show_debug_message("File does not exist: " + filename)
        return undefined
    }
    
    // Open file for reading
    var file = file_text_open_read(file_path)
    if (file == -1) {
        show_debug_message("Failed to open file for reading: " + filename)
        return undefined
    }
    
    // Read the JSON string
    var json_string = file_text_read_string(file)
    
    // Close the file
    file_text_close(file)
    
    // Parse the JSON
    var saveData = json_parse(json_string)
    if (is_undefined(saveData)) {
        show_debug_message("Failed to parse JSON from file: " + filename)
        return undefined
    }
    
    return saveData
}

/// @function deleteDistrictFile
/// @description Deletes a district save file
/// @param {string} filename The name of the file to delete (without extension)
/// @returns {bool} True if deletion was successful, false otherwise
function deleteDistrictFile(filename) {
    var file_path = working_directory + "/saves/" + filename + ".json"
    if (file_exists(file_path)) {
        return file_delete(file_path)
    }
    return false
}

/// @function listDistrictFiles
/// @description Lists all available district save files
/// @returns {array} Array of filenames (without extension)
function listDistrictFiles() {
    var files = []
    var dir = working_directory + "/saves"
    
    if (!directory_exists(dir)) {
        return files
    }
    
    var file = file_find_first(dir + "/*.json", 0)
    while (file != "") {
        // Remove .json extension and add to list
        files[array_length(files)] = string_delete(file, string_length(file) - 5, 5)
        file = file_find_next()
    }
    file_find_close()
    
    return files
} 