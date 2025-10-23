// Flash timer countdown
if (flash_timer > 0) flash_timer -= 1;

// Destroy when dead
if (hp <= 0) {
    instance_destroy();
}

// Shooting logic
if (instance_exists(obj_cursor)) {
    // shooting logic
    shoot_timer += 1;
    if (shoot_timer > room_speed * 2) {
        shoot_timer = 0;
        var b = instance_create_layer(x, y, "Instances", obj_bullet);
        b.direction = point_direction(x, y, obj_cursor.x, obj_cursor.y);
    }
}

