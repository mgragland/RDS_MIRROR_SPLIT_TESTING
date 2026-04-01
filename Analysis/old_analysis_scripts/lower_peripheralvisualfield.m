function [Accuracy_Anti,Accuracy_Corr, Accuracy_Table,SignalDetect_Table]=lower_peripheralvisualfield(filePath, count)
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

[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(AntiCorrelated_Trial_Index_Dynamic, Testing_Trial_Data, design, 2);
[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(Correlated_Trial_Index_Dynamic, Testing_Trial_Data, design, 1);


Trials_Anti_Dynamic= Trial_Data(AntiCorrelated_Trial_Index_Dynamic);
Correct_central_anti=0;
Incorrect_central_anti=0;
Correct_lowerleft_anti=0;
Incorrect_lowerleft_anti=0;
Correct_lowerright_anti=0;
Incorrect_lowerright_anti=0;

Accuracy_central_anti= 0;
Accuracy_lowerleft_anti= 0;
Accuracy_lowerright_anti= 0;

for i=1:length(Trials_Anti_Dynamic)
    a=Trials_Anti_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trials_Anti_Dynamic(i).condition.x_stimulus==687
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            Correct_lowerleft_anti=Correct_lowerleft_anti+1;
        else
            Incorrect_lowerleft_anti=Incorrect_lowerleft_anti+1;
        end
    elseif Trials_Anti_Dynamic(i).condition.x_stimulus==960
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            Correct_central_anti=Correct_central_anti+1;
        else
            Incorrect_central_anti=Incorrect_central_anti+1;
        end
    elseif Trials_Anti_Dynamic(i).condition.x_stimulus==1233
        if Trials_Anti_Dynamic(i).FrontOrBack==Response
            Correct_lowerright_anti=Correct_lowerright_anti+1;
        else
            Incorrect_lowerright_anti=Incorrect_lowerright_anti+1;
        end
        total_lowerleft_anti=Correct_lowerleft_anti+ Incorrect_lowerleft_anti;
        total_central_anti=Correct_central_anti+ Incorrect_central_anti;
        total_upperright_anti=Correct_lowerright_anti+ Incorrect_lowerright_anti;

        Accuracy_lowerleft_anti= Correct_lowerleft_anti/total_lowerleft_anti;
        Accuracy_central_anti=Correct_central_anti/total_central_anti;
        Accuracy_lowerright_anti= Correct_lowerright_anti/total_upperright_anti;
    end
end

    Trials_Corr_Dynamic= Trial_Data(Correlated_Trial_Index_Dynamic);
    Correct_central_corr=0;
    Incorrect_central_corr=0;
    Correct_lowerleft_corr=0;
    Incorrect_lowerleft_corr=0;
    Correct_lowerright_corr=0;
    Incorrect_lowerright_corr=0;
    Accuracy_central_corr= 0;
    Accuracy_lowerleft_corr= 0;
    Accuracy_lowerright_corr= 0;

    for i=1:length(Trials_Corr_Dynamic)
        a=Trials_Corr_Dynamic(i).TrialResponses.Task_Button_Response.Button_Characters;
        if strcmp(a, 'b')
            Response=2;
        elseif strcmp(a, 'space')
            Response=1;
        else
            continue
        end
        if Trials_Anti_Dynamic(i).condition.x_stimulus==687
            if Trials_Corr_Dynamic(i).FrontOrBack==Response
                Correct_lowerleft_corr=Correct_lowerleft_corr+1;
            else
                Incorrect_lowerright_corr=Incorrect_lowerright_corr+1;
            end
        elseif Trials_Anti_Dynamic(i).condition.x_stimulus==960
            if Trials_Corr_Dynamic(i).FrontOrBack==Response
                Correct_central_corr=Correct_central_corr+1;
            else
                Incorrect_central_corr=Incorrect_central_corr+1;
            end
        elseif Trials_Anti_Dynamic(i).condition.x_stimulus==1233
            if Trials_Corr_Dynamic(i).FrontOrBack==Response
                Correct_lowerright_corr=Correct_lowerright_corr+1;
            else
                Incorrect_lowerright_corr=Incorrect_lowerright_corr+1;
            end
        end
        total_central_corr=Correct_central_corr+ Incorrect_central_corr;
        total_lowerleft_corr=Correct_lowerleft_corr+ Incorrect_lowerleft_corr;
        total_lowerright_corr=Correct_lowerright_corr+ Incorrect_lowerright_corr;
        Accuracy_central_corr=Correct_central_corr/total_central_corr;
        Accuracy_lowerleft_corr= Correct_lowerleft_corr/total_lowerleft_corr;
        Accuracy_lowerright_corr= Correct_lowerright_corr/total_lowerright_corr;
    end

    label={'Central', 'Lower Peripheral'}
    figure
    subplot(2,1,1)
    Corr_trials=[Accuracy_lowerleft_corr, Accuracy_central_corr,Accuracy_lowerright_corr];
    Anti_trials=[Accuracy_lowerleft_anti, Accuracy_central_anti,Accuracy_lowerright_anti];
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

    Accuracy_Anti=[Accuracy_lowerleft_anti, Accuracy_central_anti,Accuracy_lowerright_anti];
    Accuracy_Corr=[Accuracy_lowerleft_corr, Accuracy_central_corr,Accuracy_lowerright_corr];


    clear Correlated_Trial_Index_Static AntiCorrelated_Trial_Index_Static
end