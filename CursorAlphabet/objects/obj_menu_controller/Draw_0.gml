// Draw buttons
for (var i = 0; i < array_length(buttons); i++) {
    var btn = buttons[i];
    draw_sprite(btn.sprite, 0, btn.x, btn.y);
    
    // OPTIONAL DEBUG: Visualize clickable areas (remove when done testing)
   
    draw_set_alpha(0.2);
    draw_set_color(c_yellow);
    draw_rectangle(btn.x, btn.y, btn.x + btn.width, btn.y + btn.height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
   
}