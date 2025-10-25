// CREATE EVENT
background_sprite = bg_fruit_type; // Your sprite name
scale = 4; // Change this to 2, 3, 4, etc.

// Use different variable names (added "base_" prefix)
base_sprite_width = sprite_get_width(background_sprite);
base_sprite_height = sprite_get_height(background_sprite);
scaled_width = base_sprite_width * scale;
scaled_height = base_sprite_height * scale;

// Calculate position to center the background
x_pos = (room_width - scaled_width) / 2;
y_pos = (room_height - scaled_height) / 2;