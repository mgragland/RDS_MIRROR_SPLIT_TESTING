 Trial_Data=Testing_Trial_Data;
NTrials = length(Trial_Data);

Trial_CorrectOrNot = zeros(NTrials, 1);
Trial_DepthOrder = zeros(NTrials, 1);
Trial_RDS_Prob_DiskDotIsSameAcrossEyes =  zeros(NTrials, 1);
Trial_RDS_Location_xy_in_Pixels =  zeros(NTrials, 2);
Trial_RDS_FrameDuration =  zeros(NTrials, 1);


for trial = 1:NTrials
    condition =Trial_Data(trial).condition;
    Response_button = Trial_Data(trial).TrialResponses.Task_Button_Response.Button_Characters;
    DepthOrder_index = find(design.DepthOrder ==Trial_Data(trial).FrontOrBack);
    if strcmp(Response_button, design.Response_Buttons.keyName{DepthOrder_index}) ==1
        Trial_CorrectOrNot(trial) =1;
    end 
    Trial_DepthOrder(trial) = Trial_Data(trial).FrontOrBack;
    Trial_RDS_Prob_DiskDotIsSameAcrossEyes(trial) = condition.Prob_DiskDotIsSameAcrossEyes-condition.Anti_Fraction; %--- this holds only when
    Trial_RDS_Location_xy_in_Pixels(trial, :) = [condition.x_stimulus, condition.y_stimulus];
    Trial_RDS_FrameDuration(trial) = condition.PresentationPeriod;
end

Prob_DiskDotIsSameAcrossEyes = design.Prob_DiskDotIsSameAcrossEyes;
RDS_frame_durations_in_Second = design.RDS_frame_durations_in_Second;
Stimulus_center_xy_in_Pixel = design.Stimulus_center_xy_in_Pixel;

N_Coherence = length(Prob_DiskDotIsSameAcrossEyes);
N_FrameDuration = length(RDS_frame_durations_in_Second);
N_Location = size(Stimulus_center_xy_in_Pixel, 1);

Accuracies  = zeros(N_Coherence, N_FrameDuration, N_Location);
N_Trials = zeros(N_Coherence, N_FrameDuration, N_Location);

for i = 1:N_Coherence
    for j = 1:N_FrameDuration
        for k = 1:N_Location
            Selected_Trials  = find(Trial_RDS_Prob_DiskDotIsSameAcrossEyes == Prob_DiskDotIsSameAcrossEyes(i) & ...
                Trial_RDS_FrameDuration == RDS_frame_durations_in_Second(j) & ...
                Trial_RDS_Location_xy_in_Pixels(:, 1) == Stimulus_center_xy_in_Pixel(k, 1) & ...
                Trial_RDS_Location_xy_in_Pixels(:, 2) == Stimulus_center_xy_in_Pixel(k, 2) );
            N_Trials(i, j, k) = length(Selected_Trials);
            Accuracies(i, j, k) = mean(Trial_CorrectOrNot(Selected_Trials));
        end
    end
end

figure;
for i = 1:N_Coherence
    for j = 1:N_FrameDuration
        if sum(squeeze(N_Trials(i, j, :)))>0
            plot_number = j+ (i-1)*N_FrameDuration;
            subplot(N_Coherence, N_FrameDuration, 	 plot_number);
            bar(1:N_Location, squeeze(Accuracies(i, j, :)), 0.2, 'b');
            ylim([0 1])
            xlabel('RDS locations');
            ylabel('Reporting Correct V1 Output');
            txt = [design.Prob_DiskDotIsSameAcrossEyes_by_Label{i}, ' ', design.RDS_frame_durations_by_Label{j}];
            title(['Accuracy for ', txt, ' trials']);
            set(gca, 'xtick', 1:N_Location, 'xticklabel', design.Stimulus_center_xy_by_Label);
            location_txt =[];
            for k = 1:N_Location
                if k<N_Location
                    location_txt  = [location_txt, design.Stimulus_center_xy_by_Label{k}, ', '];
                else
                    location_txt  = [location_txt, design.Stimulus_center_xy_by_Label{k}];
                end
            end
            txt2= ['For ',  txt, ' trials, accuracies based on v1 output at ', location_txt, ' are ', num2str(Accuracies(i, j, :))];
            disp(txt2);
        end
    end
end


% to flip the accuracy measure for anticorrelated (i.e. reporting correct
% depth)
[numrows,numcols, numdim]=size(Accuracies);
for i=1:numrows
    for j=1:numcols
        for k=1:numdim
            if i==2 && j==1 && k==1
                Accuracies(i,j,k)=1-Accuracies(i,j,k);
            elseif i==2 && j==1 && k==2
                Accuracies(i,j,k)=1-Accuracies(i,j,k);
            elseif i==2 && j==1 && k==3
                Accuracies(i,j,k)=1-Accuracies(i,j,k);
                
            end
        end
    end
end


                             
                
        

figure;
for i = 1:N_Coherence
    for j = 1:N_FrameDuration
        if sum(squeeze(N_Trials(i, j, :)))>0
            plot_number = j+ (i-1)*N_FrameDuration;
            subplot(N_Coherence, N_FrameDuration, 	 plot_number);
            bar(1:N_Location, squeeze(Accuracies(i, j, :)), 0.2, 'r');
            ylim([0 1])
            xlabel('RDS locations');
            ylabel('Reporting Correct Depth');
            txt = [design.Prob_DiskDotIsSameAcrossEyes_by_Label{i}, ' ', design.RDS_frame_durations_by_Label{j}];
            title(['Accuracy for ', txt, ' trials']);
            set(gca, 'xtick', 1:N_Location, 'xticklabel', design.Stimulus_center_xy_by_Label);
            location_txt =[];
            for k = 1:N_Location
                if k<N_Location
                    location_txt  = [location_txt, design.Stimulus_center_xy_by_Label{k}, ', '];
                else
                    location_txt  = [location_txt, design.Stimulus_center_xy_by_Label{k}];
                end
            end
            txt2= ['For ',  txt, ' trials, accuracies for reporting correct depth order at ', location_txt, ' are ', num2str(Accuracies(i, j, :))];
            disp(txt2);
        end
    end
end



