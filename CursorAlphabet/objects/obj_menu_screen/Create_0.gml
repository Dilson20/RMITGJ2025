// CREATE EVENT
background_sprite = bg_fruit_type_4; // Your sprite name
// Calculate scale to match bg_fruit_type_3 dimensions (320x180 at scale 4 = 1280x720)
scale = 1280 / sprite_get_width(background_sprite); // Auto-calculates to ~0.96

// Remove depth setting - let it use default
// depth = 100; // This was causing issues

// Use different variable names (added "base_" prefix)
base_sprite_width = sprite_get_width(background_sprite);
base_sprite_height = sprite_get_height(background_sprite);
scaled_width = base_sprite_width * scale;
scaled_height = base_sprite_height * scale;

// Calculate position to center the background
x_pos = (room_width - scaled_width) / 2;
y_pos = (room_height - scaled_height) / 2;

// Set depth to be behind the menu controller
//depth = 100; // Higher number means further back