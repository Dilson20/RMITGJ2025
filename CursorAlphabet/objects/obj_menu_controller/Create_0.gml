// Button setup
buttons = [];
var center_x = room_width / 2;
var start_y = room_height / 2 - 120;

// Define a comfortable clickable size for all buttons
var button_width = 320;
var button_height = 180;

// Play button
buttons[0] = {
    sprite: spr_play_button,
    x: center_x - button_width/2,
    y: start_y,
    width: button_width,
    height: button_height,
    target_room: Room1
};

// Rank button  
buttons[1] = {
    sprite: spr_rank_button,
    x: center_x - button_width/2,
    y: start_y + 200,
    width: button_width,
    height: button_height,
    target_room: noone
};

// Guide button
buttons[2] = {
    sprite: spr_guide_button,
    x: center_x - button_width/2,
    y: start_y + 400,
    width: button_width,
    height: button_height,
    target_room: noone
};