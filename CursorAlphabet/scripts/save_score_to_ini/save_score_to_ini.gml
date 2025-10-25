/// @function save_score_to_ini(player_name, final_score)
/// @param {string} player_name The player's name
/// @param {real} final_score The final score to save
function save_score_to_ini(player_name, final_score) {
    var filename = "scores.ini";
    
    // Open the ini file
    ini_open(filename);
    
    // Get the current number of scores saved
    var score_count = ini_read_real("Stats", "TotalScores", 0);
    
    // Increment the count
    score_count++;
    
    // Create a unique section name for this score entry
    var section_name = "Score" + string(score_count);
    
    // Write the new score data
    ini_write_string(section_name, "Name", player_name);
    ini_write_real(section_name, "Score", final_score);
    ini_write_string(section_name, "Date", date_datetime_string(date_current_datetime()));
    
    // Update the total count
    ini_write_real("Stats", "TotalScores", score_count);
    
    // Close the ini file
    ini_close();
    
    show_debug_message("💾 Score saved to ini - Name: " + player_name + " | Score: " + string(final_score));
    
    return filename;
}

/// @function load_all_scores()
/// @description Loads all scores from the ini file and returns them as a string
function load_all_scores() {
    var filename = "scores.ini";
    var result = "";
    
    // Open the ini file
    ini_open(filename);
    
    // Get the total number of scores
    var score_count = ini_read_real("Stats", "TotalScores", 0);
    
    if (score_count == 0) {
        result = "No scores yet!";
    } else {
        result = "========== HIGH SCORES ==========\n\n";
        
        // Loop through all saved scores
        for (var i = 1; i <= score_count; i++) {
            var section_name = "Score" + string(i);
            
            var player_name = ini_read_string(section_name, "Name", "Unknown");
            var player_score = ini_read_real(section_name, "Score", 0);
            var date_time = ini_read_string(section_name, "Date", "");
            
            result += string(i) + ". " + player_name + " - " + string(player_score) + "\n";
            result += "   (" + date_time + ")\n\n";
        }
    }
    
    // Close the ini file
    ini_close();
    
    return result;
}

/// @function get_highest_score()
/// @description Returns the highest score from all saved scores
function get_highest_score() {
    var filename = "scores.ini";
    var highest = 0;
    
    // Open the ini file
    ini_open(filename);
    
    // Get the total number of scores
    var score_count = ini_read_real("Stats", "TotalScores", 0);
    
    // Loop through all saved scores to find highest
    for (var i = 1; i <= score_count; i++) {
        var section_name = "Score" + string(i);
        var player_score = ini_read_real(section_name, "Score", 0);
        
        if (player_score > highest) {
            highest = player_score;
        }
    }
    
    // Close the ini file
    ini_close();
    
    return highest;
}
