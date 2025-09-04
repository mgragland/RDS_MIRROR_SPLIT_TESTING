function design = Start_Experimental_design(use_default_or_review)

design = [];

num_lines = 1;
%--- initialize
Exp_prompt = [];
Exp_default_answer = [];
entry_count = 0;


%--- information entries
%--- for design.Prob_DiskDotIsSameAcrossEyes
entry_count = entry_count +1;
txt.prompt= '[p1], {label1}; [p2], {label2}, ..., n Probability values, and their stimulus labels, for binocular match, for n (e.g., n = 2) RDS coherence conditions';
txt.default_answer= '[1], {matched};  [0], {reversed}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Prob_BinocularMatch_index = entry_count;

%--- for the percentage of areas covered by dots.
entry_count = entry_count +1;
txt.prompt= 'density of dots ';
txt.default_answer= '0.25';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Dot_Density_index = entry_count;

%---- for design.Reference_Display_location_xy_in_Scale, Reference_Location reference display location x, y, as a fraction of the window width/height
entry_count = entry_count +1;
txt.prompt= 'x, y of the reference display location (e.g., display center), as a fraction of the window width/height';
txt.default_answer= '[0.5, 0.5]';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
DisplayReference_xy_in_Scale_index = entry_count;


%---- Information about Sizes of the stimuli, in design.Depth_Magnitudes_in_Scale, design.Dot_Radiuses_in_Scale, design.Disk_Radiuses_in_Scale, design.Ring_InnerRadiuses_in_Scale, design.Ring_OuterRadiuses_in_Scale, design.FixationCross_Size_in_Scale,
entry_count = entry_count +1;
txt.prompt= 'magnitude of the depth step, dot radius, disk radius, ring inner radius, outer radius, size of the fixation cross, as fractions of window width'; 
txt.default_answer= '0.002, 0.002, 0.083, 0.085, 0.108, 0.010';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Size_info_index = entry_count;


%---- Information about Stimulus locations, for design.Stimulus_center_xy_in_Scale 
entry_count = entry_count +1;
txt.prompt='[x1, y1], {label1}; [x2, y2], {label2}; [x3, y3],{label3}  of n (=3, e.g.) deviation of the n stimulus center locations from the reference display location (e.g., display center), as fractions of the window width';
% txt.default_answer= '[-0.1769, 0], {left}; [0, 0.0964], {middle}; [0.1769,0], {right}'; %see dva calculation for FLAP 
% txt.default_answer= '[-0.1421, -0.1007], {left}; [0, 0.0964], {middle}; [0.1421,-0.1007], {right}'; %out of blind spot 
txt.default_answer= '[0, 0.0964], {inferior}; [0, 0.0964], {central}; [0, 0.0964], {inferior}'; %lower visual field for peripheral 
% txt.default_answer= '[-0.198, 0], {left}; [0, 0.0965], {middle}; [0.198,0], {right}'; %Zhaoping Default 
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
StimulusLocation_info_index = entry_count;


%--- Information about main Fixation Locations, for design.Fixation_center_xy_in_Scale(1, :, :) 
entry_count = entry_count +1;
txt.prompt='[x1, y1]; [x2, y2]; [x3, y3]; ... deviations of the main fixation center locations from the reference display location (e.g., display center), one for each stimulus center, as a fraction of the window width';
% txt.default_answer='[0, 0]; [0, 0]; [0, 0]'; % Default 
txt.default_answer='[0, -0.1748]; [0, 0]; [0, -0.1748]';  %lower visual field for peripheral 
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
mainFixationLocation_info_index = entry_count;

%--- Information about secondary Fixation Locations, for design.Fixation_center_xy_in_Scale(2, :, :) 
entry_count = entry_count +1;
txt.prompt='like above, but for secondary fixation centers, one for each stimulus center above';
% txt.default_answer= '[0,0]; [0, 0]; [0,0]'; %out of blind spot 
%txt.default_answer='[-0.1769, -0.0964]; [0, 0]; [0.1769, -0.0964]';
txt.default_answer= '[0, -0.1748]; [0, 0]; [0, -0.1748]'; %lower visual field for peripheral 
%txt.default_answer='[-0.198, -0.0965]; [0, 0]; [0.198, -0.0965]'; % Zhaoping Default
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
secondaryFixationLocation_info_index = entry_count;


%----- Information about CentralOrPeripheral of the stimulus locations, for design.Stimulus_CentralOrPeripheral
entry_count = entry_count +1;
txt.prompt= 'n numbers, 1 or 2, each for whether the disk center above is for central or peripheral inputs';
txt.default_answer='2, 1, 2';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
CentralOrPeripheral_info_index = entry_count;


