// Keyboard controls
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
        
        if (in_button) {
            show_debug_message("BUTTON " + string(i) + " (" + btn.text + ") CLICKED! Coordinates: " + 
                              string(btn.x - half_width) + "," + string(btn.y - half_height) + " to " + 
                              string(btn.x + half_width) + "," + string(btn.y + half_height));
            
            // Play click sound if it exists
            if (audio_exists(snd_click)) {
                audio_play_sound(snd_click, 1, false);
            }
            
            // Handle button clicks
            switch(i) {
                case 0: // Play button
                    show_debug_message("Starting game... Going to Room1");
                    if (room_exists(Room1)) {
                        room_goto(Room1);
                    } else {
                        show_debug_message("ERROR: Room1 does not exist!");
                    }
                    break;
                    
                case 1: // Rank button
                    show_debug_message("Opening rank screen...");
                    // Add your rank room logic here
                    break;
                    
                case 2: // Guide button
                    show_debug_message("Opening guide...");
                    // Add your guide room logic here
                    break;
            }
            break; // Exit after first button found
        }
    }
}