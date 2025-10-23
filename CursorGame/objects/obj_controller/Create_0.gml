// Game state setup
wave_active = false;
wave_cleared = true;
wave_number = 0;
score = 0;
spawn_timer = 0;
game_over = false;
fade_alpha = 0;
fade_speed = 0.02; // How fast the fade happens

// Start first wave
spawn_next_wave();

// Allow restart after game over
if (game_over && keyboard_check_pressed(vk_r)) {
    room_restart();
}

