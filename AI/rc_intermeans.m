function [Tnorm, BW, T255] = rc_intermeans(I)
%RC_INTERMEANS  Ridler & Calvard intermeans thresholding (ISODATA), normalized
%   [Tnorm, BW, T255] = RC_INTERMEANS(I)
%     Tnorm in [0,1], BW is binary, T255 is the 0..255 integer threshold.
%
%   Uses: function, imhist, Inf, round, mean2, while...end, abs, sum

    % Initial guess: global mean (rounded to an integer gray level)
    T    = round(mean2(I));     % mean2, round
    dT   = Inf;                 % Inf
    [h, ~] = imhist(I);         % imhist (assumes uint8 bins 0..255)

    n   = double(h(:));         % counts
    g   = (0:255)';             % gray levels
    N   = sum(n);               % sum
    G   = sum(g .* n);          % sum
    if N == 0
        T = 0;
        Tnorm = 0.0;
        BW = false(size(I));
        T255 = 0;
        return
    end

    cumN = cumsum(n);
    cumG = cumsum(g .* n);

    maxIter = 1000; it = 0;
    while abs(dT) > 0 && it < maxIter     % while...end, abs
        idx = max(1, min(256, T + 1));

        w0 = cumN(idx);
        w1 = N - w0;

        if w0 == 0 || w1 == 0
            Tnew = T;                     % degenerate split -> stop moving
        else
            mu0 = cumG(idx)          / w0;
            mu1 = (G - cumG(idx))    / w1;
            Tnew = round((mu0 + mu1)/2); % round
        end

        dT = Tnew - T;
        T  = max(0, min(255, Tnew));
        it = it + 1;
    end

    % Outputs
    T255  = T;
    Tnorm = double(T)/255;                % normalized in [0,1]

    % Apply normalized threshold on normalized image
    BW = im2double(I) > Tnorm;
end
