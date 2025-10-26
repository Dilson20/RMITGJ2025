/// @description Enter key press - Same as Space
show_debug_message("ENTER KEY PRESSED");

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
if (btn.target_room != noone && room_exists(btn.target_room)) {
    if (btn.target_room != room) {  // Only change room if it's different
        show_debug_message("Going to room: " + room_get_name(btn.target_room));
        room_goto(btn.target_room);
    } else {
        show_debug_message("Already in target room: " + room_get_name(room));
    }
}