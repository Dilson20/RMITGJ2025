// Draw buttons (GUI layer is always on top)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

show_debug_message("Drawing menu buttons on GUI layer (depth=" + string(depth) + ")");

// Draw prompt text at the bottom of the screen
draw_set_color(c_white);
draw_text(display_get_gui_width()/2, display_get_gui_height() - 50, "Press SPACE or ENTER to select");

for (var i = 0; i < array_length(buttons); i++) {
    var btn = buttons[i];
    
    // Check for hover using GUI coordinates
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var half_width = btn.width/2;
    var half_height = btn.height/2;
    
    btn.hover = point_in_rectangle(mx, my, 
                                 btn.x - half_width, 
                                 btn.y - half_height, 
                                 btn.x + half_width, 
                                 btn.y + half_height);
                                 
    // Add keyboard selection highlight
    if (i == selected_button) {
        btn.hover = true;
    }
    
    // Determine button color based on state
    var button_color = c_white;
    var text_color = c_black;
    
    if (btn.hover) {
        button_color = c_yellow;
        if (mouse_clicked_this_frame && point_in_rectangle(mx, my, 
            btn.x - half_width, btn.y - half_height, 
            btn.x + half_width, btn.y + half_height)) {
            // Button is being clicked this frame
            button_color = c_red;
            show_debug_message("VISUAL: Button " + string(i) + " click feedback");
        }
    }
    
    // Draw button background
    draw_set_alpha(btn.hover ? 1 : 0.8);
    draw_set_color(button_color);
    draw_rectangle(
        btn.x - btn.width/2,
        btn.y - btn.height/2,
        btn.x + btn.width/2,
        btn.y + btn.height/2,
        false
    );
    
    // Draw button text
    draw_set_color(text_color);
    draw_text(btn.x, btn.y, btn.text);
    
    // Draw button outline
    draw_set_alpha(0.1);
    draw_set_color(button_color);
    draw_rectangle(
        btn.x - half_width,
        btn.y - half_height,
        btn.x + half_width,
        btn.y + half_height,
        true
    );
    
    // Debug: Show which button is being hovered
    if (btn.hover) {
        show_debug_message("Button " + string(i) + " hovered at mouse: " + string(mouse_x) + "," + string(mouse_y));
    }
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}