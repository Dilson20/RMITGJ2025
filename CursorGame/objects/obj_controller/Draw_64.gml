// HUD (always visible while playing)
draw_set_font(-1);
draw_set_color(c_white);
draw_text(20, 20, "Score: " + string(score));
draw_text(20, 40, "Wave: " + string(wave_number));

// Fade overlay and Game Over UI
if (game_over) {
    var mid_x = display_get_gui_width() / 2;
    var mid_y = display_get_gui_height() / 2;

    // Fade to black overlay
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Once fully faded, show Game Over text
    if (fade_alpha >= 1) {
        draw_set_color(c_red);
        draw_text(mid_x - 80, mid_y - 40, "GAME OVER");
        draw_set_color(c_white);
        draw_text(mid_x - 100, mid_y, "Final Score: " + string(score));
        draw_text(mid_x - 120, mid_y + 40, "Press R to Restart");
    }
}
