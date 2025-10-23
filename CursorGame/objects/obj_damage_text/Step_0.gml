// Move upward
y += vspd;

// Fade out over time
alpha = life / 30;

// Decrease lifespan
life -= 1;

// Destroy after fade-out
if (life <= 0) {
    instance_destroy();
}
