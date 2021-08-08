% returns true if fn_input contains a matching key
function exists = key_exists(fn_input, key);

% if file doesn't exist, return false
if exist(fn_input, 'file') ~= 2
    exists = 0;
    return
end

% read file into a string
str_buf = fileread( fn_input );

% search for string of interest
ix_list = strfind( str_buf, key );

exists = ~isempty(ix_list);
