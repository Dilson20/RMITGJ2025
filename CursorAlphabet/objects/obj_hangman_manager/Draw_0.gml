// Draw the hidden/revealed word at top middle
var display = "";
for (var i = 1; i <= string_length(word); i++) {
    display += string_char_at(revealed, i) + " ";
}

draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(room_width / 2, TOP_MARGIN / 2, display);

// === DRAW HANGMAN WORD ===
var display = "";
for (var i = 1; i <= string_length(word); i++) {
    display += string_char_at(revealed, i) + " ";
}

draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(room_width / 2, 50, display);