%----- Information for design.Add_UnPaired_Dots and  design.Add_FixationCross 
entry_count = entry_count +1;
txt.prompt= 'Three numbers, each 1 or 0,  1st one: whether to add unpaired monocular dots, 2nd one: whether to add fixation cross to stereograms, 3rd one: whether to add mask';
txt.default_answer='0, 1, 1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
AddMonocularFixationMask_info_index = entry_count;

%----- Information for design.vergenceFrameRect_LineWidth_in_Scale and design.scale_factor_fromRingToBox
entry_count = entry_count +1;
txt.prompt= 'for vergence anchoring frame, (1) scale factor for its line width relative to window width, (2)  its size as a scale relative to the diameter of the outer ring';
% txt.default_answer='0.007, 1.3';
txt.default_answer='0.007, 1.15';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
VergenceAnchoringFrame_info_index = entry_count;


%----- Information for durations, for design.FixationPeriod_in_Second, design.stimulus_duration_in_Second
entry_count = entry_count +1;
txt.prompt= '2 numbers: durations in second of (1) fixation duration, (2) test stimulus total duration in each trial';
txt.default_answer='0.7, 1.5';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Durations_info_index = entry_count;

%----- Information for durations, for design.RDS_frame_durations_in_Second 
entry_count = entry_count +1;
txt.prompt= '[duration1], {label1}; [duration2], {label2}; ...2xm numbers: duration (second) of each frame, and stimulus label, in each of m temporal types of RDS';
txt.default_answer='[1.5], {static}; [0.1], {dynamic}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
FrameDurations_info_index = entry_count;

%----- Information for font name and size,  for design.Text_FontName, design.Text_FontSize
entry_count = entry_count +1;
txt.prompt= '{font name for text}, {font size for fonts}';
txt.default_answer='{Cambria}, {18}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
TextFont_info_index = entry_count;


%----- Information for the prompt to start a trial, for design.TrialStartPrompt{1/2}.txt
entry_count = entry_count +1;
txt.prompt= 'prompt to start a trial, displayed as two text strings near each other';
txt.default_answer='{Press any button},  {for the next trial}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
TrialStartPrompt_Txt_info_index = entry_count;

%----- Information for the location of the prompt to start a trial, for design.TrialStartPrompt{1/2}.xy_in_Scale
entry_count = entry_count +1;
txt.prompt= '[x1, y1]; [x2, y2] for the x-y shifts of each string of the prompt above, relative to the main fixation center, as fractions of the window width';
txt.default_answer='[-0.11, 0]; [0.01, 0]';
% txt.default_answer='[-0.15, 0.15]; [0.03, 0.15]'; %test out of blind spot 
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
TrialStartPrompt_xy_info_index = entry_count;


%----- Information for the prompt to give task response, for design.TrialResponsePrompt{1/2}.txt
entry_count = entry_count +1;
txt.prompt= 'prompt to give task response, displayed as two text strings near each other';
txt.default_answer='{Please report},  {disk near or far }';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
TrialResponsePrompt_Txt_info_index = entry_count;

%----- Information for the location of the prompt to start a trial, for design.TrialResponsePrompt{1/2}.xy_in_Scale
entry_count = entry_count +1;
txt.prompt= '[x1, y1]; [x2, y2] for the x-y shifts of each string of the prompt above, relative to the main fixation center, as fractions of the window width';
txt.default_answer='[-0.11, 0]; [0.01, 0]';
% txt.default_answer='[-0.15, 0.15]; [0.03, 0.15]'; % test for blind spot 

Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
TrialResponsePrompt_xy_info_index = entry_count;


%----- Information for the prompt after an invalid button response,  for design.WrongButtonPrompt{1/2}.txt
entry_count = entry_count +1;
txt.prompt= 'prompt to give task response, displayed as two text strings near each other';
txt.default_answer='{Invalid button,},  { Try again}';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
WrongButtonPrompt_Txt_info_index = entry_count;

%----- Information for the location of the prompt after an invalid button response, for design.WrongButtonPrompt{1/2}.xy_in_Scale
entry_count = entry_count +1;
txt.prompt= '[x1, y1]; [x2, y2] for the x-y shifts of each string of the prompt above, relative to the main fixation center, as fractions of the window width';
txt.default_answer='[-0.15, -0.17]; [0.03, -0.17]';
% txt.default_answer='[-0.15, 0.17]; [0.03, 0.17]'; %  test for blind spot 

Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
WrongButtonPrompt_xy_info_index = entry_count;

Exp_dialog_title_1='Set experimental design values that should rarely change';

if use_default_or_review ~=1
	Exp_info_1=inputdlg(Exp_prompt,Exp_dialog_title_1, [1, 150],Exp_default_answer);
else
	Exp_info_1= Exp_default_answer;
end

