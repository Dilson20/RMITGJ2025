/// obj_gamecontroller : Draw GUI Event
draw_set_font(fnt_main);
draw_set_color(c_white);

draw_text(20, 20, "Score: " + string(score));
draw_text(20, 50, "Level: " + string(level) + "  Round: " + string(round));

if (bonus_mode) {
    draw_text(20, 80, "BONUS TIME: " + string(ceil(bonus_timer / room_speed)) + "s");
} else {
    draw_text(20, 80, "Time: " + string(ceil(timer / room_speed)) + "s");
    draw_text(20, 110, "Find: " + string(target_letter));
}
