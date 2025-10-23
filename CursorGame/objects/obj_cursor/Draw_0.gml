if (flash_timer > 0) {
    draw_set_color(c_red);
} else {
    draw_set_color(c_white);
}

draw_sprite(spr_cursor, 0, x, y);
draw_set_color(c_white);

// Draw HP
draw_text(x + 10, y - 20, "HP: " + string(hp));
