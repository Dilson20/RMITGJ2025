if (!game_over) {
    if (revealed == word) {
        // Only trigger once when word is just completed
        if (alarm[0] <= 0) {  // FIXED: Only set alarm if not already running
            show_debug_message("✅ Word solved: " + word);
            alarm[0] = room_speed * 2; // Delay 2 seconds before next word
        }
    }
    else if (attempts_left <= 0) {
        // Only trigger once when attempts run out
        if (alarm[0] <= 0) {  // FIXED: Only set alarm if not already running
            show_debug_message("❌ Out of attempts for: " + word);
            alarm[0] = room_speed * 2; // Delay before next word
        }
    }
}