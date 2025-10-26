// === List of words to play ===
word_list_1 = ["APPLE", "BANANA", "CHERRY", "MANGO", "ORANGE"]; // Level 1 - 5 rounds
word_list_2 = ["KIWI", "WATERMELON", "LYCHEE", "DURIAN", "STRAWBERRY"]; // Level 2 - 5 rounds
word_list_3 = ["POMEGRANATE", "PINEAPPLE", "PAPAYA", "TANGERINE", "STARFRUIT"]; // Level 3 - 5 rounds

// === Track current level and word list ===
current_level = 1;  // Start at Level 1
word_list = word_list_1;  // Start with Level 1 words
word_index = 0;

// === Current word data ===
word = "";
revealed = "";  // Initialize revealed with empty string
word_list = word_list_1;  // Make sure word_list is initialized before load_next_word is called

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

// === Start first word ===
load_next_word();

// Border
TOP_MARGIN = 50;