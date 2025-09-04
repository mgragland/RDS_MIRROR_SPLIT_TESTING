function design = Update_design_by_SetUp_Info(SetUp_Info, design)


SetUp_Info.Text_FontName = design.Text_FontName;
SetUp_Info.Text_FontSize = design.Text_FontSize;
Screen('TextSize', SetUp_Info.Window_ID, design.Text_FontSize);

%%%%%%%%%%%%%%%%% based on the width and height of the window in terms of pixels, set the sizes and locations of items 

Window_Width = RectWidth(SetUp_Info.Window_rectangle);
Window_Height = RectHeight(SetUp_Info.Window_rectangle);

design.Depth_Magnitudes_in_Pixel = round(design.Depth_Magnitudes_in_Scale*Window_Width);
design.Dot_Radiuses_in_Pixel = round(design.Dot_Radiuses_in_Scale*Window_Width);
design.Disk_Radiuses_in_Pixel = round(design.Disk_Radiuses_in_Scale*Window_Width);
design.Ring_InnerRadiuses_in_Pixel = round(design.Ring_InnerRadiuses_in_Scale*Window_Width);
design.Ring_OuterRadiuses_in_Pixel = round(design.Ring_OuterRadiuses_in_Scale*Window_Width);
design.FixationCross_Size_in_Pixel = round(design.FixationCross_Size_in_Scale*Window_Width);
if mod(design.FixationCross_Size_in_Pixel, 2) ==1
	design.FixationCross_Size_in_Pixel = design.FixationCross_Size_in_Pixel +1;
end

design.vergenceFrameRect_LineWidth_in_Pixel = round(design.vergenceFrameRect_LineWidth_in_Scale*Window_Width);
design.Fixation_window_radius_in_Pixel = design.Fixation_window_radius_in_Scale*Window_Width;

design.Reference_Display_location_xy_in_Pixel(1) =  round(design.Reference_Display_location_xy_in_Scale(1)*Window_Width);
design.Reference_Display_location_xy_in_Pixel(2) =  round(design.Reference_Display_location_xy_in_Scale(2)*Window_Height);



%%--- main and secondary fixation locations,  
%%%%----design.Fixation_center_xy_in_Pixel(a, b, c), a= main or secondary, b = b-th fixation location, c = 1, or 2 for x or y pixels
design.Fixation_center_xy_in_Pixel= zeros(size(design.Fixation_center_xy_in_Scale));
design.Fixation_center_xy_in_Pixel(:, :, 1) = ...
    round(design.Fixation_center_xy_in_Scale(:, :, 1)*Window_Width+ design.Reference_Display_location_xy_in_Pixel(1));
design.Fixation_center_xy_in_Pixel(:, :, 2) = ...
    round(design.Fixation_center_xy_in_Scale(:, :, 2)*Window_Width+ design.Reference_Display_location_xy_in_Pixel(2));


design.Stimulus_center_xy_in_Pixel= zeros(size(design.Stimulus_center_xy_in_Scale));
design.Stimulus_center_xy_in_Pixel(:, 1) = ...
    round(design.Stimulus_center_xy_in_Scale(:, 1)*Window_Width +design.Reference_Display_location_xy_in_Pixel(1));
design.Stimulus_center_xy_in_Pixel(:, 2) = ...
    round(design.Stimulus_center_xy_in_Scale(:, 2)*Window_Width +design.Reference_Display_location_xy_in_Pixel(2));

%%-----------------
design.x_stimulus_width_in_Pixel = 2*design.Ring_OuterRadiuses_in_Pixel;
design.x_stimulus_height_in_Pixel = 2*design.Ring_OuterRadiuses_in_Pixel;
%%----
design.vergenceFrameRect_Height_in_Pixel = round(design.scale_factor_fromRingToBox* design.x_stimulus_height_in_Pixel); 
design.vergenceFrameRect_Width_in_Pixel =  round(design.scale_factor_fromRingToBox * design.x_stimulus_width_in_Pixel);

%%%%%%%%%%%--- make it even
if mod(design.vergenceFrameRect_Height_in_Pixel, 2) ==1
        design.vergenceFrameRect_Height_in_Pixel = design.vergenceFrameRect_Height_in_Pixel+1; 
end
%%--- make it even
if mod(design.vergenceFrameRect_Width_in_Pixel, 2) ==1
        design.vergenceFrameRect_Width_in_Pixel = design.vergenceFrameRect_Width_in_Pixel+1; 
end

