// Play menu music only once
if (!audio_is_playing(snd_menu)) {
    audio_stop_all(); // Stop any other music
    audio_play_sound(snd_menu, 1000, true);
}