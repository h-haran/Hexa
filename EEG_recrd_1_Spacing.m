% Reformat HEX file for Vivado $readmemh
% Input:  channel1_raw.hex  (continuous string or improperly spaced)
% Output: channel1.hex      (one 16-bit word per line)

% Parameters
inputFile  = 'Channel3.hex';   % your original file
outputFile = 'Channel3_Spaced.hex';       % corrected file
wordWidth  = 4;                    % 16-bit = 4 hex digits

% Read entire file as a single string
fid = fopen(inputFile, 'r');
rawData = fscanf(fid, '%s');   % read all characters
fclose(fid);

% Check divisibility
if mod(length(rawData), wordWidth) ~= 0
    error('File length (%d chars) is not divisible by wordWidth (%d).', ...
          length(rawData), wordWidth);
end

% Split into words
numWords = length(rawData) / wordWidth;
words = cell(numWords,1);
for i = 1:numWords
    startIdx = (i-1)*wordWidth + 1;
    endIdx   = i*wordWidth;
    words{i} = rawData(startIdx:endIdx);
end

% Write each word on its own line
fid = fopen(outputFile, 'w');
for i = 1:numWords
    fprintf(fid, '%s\n', words{i});
end
fclose(fid);

fprintf('Reformatted %s → %s with %d words\n', inputFile, outputFile, numWords);
