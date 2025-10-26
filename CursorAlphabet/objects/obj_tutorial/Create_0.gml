/// Tutorial Screen Create Event

// Set the tutorial sprite/image - REPLACE THIS with your actual tutorial sprite
tutorial_sprite = menu_tut; // Replace with your tutorial image sprite name
scale = 4; // Change this to 2, 3, 4, etc. to adjust size

// Remove depth setting - let it use default
// depth = 100; // This was causing issues

// Use different variable names (added "base_" prefix)
base_sprite_width = sprite_get_width(tutorial_sprite);
base_sprite_height = sprite_get_height(tutorial_sprite);
scaled_width = base_sprite_width * scale;
scaled_height = base_sprite_height * scale;

// Calculate position to center the background
x_pos = (room_width - scaled_width) / 2;
y_pos = (room_height - scaled_height) / 2;

// Set depth to be behind other UI elements if needed
// depth = 100; // Uncomment if you need to control layering

show_debug_message("Tutorial Screen Created - Sprite: " + sprite_get_name(tutorial_sprite));
show_debug_message("Tutorial position: " + string(x_pos) + "," + string(y_pos));
show_debug_message("Tutorial size: " + string(scaled_width) + "x" + string(scaled_height));