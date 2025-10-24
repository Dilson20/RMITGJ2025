function spawn_letters() {
    // Clear old letters
    with (obj_letter) instance_destroy();

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
}
