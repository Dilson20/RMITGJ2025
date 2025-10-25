// === DRAW HANGMAN WORD ===
var display = "";
for (var i = 1; i <= string_length(word); i++) {
    display += string_char_at(revealed, i) + " ";
}

draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// Draw the word at the top
draw_text(room_width / 2, 50, display);

// === DRAW LEVEL INDICATOR ===
draw_set_halign(fa_left);
draw_text(20, 20, "Level: " + string(current_level));

// === DRAW FREEZE WARNING ===
if (is_frozen) {
    var freeze_seconds = ceil(freeze_timer / room_speed);
    draw_set_color(c_red);
    draw_text(20, 40, "FROZEN: " + string(freeze_seconds) + "s");
}

// === DRAW TIMER ===
if (timer_active) {
    var seconds_left = ceil(timer / room_speed);
    var minutes = floor(seconds_left / 60);
    var seconds = seconds_left mod 60;
    
    // Format as MM:SS
    var time_string = string(minutes) + ":" + (seconds < 10 ? "0" : "") + string(seconds);
    
    draw_set_halign(fa_right);
    
    // Change color based on time remaining
    if (seconds_left <= 30) {
        draw_set_color(c_red);  // Red when less than 30 seconds
    } else if (seconds_left <= 60) {
        draw_set_color(c_yellow);  // Yellow when less than 1 minute
    } else {
        draw_set_color(c_white);
    }
    
    draw_text(room_width - 20, 20, "Time: " + time_string);
}

// === GAME OVER MESSAGE ===
if (game_over) {
    if (show_losing_screen) {
        // Draw the losing screen sprite
        var screen_center_x = room_width / 2;
        var screen_center_y = room_height / 2;
        
        // Draw the losing screen sprite to fill the entire screen
        var sprite_w = sprite_get_width(losing_screen);
        var sprite_h = sprite_get_height(losing_screen);
        
        // Calculate scaling factors to fill the screen
        var scale_x = room_width / sprite_w;
        var scale_y = room_height / sprite_h;
        
        // Draw the sprite stretched to fill the screen
        draw_sprite_ext(losing_screen, 0, 
            0, 0,                    // Start from top-left corner
            scale_x, scale_y,        // Scale to fill screen
            0, c_white, 1);
            
        // Draw "Time Up!" text
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_red);
        draw_set_font(font_normal);  // Using the default font
        draw_text(screen_center_x, screen_center_y - 100, "TIME UP!");
        
        // Draw "Press SPACE to retry" text
        draw_set_color(c_white);
        draw_set_font(font_normal);  // Using the default font
        draw_text(screen_center_x, screen_center_y + 100, "Press SPACE to retry");
    } else {
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text(room_width / 2, room_height / 2, "GAME OVER!");
    }
}

// Reset drawing settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);