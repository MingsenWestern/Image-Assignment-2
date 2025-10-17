function thres = myintermeans_34(image)
    [counts, bins] = imhist(image);
    previousT = Inf;
    currentT = int16(round(mean2(image)));
    maxIter = 1000;
    iterCounter = 0;
    while abs(currentT - previousT) > 1 && iterCounter < maxIter
        previousT = currentT;
        dividend1 = integration2(counts, bins, 1, previousT + 1);
        divisor1  = integration1(counts, bins, 1, previousT + 1);
        dividend2 = integration2(counts, bins, previousT + 2, 256);
        divisor2  = integration1(counts, bins, previousT + 2, 256);
        if divisor1 == 0 || divisor2 == 0
            break;
        end
        u1 = dividend1 / divisor1;
        u2 = dividend2 / divisor2;
        currentT = int16(round((u1+u2)/2));
        iterCounter = iterCounter + 1;
    end
    thres = double(currentT) / 255;
end