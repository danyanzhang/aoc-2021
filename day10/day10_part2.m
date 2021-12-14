% autocorrect script

% first delete all the pairs that are actually correct
day10
scores = zeros(length(dataIncomplete), 1);
for i = 1:height(dataIncomplete)
    scores(i) = scorePart2(dataIncomplete{i});
end
%line_test = '[({(<(())[]>[[{[]{<()<>>';

%scorePart2(line_test)

sortedScores = sort(scores);
answer2 = int64(median(sortedScores))


function score = scorePart2(line_test)
    fix = autocorrect(line_test);
    score = 0; % initialize score
    for i = 1:length(fix)
        score = score * 5;
        curr = fix(i);
        switch curr
        case ')'
            charScore = 1;
        case ']'
            charScore = 2;
        case '}'
            charScore = 3;
        case '>'
            charScore = 4;
        otherwise
            disp('Error in scoring')
        end
        score = score + charScore;
    end
end




function fix = autocorrect(line_test)
    needPairs = runLine(line_test);
    needPairsFlip = fliplr(needPairs); % then just execute in this order
    fix = char('');
    for i = 1:length(needPairs)
        curr = needPairsFlip(i);
        switch curr
        case '('
            fix = [fix ')'];
        case '['
            fix = [fix ']'];
        case '{'
            fix = [fix '}'];
        case '<'
            fix = [fix '>'];
        otherwise
            disp('Something broke.')
        end
    end
end % end of function


function [line_test2, incorrectChar, expected] = deletePair(line_test)
    incorrectChar = 0; % initialize 
    for i = 1:length(line_test)
        curr = line_test(i);
        if curr=='(' || curr=='[' || curr=='{' || curr=='<'
            lastOpener = curr;
            lastNdx = i;
        elseif curr==')' && lastOpener=='('
            line_test(i) = [];
            line_test(lastNdx) = [];
            break
        elseif curr==']' && lastOpener=='['
            line_test(i) = [];
            line_test(lastNdx) = [];
            break
        elseif curr=='}' && lastOpener=='{'
            line_test(i) = [];
            line_test(lastNdx) = [];
            break
        elseif curr=='>' && lastOpener=='<'
            line_test(i) = [];
            line_test(lastNdx) = [];
            break
        else
            %disp('Incorrect closing character')
            incorrectChar = curr;
            break
        end
    end % end of for

    % generate expected character
    switch lastOpener
    case '('
        expected = ')';
    case '['
        expected = ']';
    case '{'
        expected = '}';
    case '<'
        expected = '>';
    otherwise
        expected = '';
    end

line_test2 = line_test;
end % end of function



function line_test = runLine(line_test)
    line_test_original = line_test;
        corrupt = 0;
    loopNum = 0;
    points = 0;
    while corrupt == 0
        [line_test, incorrectChar, expected] = deletePair(line_test);
        if isnumeric(incorrectChar)==0
            corrupt = 1;
            switch incorrectChar
            case ')'
                points = 3;
            case ']'
                points = 57;
            case '}'
                points = 1197;
            case '>'
                points = 25137;
            end
        end
        lineScore = points;
        loopNum = loopNum + 1;
        %disp(loopNum)
        %disp(length(line_test))
        %disp(line_test)
        %pause(2)
        
        % check number of openers vs closers
        line_test2 = zeros(1, length(line_test));
        for i = 1:length(line_test)
            line_test2(strfind(line_test, '(')) = 1;
            line_test2(strfind(line_test, '[')) = 1;
            line_test2(strfind(line_test, '{')) = 1;
            line_test2(strfind(line_test, '<')) = 1;
            line_test2(strfind(line_test, ')')) = 2;
            line_test2(strfind(line_test, ']')) = 2;
            line_test2(strfind(line_test, '}')) = 2;
            line_test2(strfind(line_test, '>')) = 2;
        end
        if sum(line_test2==2)==0
            corrupt = 2;
            %disp('Incomplete Sequence')
        end
        % this part is falsely triggering and preventing completion of corruption check
        %if line_test(end)=='(' || line_test(end)=='[' || line_test(end)=='{' || line_test(end)=='<'
        %    disp('Incomplete sequence')
        %    break
        %end
    end
    if corrupt == 2
        errorText = ' - Incomplete Sequence.';
    elseif corrupt == 1
        errorText = [' - Expected ' expected ', but found ' incorrectChar ' instead.'];
    end
    disp([line_test_original, errorText])
    
    end % end of function