//show_debug_message("DRAW EVENT - Drawing buttons...");

//// Draw buttons
//draw_set_halign(fa_center);
//draw_set_valign(fa_middle);

//for (var i = 0; i < array_length(buttons); i++) {
//    var btn = buttons[i];
    
//    // Check for hover only (no click detection here)
//    var mx = mouse_x;
//    var my = mouse_y;
//    var half_width = btn.width/2;
//    var half_height = btn.height/2;
    
//    btn.hover = point_in_rectangle(mx, my, 
//                                 btn.x - half_width, 
//                                 btn.y - half_height, 
//                                 btn.x + half_width, 
//                                 btn.y + half_height);
    
//    // Draw button based on hover state
//    draw_set_alpha(btn.hover ? 1 : 0.8);
//    draw_set_color(btn.hover ? c_yellow : c_white);
//    draw_rectangle(
//        btn.x - btn.width/2,
//        btn.y - btn.height/2,
//        btn.x + btn.width/2,
//        btn.y + btn.height/2,
//        false
//    );
    
//    // Draw button text
//    draw_set_color(c_black);
//    draw_text(btn.x, btn.y, btn.text);
    
//    // Debug hover
//    if (btn.hover) {
//        show_debug_message("Button " + string(i) + " hovered at mouse: " + string(mouse_x) + "," + string(mouse_y));
//    }
    
//    draw_set_alpha(1);
//    draw_set_color(c_white);
//}