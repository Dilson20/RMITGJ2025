// Safe zone to avoid hangman word area
var top_safe_zone = 120; // default fallback
if (instance_exists(obj_hangman_manager)) {
    var hm = instance_find(obj_hangman_manager, 0);
    top_safe_zone = hm.TOP_MARGIN + 70; // Add padding for the word display
}

// Get hangman manager for level check
var hm = instance_find(obj_hangman_manager, 0);

if (instance_exists(hm) && hm.static_bubbles) {
    // For Levels 1 and 2: Static bubbles that stay in place
    if (state == "appearing") {
        alpha = 1;
        state = "waiting";
    }
} else {
    // For Level 3: Original animated behavior
    switch (state) {
        case "appearing":
            alpha += fade_speed;
            if (alpha >= 1) {
                alpha = 1;
                state = "waiting";
            }
            break;

        case "waiting":
            stay_timer--;
            if (stay_timer <= 0) {
                state = "disappearing";
            }
            break;

        case "disappearing":
            alpha -= fade_speed;
            if (alpha <= 0) {
                var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                letter = string_char_at(letters, irandom_range(1, string_length(letters)));

                // Find non-overlapping position
            var safe = false;
            repeat(100) {
                safe = true;
                x = irandom_range(50, room_width - 50);
                y = irandom_range(top_safe_zone, room_height - 50); // Spawn below hangman word
                with (obj_letter) {
                    if (id != other.id) {
                        var dx = other.x - x;
                        var dy = other.y - y;
                        var dist = sqrt(dx * dx + dy * dy);
                        if (dist < (radius + other.radius + 10)) {
                            safe = false;
                        }
                    }
                }
                if (safe) break;
            }

            // Random color again
            col = make_color_rgb(irandom(255), irandom(255), irandom(255));

            if (instance_exists(hm) && hm.static_bubbles) {
                alpha = 1;
                state = "waiting";
            } else {
                alpha = 0;
                state = "appearing";
                stay_timer = irandom_range(60, 180);
            }
        }
        break;
    }
}

// === Detect cursor touch ===
if (instance_exists(obj_cursor)) {
    var dx = obj_cursor.x - x;
    var dy = obj_cursor.y - y;

    // Check if cursor is inside the circle
    if (sqrt(dx * dx + dy * dy) <= radius) {

        // Get hangman manager
        var hm = instance_find(obj_hangman_manager, 0);
        
        // Check if player is frozen - if so, cannot interact
        if (instance_exists(hm) && hm.is_frozen) {
            exit; // Cannot click letters while frozen
        }

        // Prevent multiple hits or repeated interactions
        if (state != "disappearing") {

            var isCorrect = false;

            // --- Check with Hangman Manager ---
            if (instance_exists(hm)) {
                // In level 2, clicking a number is always wrong
                if (hm.current_level == 2 && is_number) {
                    isCorrect = false;
                } else {
                    var new_reveal = "";

                    for (var i = 1; i <= string_length(hm.word); i++) {
                        var c = string_char_at(hm.word, i);
                        var r = string_char_at(hm.revealed, i);

                        if (c == letter) {
                            new_reveal += c;
                            isCorrect = true;
                        } else {
                            new_reveal += r;
                        }
                    }
                }

                hm.revealed = new_reveal;

                if (isCorrect) {
                    show_debug_message("✅ Correct letter: " + letter);
                    // Play correct sound
                    audio_play_sound(snd_slash, 1, false);
                    // Reset wrong guesses counter on correct
                    hm.wrong_guesses_in_row = 0;
                } else {
                    show_debug_message("❌ Wrong letter: " + letter);
                    
                    // Increment wrong guesses counter
                    hm.wrong_guesses_in_row++;
                    
                    // Check for consecutive wrong guesses
                    if (hm.wrong_guesses_in_row >= 2) {
                        // FREEZE THE PLAYER for 2 seconds
                        hm.is_frozen = true;
                        hm.freeze_timer = 2 * room_speed; // 2 seconds
                        hm.wrong_guesses_in_row = 0; // Reset counter
                        
                        // Play stop sound for penalty
                        audio_play_sound(snd_stop, 1, false);
                        
                        show_debug_message("❄️ Player frozen for 2 seconds due to consecutive wrong guesses!");
                    }
                    
                    // Play wrong sound
                    audio_play_sound(snd_wrong, 1, false);
                }
            }

            // --- Create pop effect ---
            if (object_exists(obj_pop_effect)) {
                var fx = instance_create_layer(x, y, "Instances", obj_pop_effect);
                fx.col = col;
            }

            show_debug_message("💥 Destroyed letter: " + letter);

            // --- Remove the letter ---
            instance_destroy();
        }
    }
}