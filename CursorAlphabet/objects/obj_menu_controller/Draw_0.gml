// Draw buttons
for (var i = 0; i < array_length(buttons); i++) {
    var btn = buttons[i];
    draw_sprite(btn.sprite, 0, btn.x, btn.y);
}