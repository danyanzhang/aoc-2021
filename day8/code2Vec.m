function dispVector = code2Vec(sequence)
% for each code, turn it into a vector
searchChar = 'abcdefg';
dispVector = zeros(1, 7);
for i = 1:length(searchChar)
    letterPosition = strfind(sequence, searchChar(i));
    if isempty(letterPosition)
        dispVector(i) = 0;
    else
        dispVector(i) = 1;
    end
end 
end % end of function