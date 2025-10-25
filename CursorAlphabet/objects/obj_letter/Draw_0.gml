// Apply alpha fade
draw_set_alpha(alpha);

// Draw bubble sprite
var scale = 60 / 120;
draw_sprite_ext(bubble, 0, x, y, scale, scale, 0, col, alpha);

// Get hangman manager for level check
var hm = instance_find(obj_hangman_manager, 0);

// Set text color based on bubble type
if (instance_exists(hm) && hm.current_level == 2 && is_number) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}

// Use the font assigned in Create event with scaling
var font_scale = 1.5; // Adjust this value to change font size
draw_set_font(letter_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Calculate sprite center
var scaled_width = 120 * scale;
var scaled_height = 120 * scale;
var sprite_center_x = x + (scaled_width / 2);
var sprite_center_y = y + (scaled_height / 2);

// Draw scaled text
draw_text_transformed(sprite_center_x, sprite_center_y, letter, font_scale, font_scale, 0);

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);