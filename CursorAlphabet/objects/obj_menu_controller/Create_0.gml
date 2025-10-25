// Button setup
buttons = [];
var center_x = room_width / 2;
var start_y = room_height / 2 - 120;

// Play button
buttons[0] = {
    sprite: spr_play_button,
    x: center_x - 160, // Half of 320 width
    y: start_y,
    width: 320,
    height: 180,
    target_room: Room1
};

// Rank button  
buttons[1] = {
    sprite: spr_rank_button,
    x: center_x - 160,
    y: start_y + 200,
    width: 320,
    height: 180,
    target_room: noone // Or your rank room
};

// Guide button
buttons[2] = {
    sprite: spr_guide_button,
    x: center_x - 160,
    y: start_y + 400,
    width: 320,
    height: 180,
    target_room: noone // Or your guide room
};