%==== add xy_in_Pixel to each
for n = 1:3
	if n ==1
		Prompt = design.TrialStartPrompt;
	elseif n==2 
		Prompt = design.TrialResponsePrompt;
	else
		Prompt = design.WrongButtonPrompt;
	end
	n_txt = length(Prompt);
    	for t = 1:n_txt
        	Prompt{t}.xy_in_Pixel(1) = round(Prompt{t}.xy_in_Scale(1)*Window_Width);
        	Prompt{t}.xy_in_Pixel(2) = round(Prompt{t}.xy_in_Scale(2)*Window_Width);
    	end
	if n ==1
                design.TrialStartPrompt = Prompt;
        elseif n==2
                design.TrialResponsePrompt = Prompt;
        else
                design.WrongButtonPrompt= Prompt;
        end
end 




%%%%%%%%%%%%%%%%% Now all the sizes and locations of items are determined in terms of pixels, proceed to other design characters
%


%%--- hence, each condition is defined by (1) disk center location, (2) dots matched or reversed, (3) RDS_frame duration (static or dynamic), 
%%--- for each condition, the depth order can be in front or behind: (4) disk in front or behind.


design.NConditions = design.N_RDS_locations * design.N_RDS_coherence * design.N_frameDuration;




%--- 

[Conditions, NTrialsEachCondition_Testing, NTrialsEachCondition_Practice] = Get_Conditions_and_NTrials_ForThe2024Codes(design);

design.Conditions = Conditions;
design.NTrialsEachCondition_Testing = NTrialsEachCondition_Testing;
design.NTrialsEachCondition_Practice=NTrialsEachCondition_Practice;

NConditions = length(Conditions);
%
for practice_or_test = 1:2
        if practice_or_test==1
                NTrialsEachCondition = design.NTrialsEachCondition_Practice;
        else
                NTrialsEachCondition = design.NTrialsEachCondition_Testing;
        end
        [condition_index_list, FrontOrBack_list] = Get_TwoSequences(NConditions, NTrialsEachCondition);
        NTrials = length(condition_index_list);
        for i = 1:NTrials
                TrialSequence(i).condition_index = condition_index_list(i);
                TrialSequence(i).FrontOrBack = FrontOrBack_list(i);
        end
        if practice_or_test==1
                design.Practice_TrialSequence = TrialSequence;
        else
                design.Testing_TrialSequence = TrialSequence;
        end
end


if design.Give_PracticeTrials_Or_Not==0
	 design.Practice_TrialSequence =[];
end



if strcmp(design.Text_Color_by_Label, 'Black')==1 | strcmp(design.Text_Color_by_Label, 'black')==1 
	design.Text_Color = SetUp_Info.BlackColor;
else 
	design.Text_Color = SetUp_Info.WhiteColor;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Now make the fixation cross

if strcmp(design.FixationCross_Color_by_Label, 'Black')==1 | strcmp(design.FixationCross_Color_by_Label, 'black')==1 
	design.FixationCross_Color = SetUp_Info.BlackColor;
else 
	design.FixationCross_Color = SetUp_Info.WhiteColor;
end

%%--- fixation cross color 
design.FixationCrossRGB = [1, 0, 0];   
if ismember(SetUp_Info.StereoMode, [6 7 8 9])
%%--- make fixation cross black in anaglyph mode
        design.FixationCrossRGB = design.FixationCross_Color*[1 1 1]; 
end

%---- make the Fixation Cross matrix
FixationCross_Size = design.FixationCross_Size_in_Pixel;

FixationCross_Matrix = zeros(FixationCross_Size, FixationCross_Size);
%--- make the thickness of the cross bar as 20% of the whole FixationCross_Size
half_bar_width = round(0.2*FixationCross_Size/2);
if half_bar_width ==0
 	half_bar_width =1;
end
x1 = FixationCross_Size/2-(half_bar_width-1); 
x2 = FixationCross_Size/2+1+(half_bar_width-1); 
FixationCross_Matrix(x1:x2, :) =  ones(2*half_bar_width, FixationCross_Size);
FixationCross_Matrix(:, x1:x2) =  ones(FixationCross_Size, 2*half_bar_width);
%--- now FixationCross_Matrix is a white cross on a black background
%
FixationCross_Matrix3D = zeros(3, size(FixationCross_Matrix, 1), size(FixationCross_Matrix, 2));
for item = 1:3
        FixationCross_Matrix3D(item, :, :) = ...
		(design.FixationCrossRGB(item)-SetUp_Info.GrayColor)*FixationCross_Matrix + ...
		      SetUp_Info.GrayColor*ones(FixationCross_Size, FixationCross_Size);
end
design.FixationCross_Matrix3D = FixationCross_Matrix3D;
