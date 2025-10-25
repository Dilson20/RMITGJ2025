// --- 1. Clear old letters safely ---
if (object_exists(obj_letter)) {
    with (obj_letter) instance_destroy();
}

// --- 2. Access game controller instance safely ---
var ctrl = obj_gamecontroller; // get the controller
if (!instance_exists(ctrl)) exit; // failsafe: no controller yet

// Clear used letters at start of new round
ds_list_clear(ctrl.used_letters);

// --- 3. Reset round data ---
ctrl.bonus_mode = false;
ctrl.timer = ctrl.round_time;
ctrl.remaining = 0;

// --- 4. Pick word for current level/round ---
var current_words = ctrl.word_list[ctrl.level - 1];
var word = current_words[ctrl.round_index - 1];

// --- 5. Choose a missing letter position ---
var missing_index = irandom_range(1, string_length(word));
ctrl.target_letter = string_char_at(word, missing_index);

// --- 6. Build display version (e.g. AP_LE) ---
ctrl.display_word = "";
for (var i = 1; i <= string_length(word); i++) {
    var c = string_char_at(word, i);
    if (i == missing_index)
        ctrl.display_word += "_";
    else
        ctrl.display_word += c;
}

// Debug info
show_debug_message("Word: " + word + 
                   " | Missing: " + ctrl.target_letter + 
                   " | Display: " + ctrl.display_word);

// --- 7. Spawn correct letter ---
scr_spawn_letter(ctrl.target_letter, true);

// --- 8. Spawn distractors ---
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var distractor_count = min(1 + ctrl.level, 3); // increases with level

repeat (distractor_count) {
    var wrong_letter = string_char_at(alphabet, irandom_range(1, 26));
    if (wrong_letter != ctrl.target_letter) {
        scr_spawn_letter(wrong_letter, false);
    }
}