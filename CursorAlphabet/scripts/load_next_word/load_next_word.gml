function load_next_word() {
    // Check if all words in current level are completed
    if (word_index >= array_length(word_list)) {
        // Move to next level
        current_level++;
        word_index = 0;
        
        // Select appropriate word list for the new level
        switch (current_level) {
            case 1:
                word_list = word_list_1;
                timer = time_limit_level_1; // 1 minute for Level 1
                show_debug_message("📚 Starting Level 1 - 1 minute!");
                break;
            case 2:
                word_list = word_list_2;
                timer = time_limit_level_2; // 1.5 minutes for Level 2
                show_debug_message("📚 Starting Level 2 - 1 minute 30 seconds!");
                break;
            case 3:
                word_list = word_list_3;
                timer = time_limit_level_3; // 2 minutes for Level 3
                show_debug_message("📚 Starting Level 3 - 2 minutes!");
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