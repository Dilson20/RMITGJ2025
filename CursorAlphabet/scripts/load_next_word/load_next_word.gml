function load_next_word() {
    if (word_index >= array_length(word_list)) {
        // No more words left
        game_over = true;
        show_debug_message("🎉 All words completed! Game Over!");
        return;
    }

    word = string_upper(word_list[word_index]);
    revealed = string_repeat("_", string_length(word));
    attempts_left = max_attempts;

    show_debug_message("🔤 New word: " + word);

    // Spawn letter objects for this round
    spawn_letters();

    word_index++;
}
