function thres = AImyintermeans_34(im)
% Intermeans (Ridler–Calvard) threshold
% Only uses: imhist, mean2, round, while, abs, sum, Inf  (+ ops)


    [h, bins] = imhist(im);     % h: counts, bins: 0..255 (double)

    T_prev = Inf;
    T      = round(mean2(im)); 

    while abs(T - T_prev) > 0
        T_prev = T;

        iT = T + 1;       

        den1 = sum(h(1:iT));
        num1 = sum(bins(1:iT) .* h(1:iT));

        den2 = sum(h(iT+1:256));
        num2 = sum(bins(iT+1:256) .* h(iT+1:256));

        mu1 = (num1 + (den1==0)*T) / (den1 + (den1==0));
        mu2 = (num2 + (den2==0)*T) / (den2 + (den2==0));

        T = round((mu1 + mu2)/2);
    end

    thres = T / 255;
end
