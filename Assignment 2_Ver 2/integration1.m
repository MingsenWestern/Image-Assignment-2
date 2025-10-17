function result = integration1(counts, bins, left, right)
    result = 0;
    currIdx = left;
    while currIdx <= right 
        result = result + counts(currIdx);
        currIdx = currIdx + 1;
    end
end
