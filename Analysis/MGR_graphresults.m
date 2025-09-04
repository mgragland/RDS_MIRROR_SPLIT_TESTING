function [Accuracy]=MGR_graphresults(filePath, count, fileList, Accuracy)
load(filePath)
folderPath= '/users/madelineragland/FLAP DATA/RDSfigures'
fileName1 = fullfile(folderPath, [Subject_Info.Name, ' V1 Output', '.jpg']);
fileName2 = fullfile(folderPath, [Subject_Info.Name, ' Actual Depth Accuracy', '.jpg']);

Trial_Data=Testing_Trial_Data;
NTrials = length(Trial_Data);
AntiCorrelated_Trial_Index_Static=[];
Correlated_Trial_Index_Static=[];
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


%% Data Efficient/Data Cleaning
% separate function
% only put response into a separate array 


%% Create Condition Tables for both Anticorrelated and Correlated Trials--> Static 
[Anticorrelated_Trials_Table_Static]=createconditiontable(AntiCorrelated_Trial_Index_Static, Testing_Trial_Data, design);
[Correlated_Trials_Table_Static]=createconditiontable(Correlated_Trial_Index_Static, Testing_Trial_Data, design);
[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(AntiCorrelated_Trial_Index_Static, Testing_Trial_Data, design, 'Anticorrelated');
[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(Correlated_Trial_Index_Static, Testing_Trial_Data, design, 'Correlated');

%% Create Condition Tables for both Anticorrelated and Correlated Trials--> Dynamic  
[Anticorrelated_Trials_Table_Dynamic]=createconditiontable(AntiCorrelated_Trial_Index_Dynamic, Testing_Trial_Data, design);
[Correlated_Trials_Table_Dynamic]=createconditiontable(Correlated_Trial_Index_Dynamic, Testing_Trial_Data, design);
[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(AntiCorrelated_Trial_Index_Dynamic, Testing_Trial_Data, design, 'Anticorrelated');
[Accuracy_Table, SignalDetect_Table]=createsignaldetecttable(Correlated_Trial_Index_Dynamic, Testing_Trial_Data, design, 'Correlated');

%% Graph 
Correlated_Trials_Static= [Correlated_Trials_Table_Static(3,3,1), Correlated_Trials_Table_Static(3,3,2), Correlated_Trials_Table_Static(3,3,3)];
Correlated_Trials_Dynamic= [Correlated_Trials_Table_Dynamic(3,3,1), Correlated_Trials_Table_Dynamic(3,3,2), Correlated_Trials_Table_Dynamic(3,3,3)];
Anticorrelated_Trials_Static=[Anticorrelated_Trials_Table_Static(3,3,1), Anticorrelated_Trials_Table_Static(3,3,2), Anticorrelated_Trials_Table_Static(3,3,3)];
Anticorrelated_Trials_Dynamic=[Anticorrelated_Trials_Table_Dynamic(3,3,1), Anticorrelated_Trials_Table_Dynamic(3,3,2), Anticorrelated_Trials_Table_Dynamic(3,3,3)];

figure 
subplot(2,2,1) 
graph1= Correlated_Trials_Static; 
bar(graph1);
ylabel('Accuracy based on V1 Output');
xticklabels({'Left', 'Center', 'Right'});
title('Static Correlated Trials');
ylim([0 1]);

subplot(2,2,2) 
graph2= Correlated_Trials_Dynamic; 
bar(graph2);
ylabel('Accuracy based on V1 Output');
xticklabels({'Left', 'Center', 'Right'});
title('Dynamic Correlated Trials');
ylim([0 1]);

subplot(2,2,3) 
graph3= Anticorrelated_Trials_Static; 
bar(graph3);
ylabel('Accuracy based on V1 Output');
xticklabels({'Left', 'Center', 'Right'});
title('Static Anticorrelated Trials');
ylim([0 1]);

subplot(2,2,4) 
graph4= Anticorrelated_Trials_Dynamic
bar(graph4);
ylabel('Accuracy based on V1 Output');
xticklabels({'Left', 'Center', 'Right'});
title('Dynamic Anticorrelated Trials');
ylim([0 1]);


%% Group Analysis 
Accuracy{1,count}= Correlated_Trials_Static;
Accuracy{2,count}= Correlated_Trials_Dynamic;
Accuracy{3,count}= Anticorrelated_Trials_Static;
Accuracy{4,count}= Anticorrelated_Trials_Dynamic;



        




       
          


