clc


% find viable connections
connections = find(currAdj(curr,:)==1)

% if there are no viable connections
if isempty(connections)
    % see if the end has been reached
    if curr == endNode % add to solutions list
        solutions{solutionsIdx} = path;
        solutionsIdx = solutionsIdx + 1; % increment solutions
    end
    % backtrack to previous node
    curr = lastNode;
    % add back visit
    % subtract visit from this path

else % else, randomly select a location

    randInd = round(rand()*(length(connections)-1)+1);
    nextNode = connections(randInd);
end

% subtract visit from current location and matrix