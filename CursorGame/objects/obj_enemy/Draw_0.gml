if (flash_timer > 0) {
    draw_set_color(c_red);
} else {
    draw_set_color(c_white);
}

draw_self();
draw_set_color(c_white);

// Draw HP above enemy
draw_text(x - 8, y - sprite_height - 10, string(hp));
