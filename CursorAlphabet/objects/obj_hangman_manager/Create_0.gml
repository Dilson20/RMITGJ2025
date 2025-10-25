// === List of words to play ===
word_list_1 = ["APPLE", "BANANA", "CHERRY", "MANGO", "ORANGE", "AVOCADO"];
word_list_2 = ["KIWI", "WATERMELON", "LYCHEE", "DURIAN", "STRAWBERRY"];
word_list_3 = ["POMEGRANATE", "PINEAPPLE", "PAPAYA", "TANGERINE", "STARFRUIT"];

// === Track current level and word list ===
current_level = 3;  // Start directly at Level 3
word_list = word_list_3;  // Use Level 3 words from the start
word_index = 0;

// === Current word data ===
word = "";
revealed = "";
used_letters = ds_list_create(); // Track used letters for current word

// === Game state ===
game_over = false;
is_frozen = false;  // Track if player is frozen due to wrong guess
freeze_timer = 0;   // Countdown for freeze duration
wrong_guesses = 0;  // Count consecutive wrong guesses
freeze_threshold = 2;  // Number of wrong guesses before freezing
freeze_duration = 3 * room_speed;  // Freeze for 3 seconds

// === Timer settings (different for each level) ===
timer = 120 * room_speed; // Start with Level 3 time (2 minutes)
timer_active = true; // Timer is always active
time_limit_level_1 = 60 * room_speed;  // 1 minute for Level 1
time_limit_level_2 = 90 * room_speed;  // 1.5 minutes for Level 2
time_limit_level_3 = 120 * room_speed; // 2 minutes for Level 3

// === Start first word ===
load_next_word();

// Border
TOP_MARGIN = 50;