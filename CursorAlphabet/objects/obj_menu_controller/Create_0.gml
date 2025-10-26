show_debug_message("==================================");
show_debug_message("MENU CONTROLLER CREATE EVENT");
show_debug_message("Object: " + object_get_name(object_index));
show_debug_message("Room: " + room_get_name(room));

// Remove depth setting - GUI layer handles this
// depth = -100; // This was causing issues

// Initialize selected button index
selected_button = 0;

// Initialize button array
buttons = array_create(3);

// Calculate screen center and button dimensions using GUI coordinates
var center_x = display_get_gui_width()/2;
var start_y = display_get_gui_height() * 0.3;
var button_width = 200;
var button_height = 60;
var button_spacing = 100;

show_debug_message("Screen center: " + string(center_x));
show_debug_message("Start Y: " + string(start_y));

// Create simple buttons without sprites first
buttons[0] = {
    x: center_x,
    y: start_y,
    width: button_width,
    height: button_height,
    target_room: Room2,  // Changed to Room2 for gameplay
    hover: false,
    text: "PLAY"
};

buttons[1] = {
    x: center_x,
    y: start_y + button_spacing,
    width: button_width,
    height: button_height,
    target_room: noone,
    hover: false,
    text: "RANK"
};

buttons[2] = {
    x: center_x,
    y: start_y + (button_spacing * 2),
    width: button_width,
    height: button_height,
    target_room: noone,
    hover: false,
    text: "GUIDE"
};

show_debug_message("Buttons created: " + string(array_length(buttons)));
show_debug_message("==================================");

// In Create_0.gml, after buttons are created:
if (room_exists(Room1)) {
    show_debug_message("Room1 exists and is ready");
} else {
    show_debug_message("ERROR: Room1 does not exist in project!");
}