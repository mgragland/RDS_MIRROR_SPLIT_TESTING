function   Instruction_Pages_Info = Set_InstructionContent(design)

Page_count = 0;
%------------- tihs page of instruction
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 1;   % static RDS
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = 1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [];
Instruction(1).txt = 'You will see images like this, a disk surface, and a ring surface, each with random dots on it';
Instruction(1).xy = [0.2, 0.3];
Instruction(2).txt = 'Your task is to report whether the disk is in front of, or behind, the surrounding ring';
Instruction(2).xy = [0.2, 0.35];
Instruction(3).txt = 'tell me what you see in this example, is the disk in front of, or behind, the ring?';
Instruction(3).xy = [0.2, 0.4];
Instruction(4).txt = sprintf('During the experiment, for each trial, press %s to report in front, and press %s to report behind', ...
		design.Response_Buttons.keyName{1}, design.Response_Buttons.keyName{2});
Instruction(4).xy = [0.2, 0.45];
%
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;

This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- another page of instruction, modify whatever needs to be modified from the last page
Trial_Character.DepthOrder = -1;
clear Instruction;
Instruction(1).txt = 'Here is an example when the disk is behind the ring, can you see the difference from the previous one?';
Instruction(1).xy = [0.2, 0.35];
%%
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- another page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
RDS_Location_Index = 3;
Instruction(1).txt = 'Sometimes the depth surfaces are displayed at a different location, but your task remains the same';
Instruction(1).xy = [0.2, 0.25];
Instruction(2).txt = 'This example shows the second possible location';
    Instruction(2).xy = [0.2, 0.3];
Instruction(3).txt = 'Do you see how the fixation cross moved?';
    Instruction(3).xy = [0.2, 0.35];
%
Trial_Character.RDS_Location_Index = 3;    %third location

This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;



%--- Another page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Trial_Character.RDS_Location_Index = 3;
Trial_Character.DepthOrder = 1;
Instruction(1).txt = 'Your must move your eyes to the fixation cross';
Instruction(1).xy = [0.2, 0.15];
if design.Add_FixationCross ==1
    Instruction(2).txt = 'Keep your eyes on the fixation cross while doing this task, till the stereograms disappear or your answer will not count';
    Instruction(2).xy = [0.2, 0.2];
    Instruction(3).txt = 'When the disk and ring are far from this cross, it can be difficult, please try your best';
    Instruction(3).xy = [0.2, 0.25];
end
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
% 
 Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%--- Another page of instruction, modify whatever needs to be modified from the last page.
if design.GazeTracking_Or_Not ==1 & design.Add_FixationCross ==1
	clear Instruction;
        Instruction(1).txt = 'Your gaze position is monitored by our eye tracker, ';
        Instruction(1).xy = [0.45, 0.35];
        Instruction(2).txt = 'so if your gaze strayed from the fixation point, the trial is not valid';
        Instruction(2).xy = [0.45, 0.40];
        if design.GazeContingent_Or_Not==1
            Instruction(3).txt = 'the test input will not appear until the tracker verified that you are fixating properly';
            Instruction(3).xy = [0.4, 0.85];
        end
	This_Instruction_Page_Info.Type = 1;
	This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
	This_Instruction_Page_Info.Trial_Character = Trial_Character;

	Page_count = Page_count+1;
	Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
end



