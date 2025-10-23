// Only process waves if game is not over
if (!game_over) {
    // Check if wave is active and whether all enemies/targets are destroyed
    if (wave_active) {
        if (instance_number(obj_target) == 0 && instance_number(obj_enemy) == 0) {
            wave_active = false;
            wave_cleared = true;
            spawn_timer = 0;
            show_debug_message("Wave " + string(wave_number) + " cleared!");
        }
    }

    // Wait 2 seconds before spawning next wave
    if (wave_cleared) {
        spawn_timer += 1;
        if (spawn_timer > room_speed * 2) { // 2-second delay
            spawn_next_wave();
        }
    }

    // Check if player cursor is destroyed
    if (!instance_exists(obj_cursor)) {
        game_over = true;
        show_debug_message("GAME OVER — Final Score: " + string(score));
    }
}
else {
    // Fade in effect after game over
    if (fade_alpha < 1) {
        fade_alpha += fade_speed;
    }

    // Restart key
    if (keyboard_check_pressed(ord("R"))) {
        room_restart();
    }
}
