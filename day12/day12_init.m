clear;clc
% find all unique nodes
data = readmatrix('inputTest1.txt', 'OutputType', 'string', 'Delimiter', '-');

% rename to numbers
G = graph(data(:,1), data(:,2));
h = plot(G);
adjacencyMatrix = full(adjacency(G));


caveSize = ones(height(G.Nodes), 1);
for i = 1:length(caveSize)
    if upper(G.Nodes{i,1}{:})==G.Nodes{i,1}{:}
        caveSize(i) = Inf; % 100 is large size
    end

    % find start cave
    if string(G.Nodes{i,1}{:}) == "start"
        startNode = i;
    end

    % find end cave
    if string(G.Nodes{i,1}{:}) == "end"
        endNode = i;
    end
end

curr = startNode;
path = curr;
pathIdx = 1;
pathComplete = 0;
solutions = cell(1,1);
solutionsIdx = 1;
currAdj = adjacencyMatrix;