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
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
    draw_text(room_width / 2, room_height / 2, "GAME OVER!");
}

// Reset drawing settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);