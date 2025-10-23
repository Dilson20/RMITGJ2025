// ========================
// 1️⃣ Follow mouse
// ========================
x = mouse_x;
y = mouse_y;

// ========================
// 2️⃣ Cooldowns
// ========================
if (damage_cooldown > 0) damage_cooldown -= 1;
if (enemy_hit_cooldown > 0) enemy_hit_cooldown -= 1;
if (flash_timer > 0) flash_timer -= 1;
if (hit_cooldown > 0) hit_cooldown -= 1;

// ========================
// 3️⃣ Damage targets
// ========================
if (damage_cooldown <= 0) {
    var hit_target = instance_place(x, y, obj_target);
    if (hit_target != noone) {
        hit_target.hp -= 1;
        hit_target.flash_timer = 5;
        instance_create_layer(hit_target.x, hit_target.y - 16, "Instances", obj_damage_text);
        damage_cooldown = 20; // cooldown for targets
    }
}

// ========================
// 4️⃣ Damage enemies with delay
// ========================
if (enemy_hit_cooldown <= 0) {
    var hit_enemy = instance_place(x, y, obj_enemy);
    if (hit_enemy != noone) {
        hit_enemy.hp -= 1;
        hit_enemy.flash_timer = 3;
        instance_create_layer(hit_enemy.x, hit_enemy.y - 16, "Instances", obj_damage_text);

        // Increase score if enemy destroyed
        if (hit_enemy.hp <= 0) {
            with (obj_controller) score += 1;
        }

        enemy_hit_cooldown = 30; // delay in steps before next enemy hit
    }
}

// ========================
// 5️⃣ Check bullet collision with hit cooldown
// ========================
var hit_bullet = instance_place(x, y, obj_bullet);
if (hit_bullet != noone && hit_cooldown <= 0) {
    hp -= 1;
    hp = max(hp, 0); // cap HP at 0
    flash_timer = 5;
    hit_cooldown = 30; // ~0.5 seconds invincibility after being hit
    instance_destroy(hit_bullet); // remove bullet on hit
    show_debug_message("Cursor hit by bullet! HP: " + string(hp));

    if (hp <= 0) {
        instance_destroy(); // cursor destroyed
    }
}
