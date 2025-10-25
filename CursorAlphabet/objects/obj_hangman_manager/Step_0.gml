// === Handle freeze mechanic ===
if (is_frozen) {
    freeze_timer--;
    if (freeze_timer <= 0) {
        is_frozen = false;
        show_debug_message("❄️ Unfreezed! Player can interact again.");
    }
}

// === Timer countdown (continuous, not reset per word) ===
if (timer_active && !game_over) {
    timer--;
    
    if (timer <= 0) {
        // Time's up for current level!
        game_over = true;
        show_losing_screen = true;
        audio_play_sound(snd_lose, 1, false);  // Play losing sound
        show_debug_message("⏰ Time's up for Level " + string(current_level) + "! Game ended.");
    }
}

// === Check word completion ===
if (!game_over) {
    if (revealed == word) {
        // Only trigger once when word is just completed
        if (alarm[0] <= 0) {
            show_debug_message("✅ Word solved: " + word);
            alarm[0] = room_speed * 2; // Delay 2 seconds before next word
        }
    }
} else if (show_losing_screen) {
    // Check for space press to restart
    if (keyboard_check_pressed(vk_space)) {
        // Stop all audio before restarting
        audio_stop_all();
        room_restart();  // Restart the current room
    }
}

// Handle round transition
if (round_transition) {
    transition_timer--;
    timer_active = false;  // Pause the timer during transition
    
    if (transition_timer <= 0) {
        round_transition = false;
        timer_active = true;
        load_next_word();
    }
    return;
}

// Regular timer update when not in transition
if (timer_active && !game_over) {
    // ...existing timer code...
}