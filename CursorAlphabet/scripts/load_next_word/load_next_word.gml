function load_next_word() {
    if (word_index >= array_length(word_list)) {
        // No more words left
        game_over = true;
        show_debug_message("🎉 All words completed! Game Over!");
        return;
    }

    // Clear all existing letters
    with (obj_letter) {
        instance_destroy();
    }

    word = string_upper(word_list[word_index]);
    revealed = string_repeat("_", string_length(word));
    attempts_left = max_attempts;

    show_debug_message("🔤 New word: " + word);

    // Reset the global spawn timer so new letters start appearing immediately
    if (variable_global_exists("spawn_timer")) {
        global.spawn_timer = 0;
    }

    // Don't call spawn_letters() - let obj_letter_controller handle spawning
    // spawn_letters();  // REMOVE THIS LINE

    word_index++;
}
