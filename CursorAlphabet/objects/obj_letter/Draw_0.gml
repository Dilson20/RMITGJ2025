/// obj_letter Draw Event
// Apply alpha fade
draw_set_alpha(alpha);

// Configuration
var BUBBLE_SIZE = 60;  // Change this to adjust bubble size

// Calculate scale for ghost sprite
var original_width = sprite_get_width(spr_ghost);
var scale = BUBBLE_SIZE / original_width;

// Draw ghost sprite
draw_sprite_ext(spr_ghost, 0, x, y, scale, scale, 0, col, alpha);

// Get hangman manager for level check
var hm = instance_find(obj_hangman_manager, 0);

// Set text color based on bubble type
if (instance_exists(hm) && hm.current_level == 2 && is_number) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}

// Use the font assigned in Create event with scaling
var font_scale = 1.5;
draw_set_font(letter_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Calculate sprite center (after scaling)
var sprite_center_x = x + (BUBBLE_SIZE / 2);
var sprite_center_y = y + (BUBBLE_SIZE / 2);

// Draw scaled text
draw_text_transformed(sprite_center_x, sprite_center_y, letter, font_scale, font_scale, 0);

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);