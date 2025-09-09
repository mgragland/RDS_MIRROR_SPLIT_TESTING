function rt_lowervisualfield(filePath, count, savefigures, fixation_y)
load(filePath)
Trial_Data=Testing_Trial_Data;

% Initialize Variables 
AntiCorrelated_Trial_Index_Static=[];
Correlated_Trial_Index_Static=[];
AntiCorrelated_Trial_Index_Dynamic=[];
Correlated_Trial_Index_Dynamic=[];

rt_correct_central_anti=[];
rt_incorrect_central_anti=[];
rt_correct_lower_anti=[];
rt_incorrect_lower_anti=[];

rt_correct_central_corr=[];
rt_incorrect_central_corr=[];
rt_correct_lower_corr=[];
rt_incorrect_lower_corr=[];


for i=1:length(Trial_Data)
    if Testing_Trial_Data(i).condition.PresentationDuration==Testing_Trial_Data(i).condition.PresentationPeriod
        if Testing_Trial_Data(i).condition.Anti_Fraction==1
            AntiCorrelated_Trial_Index_Static(end+1)=i;
        else
            Correlated_Trial_Index_Static(end+1)=i;
        end
    else
        if Testing_Trial_Data(i).condition.Anti_Fraction==1
            AntiCorrelated_Trial_Index_Dynamic(end+1)=i;
        else
            Correlated_Trial_Index_Dynamic(end+1)=i;
        end
    end
end

Trials_Anti_Dynamic= Trial_Data(AntiCorrelated_Trial_Index_Dynamic);
Trials_Corr_Dynamic=Trial_Data(Correlated_Trial_Index_Dynamic)

for i=1:length(Trials_Anti_Dynamic)
    a=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trials_Anti_Dynamic(i).condition.y_fixation==fixation_y(2) %central
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            stimulus_stop_time=Trials_Anti_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Time
            rt_correct_central_anti(end+1) = pt_rt_button-stimulus_stop_time;
        else
            stimulus_stop_time=Trials_Anti_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Time
            rt_incorrect_central_anti(end+1) = pt_rt_button-stimulus_stop_time; 
        end
    elseif Trials_Anti_Dynamic(i).condition.y_fixation==fixation_y(1)
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            stimulus_stop_time=Trials_Anti_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_correct_lower_anti(end+1)=pt_rt_button-stimulus_stop_time;
        else
            stimulus_stop_time=Trials_Anti_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_incorrect_lower_anti(end+1)=pt_rt_button-stimulus_stop_time;
        end
    end
end

for i=1:length(Trials_Corr_Dynamic)
    a=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trials_Corr_Dynamic(i).condition.y_fixation==fixation_y(2) %central 
        if Trials_Corr_Dynamic(i).FrontOrBack==Response
            stimulus_stop_time=Trials_Corr_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_correct_central_corr(end+1) = pt_rt_button-stimulus_stop_time;
        else
            stimulus_stop_time=Trials_Corr_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_incorrect_central_corr(end+1) = pt_rt_button-stimulus_stop_time; 
        end
    elseif Trials_Corr_Dynamic(i).condition.y_fixation==fixation_y(1) %peripheral
        if Trials_Corr_Dynamic(i).FrontOrBack==Response
            stimulus_stop_time=Trials_Corr_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_correct_lower_corr(end+1)=pt_rt_button-stimulus_stop_time;
        else
            stimulus_stop_time=Trials_Corr_Dynamic(i).StimulusFrame_OnsetTimes(end); %dynamic stimuli so take the last time point for the final frame shown
            pt_rt_button=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Time;
            rt_incorrect_lower_corr(end+1)=pt_rt_button-stimulus_stop_time;
        end
    end
end


%% Graph the RT
graphrt