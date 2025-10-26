/// @description Handle mouse clicks
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
show_debug_message("Mouse_53: Click at GUI coords: " + string(mx) + "," + string(my));

for (var i = 0; i < array_length(buttons); i++) {
    var btn = buttons[i];
    var half_width = btn.width/2;
    var half_height = btn.height/2;
    
    if (point_in_rectangle(mx, my, 
                          btn.x - half_width, 
                          btn.y - half_height, 
                          btn.x + half_width, 
                          btn.y + half_height)) {
        show_debug_message("Mouse_53: Button " + string(i) + " clicked!");
        
        // Play click sound if it exists
        if (audio_exists(snd_click)) {
            audio_play_sound(snd_click, 1, false);
        }
        
        // Handle room transitions
        if (btn.target_room != noone && room_exists(btn.target_room)) {
            show_debug_message("Mouse_53: Going to room: " + string(btn.target_room));
            room_goto(btn.target_room);
        }
        break;
    }
}