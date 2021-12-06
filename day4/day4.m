% import
clear;clc

filename = 'day4_data.csv';
input = readmatrix('input.csv');
data = readmatrix(filename);
% every 5 is a board
bingoBoards = cell(height(data)/5, 1);
boardTracker = bingoBoards;
boardIdx = 1:5:height(data);

for i = 1:height(data)/5
    bingoBoards{i} = data(boardIdx(i):boardIdx(i)+4,:);
    boardTracker{i} = ones(5, 5);
end


% playing the game
% number drawing
for i = 1:length(input)
    number = input(i);
    % play on specific board
    for j = 1:length(bingoBoards)
        matchIdx = find(bingoBoards{j}==number);
        if isempty(matchIdx)
            continue
        else
            boardTracker{j}(matchIdx) = 0;
        end
        win(j) = checkBoard(boardTracker{j});

    end
    % command to break loop
    if sum(win)==1
        winningBoard = find(win==1);
        score = scoreBoard(number, bingoBoards{winningBoard}, boardTracker{winningBoard});
        break
    end
end

% part 2
% don't want to win

% reverse the loop
% iterate by board

turns2Win = zeros(length(bingoBoards), 1);
winningScore = zeros(length(bingoBoards), 1);
for j = 1:length(bingoBoards)
    turnCounter = 0;
    for i = 1:length(input)
        number = input(i);
        turnCounter = turnCounter + 1;
        matchIdx = find(bingoBoards{j}==number);
        if isempty(matchIdx)
            continue
        else
            boardTracker{j}(matchIdx) = 0;
        end
        
        % if win condition detected
        if checkBoard(boardTracker{j}) == 1
            winningScore(j) = number;
            break
        end
    end
    
    turns2Win(j) = turnCounter;
end

losingBoard = find(turns2Win == max(turns2Win));
score2 = scoreBoard(winningScore(losingBoard), bingoBoards{losingBoard}, boardTracker{losingBoard});
