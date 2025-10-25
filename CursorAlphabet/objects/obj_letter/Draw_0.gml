// Apply alpha fade
draw_set_alpha(alpha);

// Draw circle background
draw_set_color(col);
draw_circle(x, y, radius, false); // outline
draw_circle(x, y, radius, true);  // filled circle

// Get hangman manager for level check
var hm = instance_find(obj_hangman_manager, 0);

// Set text color based on bubble type
if (instance_exists(hm) && hm.current_level == 2 && is_number) {
    draw_set_color(c_yellow); // Numbers in yellow for level 2
} else {
    draw_set_color(c_white); // Letters in white
}

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, letter);

// Reset alpha for other objects
draw_set_alpha(1);