%%%%%%%%%%%%%%%%%%%%% Now record down the values in design
[design.Prob_DiskDotIsSameAcrossEyes, design.Prob_DiskDotIsSameAcrossEyes_by_Label] = String_to_ArrayAndLabels(Exp_info_1{Prob_BinocularMatch_index});
%
design.Dot_Density = str2num(Exp_info_1{Dot_Density_index});


design.Reference_Display_location_xy_in_Scale = str2num(Exp_info_1{DisplayReference_xy_in_Scale_index});
%---------------------sizes of the stimulus ---------------------------
temlist =  str2num(Exp_info_1{Size_info_index});
design.Depth_Magnitudes_in_Scale = temlist(1);
design.Dot_Radiuses_in_Scale = temlist(2);
design.Disk_Radiuses_in_Scale=temlist(3);
design.Ring_InnerRadiuses_in_Scale = temlist(4);
design.Ring_OuterRadiuses_in_Scale = temlist(5);
design.FixationCross_Size_in_Scale = temlist(6);
%---------------------stimulus locations---------------------------
[design.Stimulus_center_xy_in_Scale, design.Stimulus_center_xy_by_Label] = String_to_ArrayAndLabels(Exp_info_1{StimulusLocation_info_index});
N1 = size(design.Stimulus_center_xy_in_Scale, 1);
N2 = size(design.Stimulus_center_xy_in_Scale, 2);
%
design.Fixation_center_xy_in_Scale = zeros(2, N1, N2);
%--------------------main fixation locations----------------------------
design.Fixation_center_xy_in_Scale(1, :, :) = String_to_Array(Exp_info_1{mainFixationLocation_info_index});
%--------------------secondary fixation locations----------------------------
design.Fixation_center_xy_in_Scale(2, :, :) = String_to_Array(Exp_info_1{secondaryFixationLocation_info_index});
%----  1, or 2, for each of the stimulus locations, whehter it is for central or peripheral vision
design.Stimulus_CentralOrPeripheral = str2num(Exp_info_1{CentralOrPeripheral_info_index});
%--- 1 or 2, --- for each number
temlist  = str2num(Exp_info_1{AddMonocularFixationMask_info_index});
design.Add_UnPaired_Dots  = temlist(1); 
design.Add_FixationCross  = temlist(2);
design.Add_Mask = temlist(3);
%------------------------------------------
temlist  = str2num(Exp_info_1{VergenceAnchoringFrame_info_index});
design.vergenceFrameRect_LineWidth_in_Scale = temlist(1);
design.scale_factor_fromRingToBox = temlist(2);
%----- Information for durations, for design.FixationPeriod_in_Second, design.stimulus_duration_in_Second, design.RDS_frame_durations_in_Second 
temlist = str2num(Exp_info_1{Durations_info_index});
design.FixationPeriod_in_Second = temlist(1);
design.stimulus_duration_in_Second = temlist(2);

[design.RDS_frame_durations_in_Second, design.RDS_frame_durations_by_Label] = String_to_ArrayAndLabels(Exp_info_1{FrameDurations_info_index});
%
%----- Information for font name and size,  for design.Text_FontName, design.Text_FontSize
Stringlist = String_to_Stringlist(Exp_info_1{TextFont_info_index});
design.Text_FontName = Stringlist{1};
design.Text_FontSize = str2num(Stringlist{2});

%%%%%%%%%%%%%%%%%%%% for the three text prompts --------------------------------------
Used_indices = [TrialStartPrompt_Txt_info_index, TrialStartPrompt_xy_info_index; ...
		TrialResponsePrompt_Txt_info_index, TrialResponsePrompt_xy_info_index; ...
		WrongButtonPrompt_Txt_info_index, WrongButtonPrompt_xy_info_index];
for n = 1:3
        for txt_or_location = 1:2
                if txt_or_location ==1
                        Stringlist = String_to_Stringlist(Exp_info_1{Used_indices(n, 1)});
                        Prompt{1}.txt =Stringlist{1};
                        Prompt{2}.txt =Stringlist{2};
                else
                        temlist = String_to_Array(Exp_info_1{Used_indices(n, 2)});
                        Prompt{1}.xy_in_Scale = temlist(1,:);
                        Prompt{2}.xy_in_Scale = temlist(2,:);
                        Prompt{1}.Text_FontName = design.Text_FontName;
                        Prompt{2}.Text_FontName = design.Text_FontName;
                        Prompt{1}.Text_FontSize = design.Text_FontSize;
                        Prompt{2}.Text_FontSize = design.Text_FontSize;
                end
        end
        if n==1
                design.TrialStartPrompt = Prompt;
        elseif n==2
                design.TrialResponsePrompt = Prompt;
        elseif n==3
                design.WrongButtonPrompt = Prompt;
        end
end




