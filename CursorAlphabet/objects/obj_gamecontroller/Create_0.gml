/// obj_gamecontroller : Create Event

// --- Initialize variables ---
score = 0;
level = 1;
round_index = 1;
rounds_per_level = 5;
round_time = 300;
time_penalty = 60;
timer = round_time;
remaining = 0;
bonus_mode = false;
bonus_timer = 0;
base_speed = 2;

word_list = [
    ["BANANA", "APPLE", "ORANGE", "MANGO", "PEACH"],
    ["CHERRY", "GRAPES", "LEMON", "PLUM", "GUAVA"],
    ["PAPAYA", "LYCHEE", "DRAGON", "MELON", "PEAR"]
];

// --- Store global controller reference ---
if (!variable_global_exists("ctrl")) global.ctrl = noone;
global.ctrl = id;

// --- Start the first round ---
scr_setup_round();
