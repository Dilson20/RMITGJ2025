if (flash_timer > 0) {
    draw_set_color(c_red);
} else {
    draw_set_color(c_white);
}

draw_self(); // draw the sprite with tint

// Reset draw color so other objects aren't tinted
draw_set_color(c_white);

// Draw HP text above the target
draw_text(x - 8, y - sprite_height - 10, string(hp));
