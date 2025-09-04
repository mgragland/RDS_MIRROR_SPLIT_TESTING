function [Accuracy_Anti,Accuracy_Corr]=lowervisualfield(filePath, count)
load(filePath)
Trial_Data=Testing_Trial_Data;
NTrials = length(Trial_Data);
Correlated_Trial_Index_Dynamic=[];
AntiCorrelated_Trial_Index_Dynamic=[];

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
Correct_central_anti=0;
Incorrect_central_anti=0;
Correct_lower_anti=0;
Incorrect_lower_anti=0;
total_central_anti=0; 
total_lower_anti=0;
Accuracy_central_anti= 0;
Accuracy_lower_anti= 0;
for i=1:length(Trials_Anti_Dynamic)
    a=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trials_Anti_Dynamic(i).condition.y_fixation==720
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            Correct_central_anti=Correct_central_anti+1; 
        else
            Incorrect_central_anti=Incorrect_central_anti+1;
        end
    elseif Trials_Anti_Dynamic(i).condition.y_fixation==496
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            Correct_lower_anti=Correct_lower_anti+1; 
        else
            Incorrect_lower_anti=Incorrect_lower_anti+1;
        end
    end
    total_central_anti=Correct_central_anti+ Incorrect_central_anti; 
    total_lower_anti=Correct_lower_anti+ Incorrect_lower_anti; 
    Accuracy_central_anti=Correct_central_anti/total_central_anti;
    Accuracy_lower_anti= Correct_lower_anti/total_lower_anti;
end

Trials_Corr_Dynamic= Trial_Data(Correlated_Trial_Index_Dynamic);
Correct_central_corr=0;
Incorrect_central_corr=0;
Correct_lower_corr=0;
Incorrect_lower_corr=0;
total_central_corr=0; 
total_lower_corr=0;
Accuracy_central_corr= 0;
Accuracy_lower_corr= 0;
for i=1:length(Trials_Corr_Dynamic)
    a=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trials_Corr_Dynamic(i).condition.y_fixation==720 
        if Trials_Corr_Dynamic(i).FrontOrBack==Response
            Correct_central_corr=Correct_central_corr+1; 
        else
            Incorrect_central_corr=Incorrect_central_corr+1;
        end
    elseif Trials_Corr_Dynamic(i).condition.y_fixation==496
        if Trials_Corr_Dynamic(i).FrontOrBack==Response
            Correct_lower_corr=Correct_lower_corr+1; 
        else
            Incorrect_lower_corr=Incorrect_lower_corr+1;
        end
    end
    total_central_corr=Correct_central_corr+ Incorrect_central_corr; 
    total_lower_corr=Correct_lower_corr+ Incorrect_lower_corr; 
    Accuracy_central_corr=Correct_central_corr/total_central_corr;
    Accuracy_lower_corr= Correct_lower_corr/total_lower_corr;
end
label={'Central', 'Lower Peripheral'}
figure 
subplot(2,1,1)
Corr_trials=[Accuracy_central_corr,Accuracy_lower_corr]
Anti_trials=[Accuracy_central_anti, Accuracy_lower_anti]
bar(Corr_trials)
ylim([0, 1]);
xticklabels(label);
ylabel('Accuracy According to V1 Output')
title('Correlated Random Dot Stereograms')
subplot(2,1,2)
bar(Anti_trials)
ylim([0, 1]);
xticklabels(label);
ylabel('Accuracy According to V1 Output')
title('Anti-Correlated Random Dot Stereograms')

Accuracy_Anti=[Accuracy_central_anti, Accuracy_lower_anti];
Accuracy_Corr=[Accuracy_central_corr, Accuracy_lower_corr];


clear Correlated_Trial_Index_Static AntiCorrelated_Trial_Index_Static 
end