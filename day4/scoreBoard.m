function score = scoreBoard(number, board, boardTracker)
    sumUncalled = sum(sum(board .* boardTracker));
    score = sumUncalled * number;
end