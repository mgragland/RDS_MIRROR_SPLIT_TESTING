function Give_OpeningMessage(design, SetUp_Info)


    Opening_Message(1).txt = 'Thank you for participating in this epxeriment';
    Opening_Message(1).xy = [0.1, 0.1];
    Opening_Message(2).txt = 'we start with a depth screening, to check that you can see stereo depth';
    Opening_Message(2).xy = [0.1, 0.3];
    count =2;

    if design.Give_Instructions_Or_Not ==1
        count = count+1;
        Opening_Message(count).txt = 'Then we give you instructions on how to do the experimental trials in this experimental session';
        Opening_Message(count).xy = [0.1, 0.5];
    end
    if length(design.Practice_TrialSequence) >0 %--- check if there is any practice trials
        count = count+1;
        Opening_Message(count).txt = sprintf('Then we give you %d (or more) practice trials to get you familiar with the procedure', ...
						 length(design.Practice_TrialSequence));
        Opening_Message(count).xy = [0.1, 0.6];
    end
    count = count+1;
    Opening_Message(count).txt = sprintf('Then we give you %d real testing trials',  length(design.Testing_TrialSequence));
    Opening_Message(count).xy = [0.1, 0.7];

    count = count+1;
    Opening_Message(count).txt = 'Ente RightArrow Key to proceed';
    Opening_Message(count).xy = [0.1, 0.9];

    Prompt_Messages_to_Screen(design, SetUp_Info, Opening_Message);
    Wait_For_RightArrowKey;

