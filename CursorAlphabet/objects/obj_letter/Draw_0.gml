// Apply alpha fade
draw_set_alpha(alpha);

// Draw circle background
draw_set_color(col);
draw_circle(x, y, radius, false); // outline
draw_circle(x, y, radius, true);  // filled circle

// Draw letter in white, centered
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, letter);

// Reset alpha for other objects
draw_set_alpha(1);
