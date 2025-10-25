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
        
        // Update round time based on new level
        switch(level) {
            case 1: round_time = 120; break; // 2 minutes
            case 2: round_time = 240; break; // 4 minutes
            case 3: round_time = 240; break; // 4 minutes
            default: round_time = 120;
        }
        
        bonus_mode = true;
        bonus_timer = 5 * room_speed; // 5 seconds bonus
    }
    timer = round_time; // Reset timer for new round
    scr_setup_round();
}
