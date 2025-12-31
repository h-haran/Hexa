% Revised MATLAB script for 3 EEG channels → HEX (Vivado BRAM init)
% Assumes your MAT file contains a matrix [channels x samples] in µV

% Load EEG data
dataStruct = load('E:/EEG/record_2.mat');   % replace with your filename
fieldNames = fieldnames(dataStruct);
eeg = dataStruct.(fieldNames{1});   % numeric matrix, rows = channels

% Select only 3 channels (adjust indices if needed)
selectedRows = [1 2 3];   % FP1-F7, F7-T7, T7-P7
scaleCap = 54;            % safe maximum scale for ±600 µV in int16

for idx = 1:numel(selectedRows)
    ch = selectedRows(idx);
    channelData = eeg(ch,:);

    % Compute safe scale factor
    maxAbs = max(abs(channelData));
    scale  = min(scaleCap, floor(32767 / maxAbs));
    fprintf('Channel %d: maxAbs = %.3f µV, using scale = %d\n', ch, maxAbs, scale);

    % Scale and quantize
    ints = round(channelData * scale);

    % Clamp to int16 range
    ints = max(min(ints, 32767), -32768);

    % Convert to two’s complement hex
    u16  = typecast(int16(ints), 'uint16');
    hexStrings = dec2hex(u16, 4);   % 4 hex digits per sample

    % Write to file
    fname = sprintf('channel%d.hex', idx);
    fid = fopen(fname, 'w');
    fprintf(fid, '%s\n', hexStrings.');
    fclose(fid);

    fprintf('Wrote %s with %d samples\n', fname, numel(ints));
end
