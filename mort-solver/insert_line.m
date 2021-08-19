% sample call: insert_line('/scratch/pn/mort_mus_nomon_old.csv', '2010,1,1,1992,1', '72,75')
function insert_line(fn_input, key, value);

% if file doesn't exist, write line to file and exit
if exist(fn_input, 'file') ~= 2
    fprintf('Creating file %s...\n', fn_input)
    f = fopen(fn_input, 'w');
    fprintf(f, '%s,%s\n', key, value);
    fclose(f);
    return
end

% open file for reading
f = fopen(fn_input, 'r');
if f < 1
    error('Error: file open failed: %s', fn_input);
end

% open output file
fn_tmp = tempname;
f_tmp = fopen(fn_tmp,'w');

% flag no match
match = 0;

% loop over all lines
while ~feof(f)

    % remove whitespace
    line = strtrim(fgets(f));

    % check if matches key
    % fprintf('line: %s\n', line)

    % if this matches the key
    % fprintf('line is %s\n', line);
    if (length(key) < length(line)) & (strcmp(line(1:length(key)), key))

        % fprintf('Writing: %s,%s\n', key, value);

        % write the line key,value and add it to the temporary output file
        fprintf(f_tmp, '%s,%s\n', key, value);

        % indicate we matched
        match = 1;

    % not a key match, write directly to output file
    else
        fprintf(f_tmp, '%s\n', line);
    end
end

% if we made it here without a match, need to append the key/value pair
if match == 0
    fprintf(f_tmp, '%s,%s\n', key, value);
end

% close files, copy temporary file 
fclose(f);
fclose(f_tmp);

copyfile(fn_tmp, fn_input);

