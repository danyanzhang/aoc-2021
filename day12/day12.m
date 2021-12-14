% find all unique nodes
tic

data = readmatrix('input.txt', 'OutputType', 'string', 'Delimiter', '-');

% rename to numbers
G = graph(data(:,1), data(:,2));
plot(G)

adjacencyMatrix = full(adjacency(G));


pathCount = 0;

caveSize = zeros(height(G.Nodes), 1);
for i = 1:length(caveSize)
    if upper(G.Nodes{i,1}{:})==G.Nodes{i,1}{:}
        caveSize(i) = 1; % 100 is large size
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
%v = dfsearch(G, 'start')

output = cell(100, 1);

for i = 1:100000

pathFound = 0;
curr = startNode;
pathString = '';
adjActive = adjacencyMatrix;
while pathFound == 0

    %fprintf(G.Nodes{curr,1}{:})
    pathString = [pathString, G.Nodes{curr,1}{:}];

    % if current cave is small, prevent future travel to it
    adjActive(:,curr) = caveSize(curr).*adjActive(:,curr);

    % find available paths
    pathOpts = find(adjActive(curr,:)==1);

    if isempty(pathOpts) % if stuck, remove node from map
        % this  has resulted in incorrect removal from the system
        %adjacencyMatrix(:,curr) = 0; % make it so can't ever go to it
        %fprintf(',DEADEND\n')
        curr = startNode;
        pathString = '';
        adjActive = adjacencyMatrix;
        continue
    end
    curr = pathOpts(round(rand()*(length(pathOpts)-1) + 1));

    % if found end, increment found path, publish list
    if curr == endNode
        pathFound = 1;
        %fprintf(',end\n')
        pathString = [pathString ',end'];
    else
        %fprintf(',')
        pathString = [pathString ','];
    end

    %pause(1)
end % end of while

output{i} = pathString;

end %end of for


numPaths = length(unique(output))

toc