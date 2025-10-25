// Letter will be set by controller now
letter = "A";
is_number = false; // Used for level 2 to track if this is a number bubble

// Circle radius (adjusted for 32x32 sprite)
radius = 16;

// Set font based on level
var hm = instance_find(obj_hangman_manager, 0);
if (instance_exists(hm)) {
    if (hm.current_level == 1 || hm.current_level == 2) {
        letter_font = font_normal;
    } else {
        // Level 3: randomize between special fonts
        var fonts = [font_special_1, font_special_2, font_special_3];
        letter_font = fonts[irandom(array_length(fonts) - 1)];
    }
} else {
    letter_font = font_normal; // default
}

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
    y = irandom_range(min_y, room_height - 50);
    safe = true;

    // Check distance to other letters
    with (obj_letter) {
        if (id != other.id) {
            var dx = other.x - x;
            var dy = other.y - y;
            var dist = sqrt(dx*dx + dy*dy);
            if (dist < (radius + other.radius + 10)) {
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
stay_timer = irandom_range(60, 180);