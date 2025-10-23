// Flash timer countdown
if (flash_timer > 0) {
    flash_timer -= 1;
}

// Destroy target when HP <= 0
if (hp <= 0) {
    instance_destroy();
}
