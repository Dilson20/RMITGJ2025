/// @function save_score_to_txt(player_name, final_score)
/// @param {string} player_name The player's name
/// @param {real} final_score The final score to save
function save_score_to_txt(player_name, final_score) {
    var filename = "scores.txt";
    var filepath = working_directory + filename;
    
    // Check if file exists to determine if we need headers
    var file_exists = file_exists(filepath);
    
    // Open file in append mode
    var file = file_text_open_append(filepath);
    
    // Write headers if new file
    if (!file_exists) {
        file_text_write_string(file, "========== GAME SCORES ==========");
        file_text_writeln(file);
        file_text_writeln(file);
    }
    
    // Write score data in a readable format
    file_text_write_string(file, "Name: " + player_name);
    file_text_writeln(file);
    file_text_write_string(file, "Score: " + string(final_score));
    file_text_writeln(file);
    file_text_write_string(file, "--------------------------------");
    file_text_writeln(file);
    
    // Close file
    file_text_close(file);
    
    show_debug_message("💾 Score saved - Name: " + player_name + " | Score: " + string(final_score));
    
    return filename;
}