// Random uppercase letter
var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
letter = string_char_at(letters, irandom_range(1, string_length(letters)));

// Circle radius
radius = 30;

// Safe zone to avoid hangman word area
var top_safe_zone = 120;

// Try to find a free spot that doesn't overlap others
var safe = false;
var attempts = 0;
repeat (100) { // safety limit
    attempts++;
    x = irandom_range(50, room_width - 50);
    y = irandom_range(top_safe_zone, room_height - 50); // Spawn below hangman word
    safe = true;

    // Check distance to other letters
    with (obj_letter) {
        if (id != other.id) {
            var dx = other.x - x;
            var dy = other.y - y;
            var dist = sqrt(dx*dx + dy*dy);
            if (dist < (radius + other.radius + 10)) { // +10 padding
                safe = false;
            }
        }
    }

    if (safe) break;
}

// Random color
col = make_color_rgb(irandom(255), irandom(255), irandom(255));

// Alpha fade settings
alpha = 0;
fade_speed = 0.02;

// State machine
state = "appearing";
stay_timer = irandom_range(60, 180); // 1–3 seconds
