if (!game_over) {
    if (revealed == word) {
        show_debug_message("✅ Word solved: " + word);
        alarm[0] = room_speed * 2; // Delay 2 seconds before next word
    }
    else if (attempts_left <= 0) {
        show_debug_message("❌ Out of attempts for: " + word);
        alarm[0] = room_speed * 2; // Delay before next word
    }
}
