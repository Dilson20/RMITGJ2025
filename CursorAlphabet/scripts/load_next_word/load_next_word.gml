function load_next_word() {
    // Initialize word_list if not already done
    if (!variable_instance_exists(id, "word_list") || word_list == undefined) {
        word_list = word_list_1;  // Default to level 1
    }
    
    // Initialize revealed if not already done
    if (!variable_instance_exists(id, "revealed") || revealed == undefined) {
        revealed = "";
    }
    
    if (string_pos("_", revealed) == 0) {  // Word completed
        with (obj_letter) instance_destroy();  // Clear letters
        
        // Start transition
        round_transition = true;
        transition_timer = TRANSITION_DURATION;

        // Check if all words (5 rounds) in current level are completed
        if (word_index >= 5) { // Fixed 5 rounds per level
            // Save time left for completed level
            var seconds_left = ceil(timer / room_speed);
            
            switch (current_level) {
                case 1:
                    global.level1_time_left = seconds_left;
                    show_debug_message("✅ Level 1 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    break;
                case 2:
                    global.level2_time_left = seconds_left;
                    show_debug_message("✅ Level 2 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    break;
                case 3:
                    global.level3_time_left = seconds_left;
                    show_debug_message("✅ Level 3 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    
                    // Calculate final score
                    global.total_score = (global.level1_time_left * 100) + 
                                       (global.level2_time_left * 100) + 
                                       (global.level3_time_left * 100);
                    
                    // Save score to file
                    save_score_to_ini(global.player_name, global.total_score);
                    
                    // All levels completed - YOU WIN!
                    game_over = true;
                    show_winning_screen = true;
                    show_debug_message("🎉 ALL LEVELS COMPLETED! Final Score: " + string(global.total_score));
                    return;
            }
            
            // Move to next level
            current_level++;
            word_index = 0;
        
            // Select appropriate word list for the new level
            switch (current_level) {
                case 1:
                    word_list = word_list_1;
                    timer = time_limit_level_1; // 120 seconds for Level 1
                    static_bubbles = true; // Static bubbles for Level 1
                    show_debug_message("📚 Starting Level 1 - 120 seconds!");
                    break;
                case 2:
                    word_list = word_list_2;
                    timer = time_limit_level_2; // 240 seconds for Level 2
                    static_bubbles = true; // Static bubbles for Level 2
                    show_debug_message("📚 Starting Level 2 - 240 seconds!");
                    break;
                case 3:
                    word_list = word_list_3;
                    timer = time_limit_level_3; // 240 seconds for Level 3
                    static_bubbles = false; // Animated bubbles for Level 3
                    show_debug_message("📚 Starting Level 3 - 240 seconds!");
                    break;
                default:
                    // No more levels - game complete!
                    game_over = true;
                    show_debug_message("🎉 All levels completed! You win!");
                    return;
            }
        }
    
        // Check if we've run out of words
        if (word_index >= array_length(word_list)) {
            game_over = true;
            show_debug_message("🎉 Level " + string(current_level) + " completed! Game Over!");
            return;
        }

        // Clear all existing letters
        with (obj_letter) {
            instance_destroy();
        }

        word = string_upper(word_list[word_index]);
        revealed = string_repeat("_", string_length(word));

        show_debug_message("🔤 New word: " + word + " (Level " + string(current_level) + ", Word " + string(word_index + 1) + ")");

        // Reset the global spawn timer so new letters start appearing immediately
        if (variable_global_exists("spawn_timer")) {
            global.spawn_timer = 0;
        }

        word_index++;
    }
}