function design = Set_Experimental_design(Use_Default_Or_Review)

	design  = Start_Experimental_design(Use_Default_Or_Review.design1); %--- this information entries in this code should not change often, once settled for a given project and set up, 
						% --- do not change unless you have to.
	design.N_RDS_coherence=length(design.Prob_DiskDotIsSameAcrossEyes);
	design.N_RDS_locations=size(design.Stimulus_center_xy_in_Scale, 1);
	design.N_frameDuration= length(design.RDS_frame_durations_in_Second);

	%
	design = Set_More_Flexible_Parameters_for_design(design, Use_Default_Or_Review.design2); %--- here you may like to change things, such as default values, number of trials,  or just change them using dialog boxes. 
