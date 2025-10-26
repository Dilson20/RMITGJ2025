/// Tutorial Screen Draw GUI

// Draw instruction text at the bottom
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

// Calculate positions
var text_x = display_get_gui_width() / 2;
var text_y = display_get_gui_height() - 30;

// Draw semi-transparent background rectangle for readability
//draw_set_alpha(0.7);
//draw_set_color(c_black);
//draw_rectangle(text_x - 200, text_y - 40, text_x + 200, text_y + 5, false);

// Draw the main instruction text
//draw_set_alpha(1);
//draw_set_color(c_white);
//draw_text(text_x, text_y, "Press V to return to menu");

// Optional: Add a title at the top
draw_set_valign(fa_top);
draw_set_color(c_yellow);
var title_y = 50;

// Draw title background
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(text_x - 150, title_y - 20, text_x + 150, title_y + 20, false);

// Draw title text
draw_set_alpha(1);
draw_set_color(c_yellow);
draw_text(text_x, title_y, "TUTORIAL");

// Reset draw settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);