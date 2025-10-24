radius += 2;          // expand
alpha -= fade_speed;  // fade out

if (alpha <= 0) {
    instance_destroy();
}
