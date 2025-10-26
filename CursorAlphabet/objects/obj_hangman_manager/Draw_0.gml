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

// === DRAW CHAOS MODE INDICATOR ===
if (chaos_mode) {
    // Pulsing red background flash
    chaos_flash_timer += 0.05;
    chaos_flash_alpha = abs(sin(chaos_flash_timer)) * 0.3;
    
    draw_set_alpha(chaos_flash_alpha);
    draw_set_color(c_red);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Draw "CHAOS MODE!" text with pulsing effect
    var pulse_scale = 1 + (sin(chaos_flash_timer * 2) * 0.2);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(room_width / 2, 100, "⚡ CHAOS ROUND ⚡", pulse_scale, pulse_scale, 0);
    draw_set_color(c_yellow);
    draw_text(room_width / 2, 130, "WRONG SPELLINGS!");
}

// === DRAW HINT MESSAGE ===
if (show_hint && hint_timer > 0) {
    hint_timer--;
    
    // Fade in/out effect
    if (hint_timer > 120) {
        hint_alpha = min(hint_alpha + 0.05, 1);
    } else {
        hint_alpha = max(hint_alpha - 0.02, 0);
    }
    
    if (hint_alpha > 0) {
        draw_set_alpha(hint_alpha);
        
        // Draw hint box background
        var hint_box_width = 600;
        var hint_box_height = 120;
        var hint_x = room_width / 2;
        var hint_y = room_height / 2;
        
        draw_set_color(c_black);
        draw_rectangle(hint_x - hint_box_width/2, hint_y - hint_box_height/2,
                      hint_x + hint_box_width/2, hint_y + hint_box_height/2, false);
        
        // Draw hint box border
        draw_set_color(c_orange);
        draw_rectangle(hint_x - hint_box_width/2, hint_y - hint_box_height/2,
                      hint_x + hint_box_width/2, hint_y + hint_box_height/2, true);
        
        // Draw hint text
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_orange);
        draw_text(hint_x, hint_y - 20, "💡 HINT 💡");
        draw_set_color(c_white);
        draw_text(hint_x, hint_y + 10, hint_message);
        
        draw_set_alpha(1);
    }
    
    if (hint_timer <= 0) {
        show_hint = false;
    }
}

// === DRAW LEVEL INDICATOR ===
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(20, 20, "Level: " + string(current_level));

// === DRAW HIGH SCORE ===
var high_score = get_highest_score();
if (high_score > 0) {
    draw_text(20, 40, "Best: " + string(high_score));
}

// === DRAW CURRENT SCORE ===
var current_score = 0;
if (variable_global_exists("level1_time_left")) current_score += global.level1_time_left * 100;
if (variable_global_exists("level2_time_left")) current_score += global.level2_time_left * 100;
if (variable_global_exists("level3_time_left")) current_score += global.level3_time_left * 100;
draw_text(20, 60, "Score: " + string(current_score));

// === DRAW FREEZE WARNING ===
if (is_frozen) {
    var freeze_seconds = ceil(freeze_timer / room_speed);
    draw_set_color(c_red);
    draw_text(20, 100, "FROZEN: " + string(freeze_seconds) + "s");
    draw_set_color(c_white);
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
        draw_set_font(font_normal);
        draw_text(screen_center_x, screen_center_y - 150, "TIME UP!");
        
        // Draw final score
        draw_set_color(c_yellow);
        draw_set_font(font_normal);
        draw_text(screen_center_x, screen_center_y - 50, "Final Score: " + string(global.total_score));
        
        // Check if new high score
        if (global.total_score > high_score) {
            draw_set_color(c_lime);
            draw_text(screen_center_x, screen_center_y, "NEW HIGH SCORE!");
        }
        
        // Draw "Press SPACE to retry" text
        draw_set_color(c_white);
        draw_text(screen_center_x, screen_center_y + 100, "Press SPACE to retry");
    } else if (show_winning_screen) {
        // Draw winning screen
        var screen_center_x = room_width / 2;
        var screen_center_y = room_height / 2;
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_lime);
        draw_set_font(font_normal);
        draw_text(screen_center_x, screen_center_y - 150, "CONGRATULATIONS!");
        draw_text(screen_center_x, screen_center_y - 100, "YOU WON!");
        
        // Draw final score
        draw_set_color(c_yellow);
        draw_set_font(font_normal);
        draw_text(screen_center_x, screen_center_y - 30, "Final Score: " + string(global.total_score));
        
        // Check if new high score
        if (global.total_score > high_score) {
            draw_set_color(c_lime);
            draw_text(screen_center_x, screen_center_y + 20, "NEW HIGH SCORE!");
        }
        
        // Draw "Press SPACE to play again" text
        draw_set_color(c_white);
        draw_text(screen_center_x, screen_center_y + 100, "Press SPACE to play again");
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