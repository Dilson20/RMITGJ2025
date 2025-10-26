/// Clean up data structures
// Check if data structures exist before destroying them
if (ds_exists(used_letters, ds_type_list)) {
    ds_list_destroy(used_letters);
}

if (ds_exists(chaos_letter_hints, ds_type_map)) {
    ds_map_destroy(chaos_letter_hints);
}