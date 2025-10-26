// DRAW EVENT
show_debug_message("Menu Screen Drawing Background");

// Disable texture filtering for crisp pixels
gpu_set_texfilter(false);

// Draw with integer scaling
if (sprite_exists(background_sprite)) {
    draw_sprite_stretched(background_sprite, 0, x_pos, y_pos, scaled_width, scaled_height);
    show_debug_message("Drew background at: " + string(x_pos) + "," + string(y_pos));
} else {
    show_debug_message("WARNING: background_sprite doesn't exist!");
}

// Re-enable filtering (optional, for other sprites)
gpu_set_texfilter(true);