/// Tutorial Screen Draw Event

show_debug_message("Tutorial Screen Drawing Background");

// Disable texture filtering for crisp pixels
gpu_set_texfilter(false);

// Draw with integer scaling
if (sprite_exists(tutorial_sprite)) {
    draw_sprite_stretched(tutorial_sprite, 0, x_pos, y_pos, scaled_width, scaled_height);
    show_debug_message("Drew tutorial background at: " + string(x_pos) + "," + string(y_pos));
} else {
    show_debug_message("WARNING: tutorial_sprite doesn't exist!");
}

// Re-enable filtering (optional, for other sprites)
gpu_set_texfilter(true);