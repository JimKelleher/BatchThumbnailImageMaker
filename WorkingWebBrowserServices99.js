//-----------------------------------------------------------------------------------------------------------
// String functions:

function get_file_name(input_value) {

    // Take a string and turn it into a valid GoDaddy/IIS file name.

    // Since we will be modifying the argument, let's make a copy and work with that:
    var file_name = input_value;

    // NOTE: This list is not exhaustive.  It contains only those characters
    // that I experienced as causing problems:
    file_name = remove_all_procedural(file_name, "?");
    file_name = remove_all_procedural(file_name, "&");
    file_name = remove_all_procedural(file_name, "/");
    file_name = remove_all_procedural(file_name, "+");
    file_name = remove_special_chars(file_name);

    // Clean up:
    file_name = consolidate_extraneous_spaces(file_name);
    file_name.trim();

    return file_name;

}

