% %---- clarify the fixation for each stimulus location
% if design.Add_FixationCross ==1
%     for RDS_location= 1:design.N_RDS_locations
%         This_Instruction_Page_Info.Type = 1;
%         Trial_Character.RDS_Location_Index = RDS_location;
%         Trial_Character.DepthOrder = 1;
%         This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;
%         This_Instruction_Page_Info.Trial_Character = Trial_Character;
% 
%         clear Instruction;
%         if RDS_location==1
%             Instruction(1).txt = sprintf('Hence, there are %d possible RDS locations, this is the 1st example location', ...
% 						design.N_RDS_locations);
%         else
%             Instruction(1).txt = sprintf('here is the %d -th possible RDS location', RDS_location);
%         end
%         Instruction(1).xy = [0.02, 0.05];
%         txt1 = 'You must fixate at this cross ';
%         xy1 = squeeze(design.Fixation_center_xy_in_Scale(1, RDS_location, :));
%         xy2 = squeeze(design.Stimulus_center_xy_in_Scale(RDS_location, :));
%         diff = xy1'-xy2;
%         if sqrt( sum(diff.^2)) < design.Ring_OuterRadiuses_in_Scale
%             Instruction(2).txt = [txt1, ' inside the stereogram (experimenter point to the main fixation location)'];
%         else
%             Instruction(2).txt = [txt1, ' outside the stereogram (experimenter point to the main fixation location)'];
%         end
%         Instruction(2).xy = [0.02, 0.1];
%         if isequal(design.Fixation_center_xy_in_Scale(1, RDS_location, :), design.Fixation_center_xy_in_Scale(2, RDS_location, :)) ~=1
%             txt1= 'Although there is a second fixation cross here';
%             Instruction(3).xy = [0.02, 0.15];
%             xy1 = squeeze(design.Fixation_center_xy_in_Scale(2, RDS_location, :));
%             xy2 = squeeze(design.Stimulus_center_xy_in_Scale(RDS_location, :));
%             diff = xy1'-xy2;
%             if sqrt( sum(diff.^2)) < design.Ring_OuterRadiuses_in_Scale
%                 Instruction(3).txt = [txt1, ' inside the stereogram (experimenter point to the second fixation cross)'];
%             else
%                 Instruction(3).txt = [txt1, ' outside the stereogram (experimenter point to the second fixation cross)'];
%             end
%             Instruction(3).xy = [0.02, 0.15];
%             Instruction(4).txt = 'For the purpose of fixation, you should ignore this second cross';
%             Instruction(4).xy = [0.02, 0.20];
%         end
%         This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
%         Page_count = Page_count+1;
%         Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
%     end
% end

clear Instruction;
if design.GazeTracking_Or_Not ==1
    Instruction(1).txt = 'Let me show you the procedures in an example trial, although there is no eye tracking in this demo';
else
    Instruction(1).txt = 'Let me show you the procedures in an example trial';
end
Instruction(1).xy = [0.2, 0.2];
Instruction(2).txt = sprintf('Reminder: for each trial, press %s to report in front, and press %s to report behind', ...
				design.Response_Buttons.keyName{1}, design.Response_Buttons.keyName{2});
Instruction(2).xy = [0.2, 0.25];
Instruction(3).txt = 'Press RightArrow to proceed';
Instruction(3).xy = [0.2, 0.3];
%
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

% %--- Next page of instruction, modify whatever needs to be modified from the last page.
% clear Instruction;
% Instruction(1).txt = sprintf('Each trial starts with a prompt ---%s %s --- you press a button to start the trial', ...
%                                 design.TrialStartPrompt{1}.txt, design.TrialStartPrompt{2}.txt);
% Instruction(1).xy = [0.1, 0.4];
% Instruction(2).txt = 'This prompt image also includes a box in which the stereogram  will appear, so you can prepare yourself for it';
% Instruction(2).xy = [0.1, 0.45];
% Instruction(3).txt = 'you may take your time to start each trial, and take your time to give response to the trial';
% Instruction(3).xy = [0.1, 0.6];
% % Instruction(4).txt = 'By taking your time  to press a button to start a trial, you could take a short pause/rest before a trial starts';
% % Instruction(4).xy = [0.1, 0.7];
% %
% This_Instruction_Page_Info.Type = 1;
% This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;
% This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
% This_Instruction_Page_Info.Trial_Character = Trial_Character;
% 
% Page_count = Page_count+1;
% Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = sprintf('Each trial starts with a prompt ---%s %s --- you press a button to start the trial', ...
                                design.TrialStartPrompt{1}.txt, design.TrialStartPrompt{2}.txt);
