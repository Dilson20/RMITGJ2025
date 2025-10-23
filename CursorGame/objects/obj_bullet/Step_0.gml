// Move forward automatically due to speed/direction
life -= 1;
if (life <= 0) instance_destroy();

// If hit the cursor
if (place_meeting(x, y, obj_cursor)) {
    // Create explosion
    instance_create_layer(x, y, "Instances", obj_explosion);
    
    // Destroy the bullet
    instance_destroy();
}

// Destroy bullet if it goes outside the room
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
