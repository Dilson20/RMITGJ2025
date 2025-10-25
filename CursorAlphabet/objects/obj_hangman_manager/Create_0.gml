// === List of words to play ===
word_list_1 = ["APPLE", "BANANA", "CHERRY", "MANGO", "ORANGE", "AVOCADO"];
word_list_2 = ["KIWI", "WATERMELON", "LYCHEE", "DURIAN", "STRAWBERRY"];
word_list_3 = ["POMEGRAN ENT", "PINEAPPLE", "PAPAYA", "TANGERINE", "STARFRUIT"];
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

