function design = Set_More_Flexible_Parameters_for_design(design, use_default_or_review)


num_lines = 1;
%--- initialize
Exp_prompt = [];
Exp_default_answer = [];
entry_count = 0;

%-----------enter 1 or 0 for design.Give_PracticeTrials_Or_Not,  whether practice trials are included, if 0 is given, the entries in the following 4 rows are ignored
%----- this is for 
entry_count = entry_count +1;
txt.prompt= 'enter 1 or 0 for whether practice trials are included, if 0 is given, the number of practice trials entered below are ignored';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
DoPracticeTrials_index = entry_count;

%----- this is for design.PracticeTrial_Mean_and_Min_Accuracy_Thresholds 
entry_count = entry_count +1;
txt.prompt= 'enter 2 numbers (1) minimum of the mean accuracies of the practice trials, (2) minimum of each accuracies of the practice trials';
txt.default_answer= '0.9, 0.8';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
PracticeTrials_ThresholdAccuracy_index = entry_count;

%--- enter 1 or 0,  for (1) design.GazeTracking_Or_Not and (2) design.GazeContingent_Or_Not, for whether there is gaze is tracked, and gaze contingency is required for starting a trial
entry_count = entry_count +1;
txt.prompt= 'enter 1 or 0 for whether to give instructions';
txt.default_answer= '0';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
GiveInstructionOrNot_index = entry_count;

%--- enter 1 or 0,  for (1) design.GazeTracking_Or_Not and (2) design.GazeContingent_Or_Not, for whether there is gaze is tracked, and gaze contingency is required for starting a trial
entry_count = entry_count +1;
txt.prompt= 'enter 1 or 0 for whether or not gaze is tracked';
txt.default_answer= '0';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
GazeTracking_index = entry_count;

entry_count = entry_count +1;
txt.prompt= 'enter 1 or 0 for whether or not gaze contingency is required for starting a trial';
txt.default_answer= '0';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
GazeContingency_index = entry_count;



%---- Fixation window size,  for design.Fixation_window_radius_in_Scale
entry_count = entry_count +1;
txt.prompt= 'Enter one number, design.Fixation_window_radius_in_Scale, as the size of the fixation window (for gaze contingency) as a fraction of the window width';
txt.default_answer= '0.1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
FixationWindow_index = entry_count;

%--- number of practice trials of static/dynamic RDS in correlated conditions, design.N_PracticeTrials_Each_Coherence_FrameDuration_Location(1, :, :),  when RDS is at left, center, and right location
entry_count = entry_count +1;
txt.prompt= 'number of practice trials of (1) static and (2) dynamic RDS in correlated conditions, when RDS is at left, center, and right location';
txt.default_answer= '[0, 0, 0]; [10,10,0]';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
NPracticeTrials_index1 = entry_count;

%--- number of practice trials of static/dynamic RDS in anti-correlated conditions,  design.N_PracticeTrials_Each_Coherence_FrameDuration_Location(2, :, :), when RDS is at left, center, and right location
entry_count = entry_count +1;
txt.prompt= 'number of practice trials of (1) static and (2) dynamic RDS in anti correlated conditions, when RDS is at left, center, and right location';
txt.default_answer= '[0, 0, 0]; [0, 0, 0]';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
NPracticeTrials_index2 = entry_count;

%--- number of testing trials of static/dynamic RDS in correlated conditions, design.N_TestingTrials_Each_Coherence_FrameDuration_Location(1, :, :),  when RDS is at left, center, and right location
entry_count = entry_count +1;
txt.prompt= 'number of testing trials of (1) static and (2) dynamic RDS in correlated conditions, when RDS is at left, center, and right location';
txt.default_answer= '[0, 0, 0]; [50, 50, 0]';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
NTestingTrials_index1 = entry_count;

%--- number of testing trials of static/dynamic RDS in anticorrelated conditions, design.N_TestingTrials_Each_Coherence_FrameDuration_Location(2, :, :),  when RDS is at left, center, and right location
entry_count = entry_count +1;
txt.prompt= 'number of testing trials of (1) static and (2) dynamic RDS in anticorrelated conditions, when RDS is at left, center, and right location';
txt.default_answer= '[0, 0, 0]; [50, 50, 0]';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
NTestingTrials_index2 = entry_count;

%%%%%%%%%%%%%%%%%%%
entry_count = entry_count +1;
txt.prompt= 'messages before the practice trials, {Sentence 1},  {x1, y2},  {Sentence 2}, {x2, y2},... x/y are sentence locations on screen as fraction of width/height';
txt.default_answer= '{Next are the practice trials}, {0.1, 0.1}, {they are non-noisy trials, just to familiarize you with the procedure}, {0.1, 0.2}, {Enter RightArrow to proceed}, {0.1, 0.8}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Pre_PracticeMessage_index = entry_count;



