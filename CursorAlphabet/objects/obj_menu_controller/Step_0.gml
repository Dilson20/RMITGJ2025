/// Menu Controller Step Event

// === CHECK FOR TUTORIAL KEY (V) ===
if (keyboard_check_pressed(ord("V"))) {
    show_debug_message("V pressed - Going to tutorial");
    
    // Play click sound if it exists
    if (audio_exists(snd_click)) {
        audio_play_sound(snd_click, 1, false);
    }
    
    // Go to tutorial room
    if (room_exists(Room_Tutorial)) {
        room_goto(Room_Tutorial);
    } else {
        show_debug_message("ERROR: Room_Tutorial does not exist! Please create it.");
    }
}

// === KEYBOARD CONTROLS FOR MENU BUTTONS ===
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
    show_debug_message("Space/Enter pressed - Starting game");
    
    // Find the currently hovered/selected button
    for (var i = 0; i < array_length(buttons); i++) {
        var btn = buttons[i];
        if (btn.hover || i == selected_button) {
            show_debug_message("Selected button: " + btn.text);
            
            // Play sound if exists
            if (audio_exists(snd_click)) {
                audio_play_sound(snd_click, 1, false);
            }
            
            // Go to target room
            if (btn.target_room != noone && room_exists(btn.target_room)) {
                show_debug_message("Going to room: " + string(btn.target_room));
                room_goto(btn.target_room);
            }
            break;
        }
    }
}