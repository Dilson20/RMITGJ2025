function spawn_letters() {
    // Clear old letters
    with (obj_letter) instance_destroy();

    if (instance_exists(obj_hangman_manager) && obj_hangman_manager.current_level == 2) {
        var hm = instance_find(obj_hangman_manager, 0);
        
        // Initial grid setup for 25 bubbles (5x5)
        var grid_cols = 5;
        var grid_rows = 5;
        var spacing = 80;  // Spacing between bubbles
        var startX = (room_width - (grid_cols - 1) * spacing) / 2;
        var startY = 100;  // Start visible on screen
        
        // Spawn exactly 25 bubbles in a grid
        for (var i = 0; i < grid_rows; i++) {
            for (var j = 0; j < grid_cols; j++) {
                var xx = startX + j * spacing;
                var yy = startY + i * spacing;
                
                var inst = instance_create_layer(xx, yy, "Instances", obj_letter);
                with (inst) {
                    fall_speed = 2;
                    image_blend = c_white;
                    falling = false;
                    // Stagger the fall delays - each row starts 1 second after the previous
                    fall_delay = i * room_speed + (j * room_speed / grid_cols);
                    is_number = (random(1) < 0.3);  // 30% chance for numbers
                    
                    if (is_number) {
                        letter = string(irandom_range(0, 9));
                    } else {
                        // Get current word from hangman manager
                        var current_word = "";
                        if (instance_exists(other.hm)) {
                            current_word = other.hm.word;
                        }
                        
                        // 45% chance to pick from current word if available
                        if (random(1) < 0.45 && string_length(current_word) > 0) {
                            var pos = irandom_range(1, string_length(current_word));
                            letter = string_char_at(current_word, pos);
                        } else {
                            letter = chr(ord("A") + irandom_range(0, 25));
                        }
                    }
                }
            }
        }
        return;
    }

    // Skip if letter already used
    var target_letter = global.ctrl.target_letter;
    if (ds_list_find_index(global.ctrl.used_letters, target_letter) != -1) {
        return;
    }

    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var startX = 100;
    var startY = 400;
    var spacing = 40;

    for (var i = 1; i <= string_length(alphabet); i++) {
        var ch = string_char_at(alphabet, i);
        var xx = startX + ((i - 1) mod 13) * spacing;
        var yy = startY + floor((i - 1) / 13) * spacing;

        var inst = instance_create_layer(xx, yy, "Instances", obj_letter);
        inst.letter = ch;
        inst.col = make_color_hsv(irandom(255), 200, 255);
    }
    
    // Add letter to used list after spawning
    ds_list_add(global.ctrl.used_letters, target_letter);
}

if (instance_exists(obj_hangman_manager) && obj_hangman_manager.current_level == 2) {
    // Spawn initial 25 bubbles for Level 2
    for (var i = 0; i < 25; i++) {
        var xx = random_range(100, room_width - 100);
        var yy = random_range(-room_height, 0);  // Start above screen
        
        var inst = instance_create_layer(xx, yy, "Instances", obj_letter);
        with (inst) {
            fall_speed = 2;
            image_blend = c_white;
            
            if (random(1) < 0.3) {
                letter = string(irandom_range(0, 9));
                is_number = true;
            } else {
                letter = chr(ord("A") + irandom_range(0, 25));
            }
        }
    }
    return;  // Skip regular letter spawning
}