/// @function is_letter_used(letter)
/// @param {string} letter The letter to check
/// @returns {boolean} True if the letter has been used in current word
function is_letter_used(letter) {
    with (obj_hangman_manager) {
        return (ds_list_find_index(used_letters, letter) != -1);
    }
    return false;
}