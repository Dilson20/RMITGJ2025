// LEFT PRESSED MOUSE EVENT
for (var i = 0; i < array_length(buttons); i++) {
    var btn = buttons[i];
    
    // Check if mouse is within button bounds
    if (mouse_x >= btn.x && mouse_x <= btn.x + btn.width &&
        mouse_y >= btn.y && mouse_y <= btn.y + btn.height) {
        
        // Handle button click
        switch (i) {
            case 0: // Play button
                room_goto(btn.target_room);
                break;
            case 1: // Rank button
                show_debug_message("Rank button pressed");
                // room_goto(btn.target_room);
                break;
            case 2: // Guide button
                show_debug_message("Guide button pressed");
                // room_goto(btn.target_room);
                break;
        }
        break; // Exit loop after finding clicked button
    }
}