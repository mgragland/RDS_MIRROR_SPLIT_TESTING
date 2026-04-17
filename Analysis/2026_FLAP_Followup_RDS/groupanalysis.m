function groupanalysis(Accuracy, savefigures) 

names=Accuracy(3,:);
group_corr_central=NaN(1,length(Accuracy));
group_corr_lower=NaN(1,length(Accuracy));
group_anti_central=NaN(1,length(Accuracy));
group_anti_lower=NaN(1,length(Accuracy));
for i=1:size(Accuracy,2)
    group_corr_central(i)=Accuracy{1,i}(1);
    group_corr_lower(i)=Accuracy{1,i}(2);
    group_anti_central(i)=Accuracy{2,i}(1);
    group_anti_lower(i)=Accuracy{2,i}(2);
end

colors = lines(size(Accuracy,2));  % good default distinguishable colors

%% Correlated Trials
group_fig=figure;
label={'Central', 'Lower Peripheral'};
subplot(1,2,1)
x=1:2;
bar_corr=[mean(group_corr_central), mean(group_corr_lower)];
bar(x, bar_corr)
ylim([0,1.2])
xticklabels(label);
ylabel('Accuracy According to V1 Output')
title('Correlated Random Dot Stereograms')
hold on

for i=1:size(Accuracy,2)
    c = colors(i,:);  % pick participant color
    % Create the scatter plot
    scatter(x,Accuracy{1,i}, 60, c, 'filled')
    % Hold the current plot to add lines
    hold on;
    % Plot the lines connecting the points
    plot(x, Accuracy{1,i}, '-o', 'Color', c, 'MarkerFaceColor', c);    
    hold on
end
%% Anticorrelated Trails
subplot(1,2,2)
x=1:2;
bar_ant=[mean(group_anti_central), mean(group_anti_lower)];
bar(x, bar_ant)
ylim([0,1.2])
xticklabels(label);
ylabel('Accuracy According to V1 Output')
title('Anti-Correlated Random Dot Stereograms')
hold on

for i=1:size(Accuracy,2)
    c = colors(i,:);  % pick participant color
    % Create the scatter plot
    scatter(x,Accuracy{2,i}, 60, c, 'filled')
    % Hold the current plot to add lines
    hold on;
    % Plot the lines connecting the points
    h(i)=plot(x, Accuracy{2,i},'-o', 'Color', c, 'MarkerFaceColor', c);  % '-o' adds a line with circle markers
    hold on
end
legend(h, string(names), ...
    'Location','eastoutside', ...
    'Orientation','vertical')

fileName='Group_accuracy_w_IndividualData.jpg';
fullFilePath = fullfile(savefigures, fileName);
saveas(group_fig, fullFilePath);  % Saves as JPG if .jpg extension is used
end