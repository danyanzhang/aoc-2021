dots = readmatrix('input.csv');
folds = readmatrix('input_fold.txt','FileType','text','OutputType','char');

% initialize grid
% matlab will need extra point for indexing
% first value, x, increaes to the right
% second value, y, increases downward

paperWidth = max(dots(:,1)+1);
paperLength = max(dots(:,2)+1);

paper = zeros(paperLength,paperWidth);

% apply dots
for i = 1:height(dots)
    paper(dots(i,2)+1, dots(i,1)+1) = 1;
end
paperOriginal = paper;

% apply folds in order
for j = 1:height(folds)
    foldNum = str2num(folds{j,2});
    foldDim = string(folds{j,1});
    if foldDim=="fold along y"
        paperU = paper(1:foldNum,:);
        paperD = paper(foldNum+2:end,:);
        paper = paperU + flipud(paperD);
    elseif foldDim=="fold along x"
        paperL = paper(:,1:foldNum);
        paperR = paper(:,foldNum+2:end);
        paper = fliplr(paperL) + paperR;
    end
end


dotsVisible = sum(sum(paper>0))

paper_BW = paper>0;
imagesc(fliplr(paper_BW))