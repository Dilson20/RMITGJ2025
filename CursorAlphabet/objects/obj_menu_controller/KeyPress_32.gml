/// @description Space key press - Start game
show_debug_message("SPACE KEY PRESSED");

// Find currently hovered button or use button[0] (PLAY) by default
var selected = 0;  // Default to first button (PLAY)

for (var i = 0; i < array_length(buttons); i++) {
    if (buttons[i].hover) {
        selected = i;
        break;
    }
}

// Get the selected button
var btn = buttons[selected];
show_debug_message("Selected button: " + btn.text);

// Play sound effect if it exists
if (audio_exists(snd_click)) {
    audio_play_sound(snd_click, 1, false);
}

// Go to target room
if (btn.target_room != noone) {
    show_debug_message("Attempting room transition from " + room_get_name(room) + " to Room2");
    room_goto(Room2);  // Directly go to Room2 for PLAY button
    show_debug_message("Room transition executed");
}