// === List of words to play ===
// Level 1: Basic IT Terms (5-6 letters, beginner)
word_list_1 = ["MOUSE", "CLICK", "LOGIN", "EMAIL", "VIRUS"]; // Level 1 - 5 rounds

// Level 2: Intermediate Programming/IT Terms (6-7 letters)
word_list_2 = ["PYTHON", "GITHUB", "CODING", "SERVER", "ROUTER"]; // Level 2 - 5 rounds

// Level 3: Advanced Programming Terms (9-10 letters)
word_list_3 = ["ALGORITHM", "DATABASE", "FRAMEWORK", "DEVELOPER", "JAVASCRIPT"]; // Level 3 - 5 rounds

// Chaos spellings (add 2 letters + change 1 letter)
// Format: Original → Chaos (what was changed)

// CHAOS LEVEL 1 (matching order with word_list_1)
chaos_word_list_1 = ["MOUSE", "CLICK", "LOGIN", "EMAIL", "VIRUSXX"]; 
// MOUSE (normal)
// CLICK (normal)
// LOGIN (normal)
// EMAIL (normal)
// VIRUS + XX = VIRUSXX

// CHAOS LEVEL 2 (matching order with word_list_2)
chaos_word_list_2 = ["PYTHON", "GITHUB", "CODINGQQ", "SERVER", "ROUTERPP"]; 
// PYTHON (normal)
// GITHUB (normal)
// CODING + QQ = CODINGQQ
// SERVER (normal)
// ROUTER + PP = ROUTERPP

// CHAOS LEVEL 3 (matching order with word_list_3)
chaos_word_list_3 = ["ALGORITHIMZZ", "DATABASE", "FRAMEWORKXX", "DEVELOPER", "JAVASCRIPYY"]; 
// ALGORITHM->ALGORITHIM (M->IM) + ZZ = ALGORITHIMZZ
// DATABASE (normal)
// FRAMEWORK + XX = FRAMEWORKXX
// DEVELOPER (normal)
// JAVASCRIPT->JAVASCRIP (T removed) + YY = JAVASCRIPYY

// Normal to Chaos mapping for hints
chaos_letter_hints = ds_map_create();
// Will be populated per word in load_next_word()

// Initialize used_letters list (even though we may not use it, prevent cleanup error)
used_letters = ds_list_create();

// Hint message variables
show_hint = false;
hint_message = "";
hint_timer = 0;
hint_alpha = 0;

// === Track current level and word list ===
current_level = 1;  // Start at Level 1
word_list = word_list_1;  // Start with Level 1 words
chaos_mode = false;  // Track if we're in chaos mode
word_index = 0;

// === Current word data ===
word = "";
revealed = "";  // Initialize revealed with empty string
normal_word = "";  // Store the normal spelling for comparison

// === Game state ===
game_over = false;
show_losing_screen = false;  // Track if we should show the losing screen
show_winning_screen = false;  // Track if we should show winning screen
is_frozen = false;  // Track if player is frozen due to wrong guess
freeze_timer = 0;   // Countdown for freeze duration
static_bubbles = true;  // Level 1 and 2 have static bubbles, Level 3 has animated

// === Timer settings (different for each level) ===
timer = 120 * room_speed; // Start with Level 1 time (120 seconds)
timer_active = true; // Timer is always active
time_limit_level_1 = 120 * room_speed;  // 120 seconds for Level 1
time_limit_level_2 = 240 * room_speed;  // 240 seconds for Level 2
time_limit_level_3 = 240 * room_speed; // 240 seconds for Level 3

// === Score tracking ===
if (!variable_global_exists("level1_time_left")) global.level1_time_left = 0;
if (!variable_global_exists("level2_time_left")) global.level2_time_left = 0;
if (!variable_global_exists("level3_time_left")) global.level3_time_left = 0;
if (!variable_global_exists("total_score")) global.total_score = 0;
if (!variable_global_exists("player_name")) global.player_name = "Player";

// === Wrong guess tracking ===
wrong_guesses_in_row = 0; // Track consecutive wrong guesses

// === Round transition settings ===
round_transition = false;
transition_timer = 0;
TRANSITION_DURATION = 3 * room_speed;  // 3 seconds pause

// === Chaos mode visuals ===
chaos_flash_timer = 0;
chaos_flash_alpha = 0;

// === Start first word ===
load_next_word();

// Border
TOP_MARGIN = 50;

// === Music setup ===
// Stop any currently playing music
audio_stop_all();

// Play appropriate music based on starting level
if (current_level == 3) {
    audio_play_sound(snd_chaos, 1000, true);
} else {
    audio_play_sound(snd_background, 1000, true);
}