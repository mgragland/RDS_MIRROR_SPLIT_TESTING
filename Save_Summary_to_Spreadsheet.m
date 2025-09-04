function Save_Summary_to_Spreadsheet(Practice_Trial_Data, Testing_Trial_Data, design, filename)

Trial_Info=[];

for practice_or_test = 1:2
    if practice_or_test ==1
        Trial_Data = Practice_Trial_Data;
    else
        Trial_Data = Testing_Trial_Data;
    end
    trial_start = length(Trial_Info);
    for trial = 1:length(Trial_Data)
        condition = Trial_Data(trial).condition;
        Response_button = Trial_Data(trial).TrialResponses.Task_Button_Response.Button_Characters;
        %
        DepthOrder_index = Trial_Data(trial).FrontOrBack;
        DepthOrder_label = design.DepthOrder_by_Label{DepthOrder_index};
        %
        Prob_DiskDotIsSameAcrossEyes=condition.Prob_DiskDotIsSameAcrossEyes-condition.Anti_Fraction; %--- this holds only when
        Prob_DiskDotIsSameAcrossEyes_index = find(design.Prob_DiskDotIsSameAcrossEyes==Prob_DiskDotIsSameAcrossEyes);
        coherence_label = design.Prob_DiskDotIsSameAcrossEyes_by_Label{Prob_DiskDotIsSameAcrossEyes_index};
        %
        RDS_location = [condition.x_stimulus, condition.y_stimulus];
        RDS_location_index = find(RDS_location(1) == design.Stimulus_center_xy_in_Pixel(:, 1) & ...
            RDS_location(2) == design.Stimulus_center_xy_in_Pixel(:, 2));
        RDS_location_label = design.Stimulus_center_xy_by_Label{RDS_location_index};
        %
        RDS_frame_duration = condition.PresentationPeriod;
        RDS_frame_duration_index = find(RDS_frame_duration== design.RDS_frame_durations_in_Second);
        RDS_frame_duration_label = design.RDS_frame_durations_by_Label{RDS_frame_duration_index};
        
        if strcmp(Response_button, design.Response_Buttons.keyName{DepthOrder_index}) ==1
            Correct_Or_Not =1;
        else
            Correct_Or_Not =0;
        end
        %
        Response_Time = Trial_Data(trial).TrialResponses.Task_Button_Response.Time;
        Reponse_Frame_OnsetTIme = Trial_Data(trial).FixationFrame_OnsetTimes(end);
        Response_RT = Response_Time-Reponse_Frame_OnsetTIme;
        
        i =trial_start+trial;
        
        Trial_Info(i).TrialNumber = i;
        Trial_Info(i).DepthOrder_label = DepthOrder_label;
        Trial_Info(i).coherence_label = coherence_label;
        Trial_Info(i).Prob_BinocularMatch = Prob_DiskDotIsSameAcrossEyes;
        Trial_Info(i).RDS_location_x  = RDS_location(1);
        Trial_Info(i).RDS_location_y  = RDS_location(2);
        Trial_Info(i).RDS_location_label  = RDS_location_label;
        Trial_Info(i).RDS_frame_duration = RDS_frame_duration;
        Trial_Info(i).RDS_frame_duration_label = RDS_frame_duration_label;
        Trial_Info(i).Response_button = Response_button;
        if  Correct_Or_Not==1
            Trial_Info(i).Accuracy = 'correct';
        else
            Trial_Info(i).Accuracy = 'incorrect';
        end
        Trial_Info(i).Response_RT = Response_RT;
        if practice_or_test ==1
            Trial_Info(i).PracticeOrTest = 'practice';
        else
            Trial_Info(i).PracticeOrTest = 'test';
        end
    end
end


T = struct2table(Trial_Info);
writetable(T, filename);





