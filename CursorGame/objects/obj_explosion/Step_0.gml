// Fade out over time
alpha = life / 10;
life -= 1;
if (life <= 0) {
    instance_destroy();
}
