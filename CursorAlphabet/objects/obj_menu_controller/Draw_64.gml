// === TUTORIAL PROMPT ===
// Draw tutorial instruction at the bottom
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

var prompt_x = display_get_gui_width() / 2;
var prompt_y = display_get_gui_height() - 20;

// Draw background for visibility
//draw_set_alpha(0.5);
//draw_set_color(c_black);
//draw_rectangle(prompt_x - 120, prompt_y - 25, prompt_x + 120, prompt_y + 5, false);

// Draw the prompt text
//draw_set_alpha(1);
//draw_set_color(c_yellow);
//draw_text(prompt_x, prompt_y, "Press V for Tutorial");

// Reset draw settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);