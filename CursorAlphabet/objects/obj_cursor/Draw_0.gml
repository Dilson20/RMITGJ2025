/// obj_cursor Draw Event
// Draw the scaled cursor sprite at the mouse position

// Configuration
var TARGET_SIZE = 64;  // Change this to adjust cursor size

// Calculate scale based on original sprite size
var original_width = sprite_get_width(spr_cursor_pacman);
var scale = TARGET_SIZE / original_width;

// Draw the cursor
draw_sprite_ext(spr_cursor_pacman, 0, x-10, y-10, scale, scale, 0, c_white, 1);