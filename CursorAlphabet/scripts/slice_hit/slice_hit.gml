/// scr_slice_hit(letter_instance_id)

/// 1 Failsafe: get controller instance
if (!variable_global_exists("ctrl") || !instance_exists(global.ctrl)) {
    show_debug_message("Warning: Controller not found!");
    exit;
}
var ctrl = global.ctrl;

/// 2 Check bonus mode first
if (ctrl.bonus_mode) {
    // Play slash sound, add bonus points
    if (!audio_is_playing(snd_slash)) audio_play_sound(snd_slash, 1, false);
    ctrl.score += 5;

    // Remove the sliced letter
    instance_destroy(argument0);
    exit;
}

/// 3 Correct letter
if (argument0.is_target) {
    // Add letter to used list if it's correct
    with (obj_hangman_manager) {
        ds_list_add(used_letters, argument0.letter);
    }
    
    if (!audio_is_playing(snd_slash)) audio_play_sound(snd_slash, 1, false);
    ctrl.score += 10;
    ctrl.remaining--;

    instance_destroy(argument0);
}
/// 4 Wrong letter
else {
    with (obj_hangman_manager) {
        // Increment wrong guesses
        wrong_guesses++;
        
        // Check if we should freeze the player
        if (wrong_guesses >= freeze_threshold) {
            is_frozen = true;
            freeze_timer = freeze_duration;
            wrong_guesses = 0;  // Reset counter after freezing
            show_debug_message("❄️ Player frozen for wrong guesses!");
        }
    }
    
    if (!audio_is_playing(snd_wrong)) audio_play_sound(snd_wrong, 1, false);
    ctrl.score = max(0, ctrl.score - 5);
    ctrl.timer -= ctrl.time_penalty;

    instance_destroy(argument0);
}
