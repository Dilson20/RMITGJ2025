function load_next_word() {
    // Initialize word_list if not already done
    if (!variable_instance_exists(id, "word_list") || word_list == undefined) {
        word_list = word_list_1;  // Default to level 1
    }
    
    // Initialize revealed if not already done
    if (!variable_instance_exists(id, "revealed") || revealed == undefined) {
        revealed = "";
    }
    
    if (string_pos("_", revealed) == 0) {  // Word completed
        with (obj_letter) instance_destroy();  // Clear letters
        
        // Start transition
        round_transition = true;
        transition_timer = TRANSITION_DURATION;

        // Check if all words (5 rounds) in current level are completed
        if (word_index >= 5) { // Fixed 5 rounds per level
            // Save time left for completed level
            var seconds_left = ceil(timer / room_speed);
            
            switch (current_level) {
                case 1:
                    global.level1_time_left = seconds_left;
                    show_debug_message("✅ Level 1 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    break;
                case 2:
                    global.level2_time_left = seconds_left;
                    show_debug_message("✅ Level 2 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    break;
                case 3:
                    global.level3_time_left = seconds_left;
                    show_debug_message("✅ Level 3 Complete! Time left: " + string(seconds_left) + "s (Score: " + string(seconds_left * 100) + ")");
                    
                    // Calculate final score
                    global.total_score = (global.level1_time_left * 100) + 
                                       (global.level2_time_left * 100) + 
                                       (global.level3_time_left * 100);
                    
                    // Save score to file
                    save_score_to_ini(global.player_name, global.total_score);
                    
                    // All levels completed - YOU WIN!
                    game_over = true;
                    show_winning_screen = true;
                    chaos_mode = false;  // Turn off chaos mode
                    show_debug_message("🎉 ALL LEVELS COMPLETED! Final Score: " + string(global.total_score));
                    return;
            }
            
            // Move to next level
            current_level++;
            word_index = 0;
            chaos_mode = false;  // Reset chaos mode for new level

            // Select appropriate word list for the new level
            switch (current_level) {
                case 1:
                    word_list = word_list_1;
                    timer = time_limit_level_1; // 120 seconds for Level 1
                    static_bubbles = true; // Static bubbles for Level 1
                    
                    // Change music to background
                    if (!audio_is_playing(snd_background)) {
                        audio_stop_all();
                        audio_play_sound(snd_background, 1000, true);
                    }
                    
                    show_debug_message("📚 Starting Level 1 - 120 seconds!");
                    break;
                    
                case 2:
                    word_list = word_list_2;
                    timer = time_limit_level_2; // 240 seconds for Level 2
                    static_bubbles = true; // Static bubbles for Level 2
                    
                    // Keep background music playing
                    if (!audio_is_playing(snd_background)) {
                        audio_stop_all();
                        audio_play_sound(snd_background, 1000, true);
                    }
                    
                    show_debug_message("📚 Starting Level 2 - 240 seconds!");
                    break;
                    
                case 3:
                    word_list = word_list_3;
                    timer = time_limit_level_3; // 240 seconds for Level 3
                    static_bubbles = false; // Animated bubbles for Level 3
                    
                    // Change music to chaos for level 3
                    audio_stop_all();
                    audio_play_sound(snd_chaos, 1000, true);
                    
                    show_debug_message("📚 Starting Level 3 - 240 seconds! 🔥");
                    break;
                    
                default:
                    // No more levels - game complete!
                    game_over = true;
                    chaos_mode = false;
                    show_debug_message("🎉 All levels completed! You win!");
                    return;
            }
        }
    
        // Check if we've run out of words
        if (word_index >= array_length(word_list)) {
            game_over = true;
            chaos_mode = false;
            show_debug_message("🎉 Level " + string(current_level) + " completed! Game Over!");
            return;
        }

        // Clear all existing letters
        with (obj_letter) {
            instance_destroy();
        }

        // === CHAOS MODE LOGIC ===
        // Determine if this word should use chaos spelling
        var use_chaos = false;
        var current_word_name = "";
        
        // Clear previous hints
        ds_map_clear(chaos_letter_hints);
        
        // Check which words should be chaos based on level
        switch (current_level) {
            case 1:
                // Level 1: Only word 5 (ORANGE becomes AVOKADOXX)
                if (word_index == 4) {  // Index 4 is the 5th word
                    use_chaos = true;
                    current_word_name = "AVOCADO";
                    normal_word = "AVOCADO";
                    
                    // Mapping: C→K, add O→missing in normal, add X→missing in normal
                    ds_map_add(chaos_letter_hints, "C", "K");  // C in AVOCADO → K in AVOKADO
                }
                break;
                
            case 2:
                // Level 2: LYCHEE (word 3) and STRAWBERRY (word 5)
                if (word_index == 2) {
                    use_chaos = true;
                    current_word_name = "LYCHEE";
                    normal_word = "LYCHEE";
                    
                    // LYCHEE → LYCHIEEQQ
                    // Y disappears, I appears, EQQ added
                    ds_map_add(chaos_letter_hints, "Y", "I");  // Y → I
                }
                if (word_index == 4) {
                    use_chaos = true;
                    current_word_name = "STRAWBERRY";
                    normal_word = "STRAWBERRY";
                    
                    // STRAWBERRY → STRAWBERRYPP
                    // One R disappears, PP added
                    // (Actually it just adds PP, all letters stay)
                }
                break;
                
            case 3:
                // Level 3: All words except PINEAPPLE (word 2)
                if (word_index != 1) {  // PINEAPPLE is at index 1
                    use_chaos = true;
                    
                    switch (word_index) {
                        case 0: // POMEGRANATE → POMEGRANATEZZ
                            current_word_name = "POMEGRANATE";
                            normal_word = "POMEGRANATE";
                            // Just adds ZZ
                            break;
                            
                        case 2: // PAPAYA → PAPAIAXX
                            current_word_name = "PAPAYA";
                            normal_word = "PAPAYA";
                            ds_map_add(chaos_letter_hints, "Y", "I");  // Y → I
                            break;
                            
                        case 3: // TANGERINE → TANJERINEQQ
                            current_word_name = "TANGERINE";
                            normal_word = "TANGERINE";
                            ds_map_add(chaos_letter_hints, "G", "J");  // G → J
                            break;
                            
                        case 4: // STARFRUIT → STARFROOTT
                            current_word_name = "STARFRUIT";
                            normal_word = "STARFRUIT";
                            ds_map_add(chaos_letter_hints, "U", "O");  // U → O (second one)
                            break;
                    }
                }
                break;
        }
        
        // Set chaos mode flag
        chaos_mode = use_chaos;
        
        // Select word from appropriate list
        if (use_chaos) {
            // Use chaos word list
            switch (current_level) {
                case 1:
                    word = string_upper(chaos_word_list_1[word_index]);
                    break;
                case 2:
                    word = string_upper(chaos_word_list_2[word_index]);
                    break;
                case 3:
                    word = string_upper(chaos_word_list_3[word_index]);
                    break;
            }
            show_debug_message("⚡ CHAOS ROUND! Chaos spelling: " + word + " (Normal: " + current_word_name + ")");
        } else {
            // Use normal word
            word = string_upper(word_list[word_index]);
            normal_word = "";  // Clear normal word when not in chaos
        }
        
        revealed = string_repeat("_", string_length(word));

        show_debug_message("🔤 New word: " + word + " (Level " + string(current_level) + ", Word " + string(word_index + 1) + ")" + (chaos_mode ? " [CHAOS]" : ""));

        // Reset the global spawn timer so new letters start appearing immediately
        if (variable_global_exists("spawn_timer")) {
            global.spawn_timer = 0;
        }

        word_index++;
    }
}