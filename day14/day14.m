clear;clc

filename = 'input.txt';

data = readmatrix(filename,'OutputType','string','Delimiter','->');

fid = fopen(filename);
polymerCode = strsplit(fgetl(fid), ';');
fclose(fid);
polymerCode = polymerCode{:};


steps = 40;



% generate helper matrix
helper = zeros(height(data));
for i = 1:length(helper)
    A = extract(data(i,1),1); % first character
    B = extract(data(i,1),2); % second character
    C = data(i,2); % third character
    AC = strcat(A,C);
    CB = strcat(C,B);
    helper(i, find(strcmp(data,AC))) = 1;
    helper(i, find(strcmp(data,CB))) = 1;
end



% initialize pair counter
pairCount = zeros(height(data), 1);
for i = 1:length(polymerCode)-1
    idx = find(strcmp(data,polymerCode(i:i+1)));
    pairCount(idx) = pairCount(idx) + 1;
end

for i = 1:steps
    intermediate = helper' * pairCount;
    pairCount = intermediate;
end

totalPolymer = (sum(pairCount)) + 1



elements = unique(data(:,2));
elementCount = zeros(length(elements), 1);

for i = 1:length(elementCount)
    elementCount(i) = sum(count(extract(data(:,1),1),elements(i)) .* pairCount);
    elementCount(i) = elementCount(i) + sum(count(extract(data(:,1),2),elements(i)) .* pairCount);
end

% add in first and last element
idx1 = find(strcmp(elements, polymerCode(1))); % first character
idx2 = find(strcmp(elements, polymerCode(end))) % last character
elementCount(idx1) = elementCount(idx1) + 1;
elementCount(idx2) = elementCount(idx2) + 1;

elementCount = elementCount/2

results = table(elements, elementCount)

answer = max(elementCount) - min(elementCount)