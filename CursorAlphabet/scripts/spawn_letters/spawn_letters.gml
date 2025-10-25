function spawn_letters() {
    // Clear old letters
    with (obj_letter) instance_destroy();

    // Skip if letter already used
    var target_letter = global.ctrl.target_letter;
    if (ds_list_find_index(global.ctrl.used_letters, target_letter) != -1) {
        return;
    }

    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var startX = 100;
    var startY = 400;
    var spacing = 40;

    for (var i = 1; i <= string_length(alphabet); i++) {
        var ch = string_char_at(alphabet, i);
        var xx = startX + ((i - 1) mod 13) * spacing;
        var yy = startY + floor((i - 1) / 13) * spacing;

        var inst = instance_create_layer(xx, yy, "Instances", obj_letter);
        inst.letter = ch;
        inst.col = make_color_hsv(irandom(255), 200, 255);
    }
    
    // Add letter to used list after spawning
    ds_list_add(global.ctrl.used_letters, target_letter);
}
