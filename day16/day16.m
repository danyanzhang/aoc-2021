clear; clc

test = '38006F45291200';
decoded = aochex2bin(test);

%decoded = '110100101111111000101000';

packetV = bin2dec(decoded(1:3));
typeID = bin2dec(decoded(4:6));

switch typeID
case 4
    % literal value
    % the following groups of 5 are literal numbers
    % first bit of every segmenent starts with 1
    % except the last, it starts with 0
    stopLiteral = 0;
    indLiteral = 6;
    litChunk = '';
    while stopLiteral == 0
        indLiteral = indLiteral + 1;
        % if there aren't enough characters, break the script
        if length(decoded) - indLiteral < 5
            break
        end
        litFirst = decoded(indLiteral);
        if litFirst == 0
            stopLiteral = 1;
        else
            litChunk = [litChunk, decoded(indLiteral+1:indLiteral+4)];
        end
        indLiteral = indLiteral + 4;
    end
    literalValue = bin2dec(litChunk);
otherwise
    % operator
    lenTypeID = str2num(decoded(7));
    if lenTypeID == 0
        % get next 15 bits
        lenSubpacket = bin2dec(decoded(8:22));
    elseif lenTypeID == 1
        % get next 11 bits
        numSubPackets = decoded(8:18);
    end
end

function decoded = aochex2bin(test)
decoded = '';
for i = 1:length(test)
    curr = test(i);
    switch curr
    case '0'
        currHex = '0000';
    case '1'
        currHex = '0001';
    case '2'
        currHex = '0010';
    case '3'
        currHex = '0011';
    case '4'
        currHex = '0100';
    case '5'
        currHex = '0101';
    case '6'
        currHex = '0110';
    case '7'
        currHex = '0111';
    case '8'
        currHex = '1000';
    case '9'
        currHex = '1001';
    case 'A'
        currHex = '1010';
    case 'B'
        currHex = '1011';
    case 'C'
        currHex = '1100';
    case 'D'
        currHex = '1101';
    case 'E'
        currHex = '1110';
    case 'F'
        currHex = '1111';
    otherwise 
        error('no match found')
    end

    decoded = [decoded currHex];
end
end % end of function