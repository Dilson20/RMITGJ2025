function spawn_next_wave() {
    wave_number += 1;
    wave_active = true;
    wave_cleared = false;
    spawn_timer = 0;

    var num_targets = irandom_range(2, 4);
    var num_enemies = irandom_range(1, 3);

    // Spawn targets
    for (var i = 0; i < num_targets; i++) {
        var tx = irandom_range(64, room_width - 64);
        var ty = irandom_range(64, room_height - 64);
        instance_create_layer(tx, ty, "Instances", obj_target);
    }

    // Spawn enemies
    for (var j = 0; j < num_enemies; j++) {
        var ex = irandom_range(64, room_width - 64);
        var ey = irandom_range(64, room_height - 64);
        instance_create_layer(ex, ey, "Instances", obj_enemy);
    }

    show_debug_message("Wave " + string(wave_number) + " started!");
}
