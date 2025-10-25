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
revealed = "";

// === Game state ===
game_over = false;
is_frozen = false;  // Track if player is frozen due to wrong guess
freeze_timer = 0;   // Countdown for freeze duration
static_bubbles = true;  // Level 1 and 2 have static bubbles, Level 3 has animated

// === Timer settings (different for each level) ===
timer = 60 * room_speed; // Start with Level 1 time (60 seconds)
timer_active = true; // Timer is always active
time_limit_level_1 = 60 * room_speed;  // 60 seconds for Level 1
time_limit_level_2 = 90 * room_speed;  // 90 seconds for Level 2
time_limit_level_3 = 120 * room_speed; // 120 seconds for Level 3

// === Wrong guess tracking ===
wrong_guesses_in_row = 0; // Track consecutive wrong guesses

// === Start first word ===
load_next_word();

// Border
TOP_MARGIN = 50;