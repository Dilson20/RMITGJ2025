// === List of words to play ===
word_list = ["APPLE", "BANANA", "CHERRY", "MANGO", "ORANGE"];
word_index = 0;

// === Current word data ===
word = "";
revealed = "";
max_attempts = 6;
attempts_left = max_attempts;

// === Game state ===
game_over = false;

// === Start first word ===
load_next_word();

// Border
TOP_MARGIN = 50;

