// === SETTINGS ===
var max_letters = 10;       // how many letters should exist at once
var safe_distance = 10;     // padding between circles
var attempts_limit = 100;   // safety limit for position attempts
var spawn_delay = room_speed * 1; // 1 second delay between spawns

// Define safe spawn area (avoid the top area with the word)
var top_safe_zone = 150; // letters spawn below this Y value

// === GLOBAL TIMER ===
if (!variable_global_exists("spawn_timer")) {
    global.spawn_timer = 0;
}

// Countdown
if (global.spawn_timer > 0) {
    global.spawn_timer--;
    exit; // wait until timer reaches 0
}

// === SPAWN LOGIC ===
if (instance_number(obj_letter) < max_letters) {

    // Create a new letter
    var new_letter = instance_create_layer(0, 0, "Instances", obj_letter);

    // Initialize fade-in settings
    new_letter.alpha = 0;
    new_letter.state = "appearing";
    new_letter.fade_speed = 0.02;
    new_letter.stay_timer = irandom_range(60, 180);

    // === Find non-overlapping position ===
    var safe = false;
    repeat (attempts_limit) {
        safe = true;
        new_letter.x = irandom_range(50, room_width - 50);
        new_letter.y = irandom_range(top_safe_zone, room_height - 50);

        with (obj_letter) {
            if (id != new_letter.id) {
                var dx = x - new_letter.x;
                var dy = y - new_letter.y;
                var dist = sqrt(dx*dx + dy*dy);
                if (dist < (radius + new_letter.radius + safe_distance)) {
                    safe = false;
                }
            }
        }

        if (safe) break;
    }

    // Reset global spawn timer
    global.spawn_timer = spawn_delay;
}
