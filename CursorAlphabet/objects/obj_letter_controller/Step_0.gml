// === SETTINGS ===
var safe_distance = 10;      // padding between circles
var attempts_limit = 100;    // safety limit for position attempts
var spawn_delay = room_speed * 0.5; // 0.5 second delay between spawns
var top_safe_zone = 120; // default fallback
if (instance_exists(obj_hangman_manager)) {
    var hm = instance_find(obj_hangman_manager, 0);
    top_safe_zone = hm.TOP_MARGIN + 70; // Add padding for the word display
}
// Get hangman manager reference
var hm = instance_find(obj_hangman_manager, 0);

// Set max letters based on level
var max_letters = 20; // default
if (instance_exists(hm)) {
    if (hm.current_level == 1) max_letters = 25;
    else if (hm.current_level == 2) max_letters = 40;
    else max_letters = 20;
}

// === GLOBAL TIMER ===
if (!variable_global_exists("spawn_timer")) {
    global.spawn_timer = spawn_delay; // Initialize spawn timer
}

// Get hangman manager reference
var hm = instance_find(obj_hangman_manager, 0);

// Countdown
if (global.spawn_timer > 0) {
    global.spawn_timer--;
    exit; // wait until timer reaches 0
}

// === SPAWN LOGIC ===
var hm = instance_find(obj_hangman_manager, 0);
var current_letters = instance_number(obj_letter);

// For Levels 1 and 2: Spawn all letters at once if none exist
if (instance_exists(hm) && hm.static_bubbles && current_letters == 0) {
    var word = string_upper(hm.word);
    var letters_needed = [];
    var numbers = "0123456789";
    
    // First add all required letters from the word
    for (var i = 1; i <= string_length(word); i++) {
        var c = string_char_at(word, i);
        // Only add if not already in array
        var found = false;
        for (var j = 0; j < array_length(letters_needed); j++) {
            if (letters_needed[j] == c) {
                found = true;
                break;
            }
        }
        if (!found) array_push(letters_needed, c);
    }
    
    // Create all bubbles
    for (var i = 0; i < max_letters; i++) {
        var new_letter = instance_create_layer(0, 0, "Instances", obj_letter);
        new_letter.alpha = 1;  // Make immediately visible
        new_letter.state = "waiting";
        
        // If we still have required letters, use them
        if (i < array_length(letters_needed)) {
            new_letter.letter = letters_needed[i];
        } else {
            // For level 2, add numbers and letters
            if (hm.current_level == 2) {
                // 50% chance for number vs letter
                if (random(1) < 0.5) {
                    new_letter.letter = string_char_at(numbers, irandom_range(1, string_length(numbers)));
                } else {
                    var all_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    new_letter.letter = string_char_at(all_letters, irandom_range(1, string_length(all_letters)));
                }
            } else {
                // Level 1: Just add random letters
                var all_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                new_letter.letter = string_char_at(all_letters, irandom_range(1, string_length(all_letters)));
            }
        }
    }
} 
// For Level 3: Original gradual spawn behavior
else if (!instance_exists(hm) || !hm.static_bubbles) {
    if (current_letters < max_letters) {
        // Create a new letter
        var new_letter = instance_create_layer(0, 0, "Instances", obj_letter);

        // Initialize fade-in settings
        new_letter.alpha = 0;
        new_letter.state = "appearing";
        new_letter.fade_speed = 0.02;
        new_letter.stay_timer = irandom_range(60, 180);

    // === Get Hangman word info ===
    var hm = instance_find(obj_hangman_manager, 0);
    var all_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var chosen_letter;

    if (instance_exists(hm)) {
        var word = string_upper(hm.word);
        var revealed = hm.revealed;

        // Gather missing letters
        var missing_letters = "";
        for (var i = 1; i <= string_length(word); i++) {
            var w = string_char_at(word, i);
            var r = string_char_at(revealed, i);
            if (r == "_") {
                if (string_pos(w, missing_letters) == 0) {
                    missing_letters += w;
                }
            }
        }

        // Calculate bias based on missing count
        var missing_count = string_length(missing_letters);
        var total_count = string_length(word);
        var missing_ratio = missing_count / total_count;

        // Dynamic bias
        var chance_missing;
        if (missing_count == 0) {
            chance_missing = 0; // solved
        } else {
            // When fewer missing letters, increase bias
            chance_missing = clamp(100 - (missing_ratio * 70), 30, 95);
        }

        // Decide which letter type to spawn
        var roll = irandom_range(1, 100);

        if (roll <= chance_missing && missing_count > 0) {
            // Prioritize missing letters
            chosen_letter = string_char_at(missing_letters, irandom_range(1, missing_count));
        } else if (roll <= 80) {
            // Sometimes still show letters from the word
            chosen_letter = string_char_at(word, irandom_range(1, string_length(word)));
        } else {
            // Random filler
            chosen_letter = string_char_at(all_letters, irandom_range(1, string_length(all_letters)));
        }

    } else {
        // No manager found — fallback random letter
        chosen_letter = string_char_at(all_letters, irandom_range(1, string_length(all_letters)));
    }

    new_letter.letter = chosen_letter;

    // === Find non-overlapping position ===
    var safe = false;
    repeat (attempts_limit) {
        safe = true;
        new_letter.x = irandom_range(50, room_width - 50);
        new_letter.y = irandom_range(top_safe_zone, room_height - 50);

        with (obj_letter) {
            if (id != new_letter.id) {
                var dx = x - new_letter.x;
                var dy = y - new_letter.y;
                var dist = sqrt(dx*dx + dy*dy);
                if (dist < (radius + new_letter.radius + safe_distance)) {
                    safe = false;
                }
            }
        }

        if (safe) break;
    }

        // Reset global spawn timer
        global.spawn_timer = spawn_delay;
    }
}