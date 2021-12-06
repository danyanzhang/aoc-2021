function win = checkBoard(board)
    % board is a 5x5 matrix in this case
    for i = 1:5
        sumRow = sum(board(i,:));
        sumCol = sum(board(:,i));
        if sumRow==0 || sumCol==0
            win = 1;
        else
            win = 0;
        end
        if win==1 % win condition only requires 1 win
            break
        end
    end
end