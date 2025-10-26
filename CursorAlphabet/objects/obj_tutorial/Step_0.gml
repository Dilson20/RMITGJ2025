/// Tutorial Screen Step Event

// Check for V key press to return to menu
if (keyboard_check_pressed(ord("V"))) {
    show_debug_message("V pressed - Returning to menu (Room1)");
    
    // Play click sound if it exists
    if (audio_exists(snd_click)) {
        audio_play_sound(snd_click, 1, false);
    }
    
    // Stop all audio and play menu music
    audio_stop_all();
    
    // Return to menu room (Room1)
    if (room_exists(Room1)) {
        room_goto(Room1);
    } else {
        show_debug_message("ERROR: Room1 does not exist!");
    }
}