%%%%%%%%%%%%%%%%%%%
entry_count = entry_count +1;
txt.prompt= 'message before the testing trials, {Sentence 1}, {x1, y2},  {Sentence 2}, {x2, y2},... x/y are sentence locations on screen as fraction of width/height';
txt.default_answer= '{Next we do the testing trials}, {0.1, 0.1}, {some of them are noisy and difficult, remember to try your best}, {0.1, 0.3}, {Enter RightArrow to proceed}, {0.1, 0.8}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Pre_TestingMessage_index = entry_count;

%%%%%%%%%%%%%%%%%%%
entry_count = entry_count +1;
txt.prompt= 'enter color, white or black,{color1}, {color2},  for (1) the text messages, and (2) the color of the fixation cross,';
txt.default_answer= '{black}, {black}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Text_and_FixationCross_Colors_index = entry_count;



Exp_dialog_title_2='Experimental design values that might be adjustable occasionally (with caution)';

if use_default_or_review ~=1
	Exp_info_2=inputdlg(Exp_prompt,Exp_dialog_title_2, [1, 150],Exp_default_answer);
else
        Exp_info_2= Exp_default_answer;
end


%%%%%%%%%%%%%%%%%%% now put these information into design
%-----------
design.Give_PracticeTrials_Or_Not = str2num(Exp_info_2{DoPracticeTrials_index});

temlist  = str2num(Exp_info_2{PracticeTrials_ThresholdAccuracy_index});
design.Minimum_meanAccuracy_PracticeTrials  = temlist(1);
design.Minimum_eachAccuracy_PracticeTrials  = temlist(2);

design.Give_Instructions_Or_Not = str2num(Exp_info_2{GiveInstructionOrNot_index});
%-----------
design.GazeTracking_Or_Not=str2num(Exp_info_2{GazeTracking_index});
design.GazeContingent_Or_Not= str2num(Exp_info_2{GazeContingency_index});

%---
design.Fixation_window_radius_in_Scale = str2num(Exp_info_2{FixationWindow_index});
%
design.N_PracticeTrials_Each_Coherence_FrameDuration_Location = zeros(design.N_RDS_coherence, design.N_frameDuration, design.N_RDS_locations);
design.N_TestingTrials_Each_Coherence_FrameDuration_Location = zeros(design.N_RDS_coherence, design.N_frameDuration, design.N_RDS_locations);
%--- number of practice trials of static/dynamic RDS in correlated conditions, design.N_PracticeTrials_EachCondition(1, :, :),  when RDS is at left, center, and right location
design.N_PracticeTrials_Each_Coherence_FrameDuration_Location(1, :, :) = String_to_Array(Exp_info_2{NPracticeTrials_index1});
design.N_PracticeTrials_Each_Coherence_FrameDuration_Location(2, :, :) = String_to_Array(Exp_info_2{NPracticeTrials_index2});
design.N_TestingTrials_Each_Coherence_FrameDuration_Location(1, :, :) = String_to_Array(Exp_info_2{NTestingTrials_index1});
design.N_TestingTrials_Each_Coherence_FrameDuration_Location(2, :, :) = String_to_Array(Exp_info_2{NTestingTrials_index2});



Messages{1} = String_to_Stringlist(Exp_info_2{Pre_PracticeMessage_index});
Messages{2}= String_to_Stringlist(Exp_info_2{Pre_TestingMessage_index});
for practice_or_test = 1:2
	temlist = Messages{practice_or_test};
	clear Instruction;
	N = length(temlist)/2;
	for i = 1:N
		Instruction(i).txt = temlist{(i-1)*2+1};
		Instruction(i).xy = str2num(temlist{(i-1)*2+2});
	end
		Instruction(N+1).txt  = 'Remember, in each trial, keep your gaze on the central cross to start the trial,';	
		Instruction(N+1).xy = [0.1, 0.5];
		Instruction(N+2).txt  = 'and keep this fixation till the stereograms disappear';	
		Instruction(N+2).xy = [0.2, 0.55];
	if design.GazeContingent_Or_Not ==1
		Instruction(N+3).txt  = 'the stereogram will not appear until your fixation is verified by the eye tracker';
		Instruction(N+3).xy = [0.1, 0.60];
	end
	if practice_or_test ==1
		design.Message_BeforePracticeTrials = Instruction;
	else
		design.Message_BeforeTestingTrials = Instruction;
	end
end

temlist = String_to_Stringlist(Exp_info_2{Text_and_FixationCross_Colors_index});
if strcmp(temlist{1}, 'black') ==0 & strcmp(temlist{1}, 'Black') ==0 & strcmp(temlist{1}, 'white') ==0   & strcmp(temlist{1}, 'White') ==0 ...
& strcmp(temlist{2}, 'black') ==0 & strcmp(temlist{2}, 'Black') ==0 & strcmp(temlist{2}, 'white') ==0   & strcmp(temlist{2}, 'White') ==0
	error('color choices for text and fixation cross can only be black or white, nothing else');
end
design.Text_Color_by_Label = temlist{1};
design.FixationCross_Color_by_Label = temlist{2};

