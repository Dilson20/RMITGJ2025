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
    if (!audio_is_playing(snd_slash)) audio_play_sound(snd_slash, 1, false);
    ctrl.score += 10;
    ctrl.remaining--;

    instance_destroy(argument0);
}
/// 4 Wrong letter
else {
    if (!audio_is_playing(snd_wrong)) audio_play_sound(snd_wrong, 1, false);
    ctrl.score = max(0, ctrl.score - 5);
    ctrl.timer -= ctrl.time_penalty;

    instance_destroy(argument0);
}
