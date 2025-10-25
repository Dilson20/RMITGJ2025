// DRAW EVENT
// Disable texture filtering for crisp pixels
gpu_set_texfilter(false);

// Draw with integer scaling
draw_sprite_stretched(background_sprite, 0, x_pos, y_pos, scaled_width, scaled_height);

// Re-enable filtering (optional, for other sprites)
gpu_set_texfilter(true);