/// obj_gamecontroller : Step Event

// Countdown timer
if (!bonus_mode) {
    timer -= 1 * (1/room_speed); // decrease timer per step
} else {
    bonus_timer -= 1 * (1/room_speed);
}

// Next round check
if (remaining <= 0) {
    round_index += 1;
    if (round_index > rounds_per_level) {
        level += 1;
        round_index = 1;
        bonus_mode = true;
        bonus_timer = 5 * room_speed; // 5 seconds bonus
    }
    scr_setup_round();
}
