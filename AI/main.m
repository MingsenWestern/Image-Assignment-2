function main
%MAIN_RC_INTERMEANS  Hard-coded path; saves grayscale; shows histogram; prints 0–255 and 0–1 thresholds.
%   Edit IMG_PATH below, then run: main_rc_intermeans
%
%   Requires rc_intermeans.m that returns [Tnorm, BW, T255].

    % ===== EDIT THIS LINE (pick ONE) =====
    IMG_PATH = '~/Documents/Work/Code/MATLAB/Test/Test3/image/mountain.jpg';           % Windows example
    % IMG_PATH = '/Users/you/Pictures/your_image.jpg'; % macOS/Linux example
    % =====================================

    if ~exist(IMG_PATH,'file')
        error('File not found: %s\nEdit IMG_PATH inside main_rc_intermeans.m.', IMG_PATH);
    end

    % Read (supports indexed images with colormap)
    try
        [A, map] = imread(IMG_PATH);
    catch ME
        error('Could not read "%s": %s', IMG_PATH, ME.message);
    end

    % Convert to grayscale uint8 (catch-all)
    if ~isempty(map)
        I = ind2gray(A, map);      % to grayscale in [0,1]
        I = im2uint8(I);
    else
        I = A;
        if ndims(I) == 3, I = rgb2gray(I); end
        if ~isa(I,'uint8'), I = im2uint8(mat2gray(I)); end
    end

    % Save converted grayscale (uint8) in SAME FOLDER
    [inDir, baseName, ~] = fileparts(IMG_PATH);
    outName = sprintf('%s_gray_uint8.png', baseName);
    outPath = fullfile(inDir, outName);
    try
        imwrite(I, outPath);
    catch ME
        error(['Failed to save grayscale image next to the source:\n  %s\n' ...
               'Reason: %s\n(Per your request, no alternate location is used.)'], outPath, ME.message);
    end
    fprintf('Saved grayscale (uint8) image to:\n  %s\n', outPath);

    % Run Ridler–Calvard (prints 0–255 and 0–1)
    [Tnorm, BW, T255] = rc_intermeans(I);
    fprintf('Ridler–Calvard threshold (0–255): %d\n', T255);
    fprintf('Ridler–Calvard threshold (0–1):   %.6f\n', Tnorm);

    % Display: Input, Histogram (with threshold), and Binary result
    figure('Name','Ridler–Calvard (Intermeans) Demo');
    subplot(1,3,1); imshow(I); title('Input (grayscale uint8)');

    subplot(1,3,2);
    imhist(I); title('Histogram'); hold on;
    yl = ylim; 
    line([T255 T255], yl, 'LineWidth', 1.5);         % threshold marker
    xlim([0 255]); xlabel('Gray level (0–255)'); ylabel('Count');
    hold off;

    subplot(1,3,3); 
    imshow(BW); title(sprintf('BW (I > %.4f)', Tnorm));

    % Optional: dedicated histogram window (uncomment if you want a separate figure)
    %{
    figure('Name','Histogram (Grayscale uint8)');
    imhist(I); grid on; hold on;
    yl = ylim; line([T255 T255], yl, 'LineWidth', 1.5);
    text(min(T255+3,255), yl(2)*0.9, sprintf('T=%d (%.4f)', T255, Tnorm), 'FontWeight','bold');
    xlim([0 255]); xlabel('Gray level (0–255)'); ylabel('Count');
    title('Histogram with Ridler–Calvard Threshold');
    hold off;
    %}

    % Convenience: drop variables into base workspace
    assignin('base','I_gray_uint8', I);
    assignin('base','BW_rc', BW);
    assignin('base','T255', T255);
    assignin('base','Tnorm', Tnorm);
end
