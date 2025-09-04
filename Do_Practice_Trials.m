function  Practice_Trial_Data = Do_Practice_Trials(design, SetUp_Info, Practice_Trial_Data,  practice_or_test)

This_TrialSequence = design.Practice_TrialSequence;
%--- remind or clarify the task again if there was no instruction or no practice trials
txt_add = sprintf('. *** In each trial, press %s to report disk in front, and press %s to report disk behind', ...
    design.Response_Buttons.keyName{1}, design.Response_Buttons.keyName{2});
design.Message_BeforePracticeTrials(1).txt = [design.Message_BeforePracticeTrials(1).txt, txt_add];
%
Do_AnotherRound = 1;
while Do_AnotherRound ==1
    Do_AnotherRound = 0;
    %--- do the practice and testing trials
    Prompt_Messages_to_Screen(design, SetUp_Info, design.Message_BeforePracticeTrials);
    Wait_For_RightArrowKey;
    Trial_Data = Do_TrialSequence(This_TrialSequence, design, SetUp_Info, practice_or_test);
    [Trial_Accuracies, N_Trials]  = Plot_Accuracies_Inferior(Trial_Data, design, SetUp_Info.Debug_Or_Whole_Screen);
    
    
    Practice_Trial_Data =[Practice_Trial_Data, Trial_Data];
    
    %%%%%%%%%%%%%% Check performance and decide whether to repeat or proceed
    %--- see if the accuracies are sufficient to proceed
    Valid_Accuracies = Trial_Accuracies(find(isnan(Trial_Accuracies)==0));
    
    clear Instruction;
    Instruction(1).txt= sprintf('Average and minimum accuracies of the practice trials are %f and %f', mean(Valid_Accuracies), min(Valid_Accuracies));
    Instruction(1).xy = [0.1, 0.1];
    if mean(Valid_Accuracies) < design.Minimum_meanAccuracy_PracticeTrials | min(Valid_Accuracies) < design.Minimum_eachAccuracy_PracticeTrials
        Instruction(2).txt = sprintf('Average and/or minimum accuracies of the practice trials less than the thresholds  %f and %f required',  ...
            design.Minimum_meanAccuracy_PracticeTrials, design.Minimum_eachAccuracy_PracticeTrials);
        Instruction(2).xy = [0.1, 0.2];
        Do_AnotherRound  = 1;
        Instruction(3).txt = 'enter LeftArrow to do another round of practice trials, or enter RightArrow to proceed to test trials regardless';
        Instruction(3).xy = [0.1, 0.5];
        Instruction(4).txt = '';
        Instruction(4).xy = [0.1, 0.7];
    else
        Instruction(2).txt = 'enter RightArrow to proceed to test trials';
        Instruction(2).xy = [0.1, 0.5];
        Instruction(3).txt = '';
        Instruction(3).xy = [0.1, 0.7];
    end
    Prompt_Messages_to_Screen(design, SetUp_Info,  Instruction);
    if Do_AnotherRound  == 1
        GoForward_Or_Backward = Wait_For_RightOrLeftArrowKey(design);
        if GoForward_Or_Backward ==1
            Do_AnotherRound  = 0;
        end
    else
        Wait_For_RightArrowKey;
        clear Instruction;
        Instruction(1).txt= 'You have done a great job!! Now, you are ready for the task. Please be confident enough and trust your intuition'
        Instruction(1).xy = [0.2, 0.35];
        Prompt_Messages_to_Screen(design, SetUp_Info,  Instruction);
        Wait_For_RightArrowKey;
    end
    if Do_AnotherRound==1
        N = length(This_TrialSequence);
        temlist = randperm(N); %--- randomly re-shuffle the order of the practice trials to do another round of practice trials
        This_TrialSequence = This_TrialSequence(temlist);
    end
end

