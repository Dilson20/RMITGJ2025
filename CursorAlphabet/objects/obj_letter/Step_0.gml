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

// Level 2 falling behavior
if (instance_exists(obj_hangman_manager) && obj_hangman_manager.current_level == 2) {
    alpha = 1;  // Always visible in Level 2
    
    // Handle fall delay
    if (fall_delay > 0) {
        fall_delay--;
        if (fall_delay <= 0) {
            falling = true;
        }
    }
    
    // Only fall if delay is done
    if (falling) {
        y += fall_speed;
        
        // When bubble goes off screen
        if (y > room_height + sprite_height) {
            // Try to spawn new bubble at top with spacing
            var new_x = random_range(80, room_width - 80);
            var new_y = -sprite_height;
            var found_space = false;
            var tries = 0;
            
            while (!found_space && tries < 50) {
                found_space = true;
                new_x = random_range(80, room_width - 80);
                
                // Check distance from other top bubbles
                with (obj_letter) {
                    if (y < 0) {  // Only check bubbles above screen
                        if (point_distance(x, y, new_x, new_y) < 60) {
                            found_space = false;
                            break;
                        }
                    }
                }
                tries++;
            }
            
            // Create new bubble at found position
            if (instance_number(obj_letter) <= 25) {
                var new_bubble = instance_create_layer(new_x, new_y, "Instances", obj_letter);
                with (new_bubble) {
                    fall_speed = 2;
                    image_blend = c_white;
                    falling = true;  // Start falling immediately
                    fall_delay = 0;  // No delay for new bubbles
                    
                    // 30% chance for numbers
                    is_number = (random(1) < 0.3);
                    
                    if (is_number) {
                        letter = string(irandom_range(0, 9));
                    } else {
                        // 45% chance for letter from current word
                        if (instance_exists(hm) && random(1) < 0.45) {
                            var pos = irandom_range(1, string_length(hm.word));
                            letter = string_char_at(hm.word, pos);
                        } else {
                            letter = chr(ord("A") + irandom_range(0, 25));
                        }
                    }
                }
            }
            
            // Destroy self after creating new bubble
            instance_destroy();
        
        // When bubble goes off screen
            if (y > room_height + sprite_height) {
                // Only create new bubble if we're under 25
                if (instance_number(obj_letter) < 25) {
                    // Try to find a safe spawn position
                    var safe_position = false;
                    var new_x = 0;
                    var new_y = -sprite_height;
                    var attempts = 0;
                    
                    while (!safe_position && attempts < 100) {
                        new_x = random_range(80, room_width - 80);
                        safe_position = true;
                        
                        // Check distance from other bubbles
                        with (obj_letter) {
                            if (y < 0) {  // Only check bubbles above screen
                                var dist = point_distance(x, y, new_x, new_y);
                                if (dist < 60) {  // Minimum spacing
                                    safe_position = false;
                                    break;
                                }
                            }
                        }
                        attempts++;
                    }
            
            // Create new bubble
                    // Store current word for new bubble
                    var current_word = "";
                    if (instance_exists(hm)) {
                        current_word = hm.word;
                    }
                    
                    var new_bubble = instance_create_layer(new_x, new_y, "Instances", obj_letter);
                    with (new_bubble) {
                        fall_speed = 2;
                        image_blend = c_white;
                        falling = true;
                        fall_delay = 0;
                        
                        // First, decide if it's a number (30% chance)
                        is_number = (random(1) < 0.3);
                        
                        if (is_number) {
                            letter = string(irandom_range(0, 9));
                        } else {
                            // For letters, 45% chance to spawn a letter from the current word
                            if (random(1) < 0.45 && string_length(current_word) > 0) {
                                // Pick a random position in the word
                                var pos = irandom_range(1, string_length(current_word));
                                letter = string_char_at(current_word, pos);
                            } else {
                                letter = chr(ord("A") + irandom_range(0, 25));
                            }
                    }
                }
            
            // Destroy self
            instance_destroy();
        }
    }
}
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
            var new_reveal = "";  // Initialize new_reveal here

            var isCorrect = false;

            // --- Check with Hangman Manager ---
            if (instance_exists(hm)) {
                // In level 2, clicking a number is always wrong
                if (hm.current_level == 2 && is_number) {
                    isCorrect = false;
                } else {
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

                // Only update revealed if we built a new string
                if (string_length(new_reveal) > 0) {
                    hm.revealed = new_reveal;
                }

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