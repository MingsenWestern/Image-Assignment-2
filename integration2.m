function result = integration2(counts, bins, left, right)
    result = 0;
    currIdx = left;
    while currIdx <= right && currIdx < 255
        result = result + counts(currIdx) * bins(currIdx);
        currIdx = currIdx + 1;
    end
end