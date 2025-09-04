
function  condition  = Get_condition(a, b, c, design)

	condition.x_stimulus = design.Stimulus_center_xy_in_Pixel(c, 1);
	condition.y_stimulus = design.Stimulus_center_xy_in_Pixel(c, 2);
	
	%--- fixation location
	condition.x_fixation = design.Fixation_center_xy_in_Pixel(1, c, 1);
	condition.y_fixation = design.Fixation_center_xy_in_Pixel(1, c, 2);
	condition.FixationCross_Size = design.FixationCross_Size_in_Pixel;
	%
	condition.x_fixation2 = design.Fixation_center_xy_in_Pixel(2, c, 1);
	condition.y_fixation2 = design.Fixation_center_xy_in_Pixel(2, c, 2);
	condition.FixationCross2_Size = design.FixationCross_Size_in_Pixel;

	condition.Dot_Radius =design.Dot_Radiuses_in_Pixel;
	condition.Disk_Radius =design.Disk_Radiuses_in_Pixel;
	condition.Ring_OuterRadius= design.Ring_OuterRadiuses_in_Pixel;
	condition.Ring_InnerRadius = design.Ring_InnerRadiuses_in_Pixel;

	condition.CallNextTrial_x1 = design.TrialStartPrompt{1}.xy_in_Pixel(1);
	condition.CallNextTrial_y1 = design.TrialStartPrompt{1}.xy_in_Pixel(2);
	condition.CallNextTrial_x2 = design.TrialStartPrompt{2}.xy_in_Pixel(1);
	condition.CallNextTrial_y2 = design.TrialStartPrompt{2}.xy_in_Pixel(2);
	%
	condition.PresentationDuration =design.stimulus_duration_in_Second;

	%
	condition.PresentationPeriod =design.RDS_frame_durations_in_Second(b);
	if condition.PresentationDuration ~= floor(condition.PresentationDuration/condition.PresentationPeriod)*condition.PresentationPeriod
    		error('PresentationDuration must be an integer multiple of PresentationPeriod ');
	end
	condition.Depth_Magnitude = design.Depth_Magnitudes_in_Pixel;
	condition.Dot_Density = design.Dot_Density;
	condition.Prob_DiskDotIsSameAcrossEyes =1; %--- fixed
	condition.Add_FixationCross =design.Add_FixationCross;
	condition.Add_UnPaired_Dots  = design.Add_UnPaired_Dots;
	condition.Anti_Fraction= 1-design.Prob_DiskDotIsSameAcrossEyes(a);  %--- so Anti_Fraction >=0, reversed depth, incongruent.
	condition.Noise_Fraction= condition.Anti_Fraction;  %--- For when Anti_Fraction is always the same as noise, so all the anti dots comes from the noise dots, addording to the stimulus making program  GetStimulusInfoFromConditionEtc.m
	condition.StimulusDurationMultiple = 1; %-

		
	
	
