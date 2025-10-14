function thres = myintermeans_34(image)
    [counts, bins] = imhist(image);
    previousT = uint8(200);
    currentT = uint8(100);
    while abs(currentT - previousT) > 1
        previousT = currentT;
        dividend1 = integration2(counts, bins, 1, previousT + 1);
        divisor1 = integration1(counts, bins, 1, previousT + 1);
        dividend2 = integration2(counts, bins, previousT + 2, 256);
        divisor2 = integration1(counts, bins, previousT + 2, 256);
        if divisor1 == 0 || divisor2 == 0
            break;
        end
        u1 = dividend1 / divisor1;
        u2 = dividend2 / divisor2;
        currentT = uint8(round((u1+u2)/2));
    end
    thres = double(currentT) / 255
end