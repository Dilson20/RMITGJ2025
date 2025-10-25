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
                y = irandom_range(50, room_height - 50);
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

            alpha = 0;
            state = "appearing";
            stay_timer = irandom_range(60, 180);
        }

        break;
}

// Detect if cursor touches this letter
// === Detect cursor touch ===
if (instance_exists(obj_cursor)) {
    var dx = obj_cursor.x - x;
    var dy = obj_cursor.y - y;

    // Check if cursor is inside the circle
    if (sqrt(dx * dx + dy * dy) <= radius) {

        // Prevent multiple hits or repeated interactions
        if (state != "disappearing") {

            var isCorrect = false;

            // --- Check with Hangman Manager ---
            var hm = instance_find(obj_hangman_manager, 0);
            if (instance_exists(hm)) {
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

                hm.revealed = new_reveal;

                if (isCorrect) {
                    show_debug_message("✅ Correct letter: " + letter);
                } else {
                    show_debug_message("❌ Wrong letter: " + letter);
                    hm.attempts_left -= 1; // FIXED: Decrement attempts for wrong guess
                }
            }

            // --- Create pop effect ---
            if (object_exists(obj_pop_effect)) {
                var fx = instance_create_layer(x, y, "Instances", obj_pop_effect);
                fx.col = col;
            }

            show_debug_message("💥 Destroyed letter: " + letter);

            // --- Remove the letter ---
            // Option 1: fade out smoothly
            // state = "disappearing";

            // Option 2: instant destruction (use this if you have obj_pop_effect)
            instance_destroy();
        }
    }
}