Instruction(1).xy = [0.2, 0.3];
Instruction(2).txt = 'This prompt image also includes a box in which the stereogram  will appear, so you can prepare yourself for it';
Instruction(2).xy = [0.2, 0.35];
Instruction(3).txt = 'you may take your time to start each trial, and take your time to give response to the trial';
Instruction(3).xy = [0.2, 0.4];
% Instruction(4).txt = 'By taking your time  to press a button to start a trial, you could take a short pause/rest before a trial starts';
% Instruction(4).xy = [0.1, 0.7];
%
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 1;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = 1;
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'A low tone beep after your button press acknowledges your response ';
Instruction(1).xy = [0.2, 0.25];
Instruction(2).txt = 'It does not indicate whether your button press was correct or incorrect, just an acknowledgement of your button press';
Instruction(2).xy = [0.2, 0.30];
Instruction(3).txt = 'But if you pressed neither the button for near nor the button for far, then you hear a high-pitched beep ';
Instruction(3).xy = [0.2, 0.35];
Instruction(4).txt = 'and you can then try again to give a valid response button ';
Instruction(4).xy = [0.2, 0.40];
%
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'Sometimes,  the stereogram flickers in time, but you do the same task regardless';
Instruction(1).xy = [0.2, 0.25];
Instruction(2).txt = 'let us show you an example';
Instruction(2).xy = [0.2, 0.3];
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 2;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = -1;
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'Remember that sometimes the  stereogram is away from the fixation cross';
Instruction(1).xy = [0.2, 0.3];
Instruction(2).txt = 'meanwhile, you need to keep your fixation at the central cross';
Instruction(2).xy = [0.2, 0.35];
if design.GazeTracking_Or_Not ==1
    Instruction(3).txt = 'let us show you an example, although we do not track and check your gaze in this demo';
else
    Instruction(3).txt = 'let us show you an example';
end
Instruction(3).xy = [0.2, 0.4];
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 2;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 3;    %central location
Trial_Character.DepthOrder = -1;
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'Sometimes, the stereogram is noisy, e.g., this stereogram, try to give your depth report as correctly as possible';
Instruction(1).xy = [0.2, 0.25];
Instruction(2).txt = 'You should try your best, in order for me to get quality data. So please try as if you are in a competition';
Instruction(2).xy = [0.2, 0.30];
Instruction(3).txt = 'let us show you an example of such a trial';
Instruction(3).xy = [0.2, 0.35];

Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 1;   % slow flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = 1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [1.0, 0.5, 0];

%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 1;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%----------------------------------------------

%---- Demo a noisy trial
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 1;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = -1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [1.0, 0.3, 0];
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'let us show you another example, it is noiser, you should still try your best';
Instruction(1).xy = [0.2, 0.4];
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%---- Demo a noisier trial
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 2;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = -1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [1.0, 0.7, 0];
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'let us show you another example, it is even noiser, you should always try your best';
Instruction(1).xy = [0.2, 0.4];
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%---- Demo a noisier trial
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 1;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 2;    %central location
Trial_Character.DepthOrder = -1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [1.0, 0.9, 0];
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
Instruction(1).txt = 'Let us show you an example when the noisy stereogram appear at another location away from the central fixation cross';
Instruction(1).xy = [0.2, 0.3];
Instruction(2).txt = 'and remember, you need to keep your fixation at the cross (till the mask appears)';
Instruction(2).xy = [0.2, 0.35];
Instruction(3).txt = 'Enter RightArrow to see an example';
Instruction(3).xy = [0.2, 0.5];
%
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

%---- Demo a noisier trial
Trial_Character.RDS_BinocularMatchingProb_Index  = 1;   % correlated trials
Trial_Character.RDS_FrameDuration_Index  = 2;   % fast flickering RDSs
Trial_Character.RDS_Location_Index = 1;    %central location
Trial_Character.DepthOrder = 1;
Trial_Character.Real_Prob_Noise_Anti_Parameters = [1.0, 0.7, 0];
%
This_Instruction_Page_Info.Type = 2;
This_Instruction_Page_Info.Trial_Character = Trial_Character;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;



%--- Next page of instruction, modify whatever needs to be modified from the last page.
clear Instruction;
if  design.Give_PracticeTrials_Or_Not ==1  & sum(sum(sum(design.N_PracticeTrials_Each_Coherence_FrameDuration_Location)))>0
    Instruction(1).txt = 'Do you have any questions? Let us do some practice trials ';
else
    Instruction(1).txt = 'Do you have any questions? Let us start the testing trials  ';
end
Instruction(1).xy = [0.2, 0.25];
Instruction(2).txt = 'Enter RightArrow  to proceed  ';
Instruction(2).xy = [0.2, 0.3];
This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
This_Instruction_Page_Info.Trial_Character = Trial_Character;
This_Instruction_Page_Info.Type = 1;
This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = 0;

Page_count = Page_count+1;
Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;


