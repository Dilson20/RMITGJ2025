// Letter will be set by controller now
letter = "A";
is_number = false; // Used for level 2 to track if this is a number bubble

// Circle radius
radius = 30;
// Get the top margin from hangman manager
var hm = instance_find(obj_hangman_manager, 0);
var min_y = 120; // default fallback
if (instance_exists(hm)) {
    min_y = hm.TOP_MARGIN + 70; // Add extra space for the word display
}

// Try to find a free spot that doesn't overlap others
var safe = false;
var attempts = 0;
repeat (100) { // safety limit
    attempts++;
    x = irandom_range(80, room_width - 80);
    y = irandom_range(min_y, room_height - 50); // ← Use min_y instead of 50
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
