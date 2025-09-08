
% Plot Average Reaction Time  
correct_corr=[mean(rt_correct_central_corr), mean(rt_correct_lower_corr)]
correct_anti=[mean(rt_correct_central_anti), mean(rt_correct_central_anti)]
incorrect_corr=[mean(rt_incorrect_central_corr), mean(rt_incorrect_lower_corr)]
incorrect_anti=[mean(rt_incorrect_central_anti), mean(rt_incorrect_lower_anti)]

sd_correct_corr=[std(rt_correct_central_corr), std(rt_correct_lower_corr)]
sd_correct_anti=[std(rt_correct_central_anti), std(rt_correct_central_anti)]
sd_incorrect_corr=[std(rt_incorrect_central_corr), std(rt_incorrect_lower_corr)]
sd_incorrect_anti=[std(rt_incorrect_central_anti), std(rt_incorrect_lower_anti)]

rt_fig=figure 
subplot(2,2,1)
x=1:2;
b=bar(x, correct_corr)
hold on 
x_pts = b.XEndPoints;              % Get x-coordinates of bar centers
errorbar(x_pts, correct_corr, sd_correct_corr, ...
    'k', 'linestyle', 'none', 'linewidth', 1.5);  
ylim([0, 1.5])
title('RT for Correct Correlated Trials')

subplot(2,2,2)
b=bar(x,correct_anti)
hold on 
x_pts = b.XEndPoints;              % Get x-coordinates of bar centers
errorbar(x_pts, correct_anti, sd_correct_anti, ...
    'k', 'linestyle', 'none', 'linewidth', 1.5); 
ylim([0, 1.5])
title('RT for Correct Anti-Correlated Trials')

subplot(2,2,3)
bar(x, incorrect_corr)
hold on 
x_pts = b.XEndPoints;              % Get x-coordinates of bar centers
errorbar(x_pts, incorrect_corr, sd_incorrect_corr, ...
    'k', 'linestyle', 'none', 'linewidth', 1.5); 
ylim([0, 1.5])
title('RT for Incorrect Correlated Trials')

subplot(2,2,4)
bar(x, incorrect_anti)
hold on 
x_pts = b.XEndPoints;              % Get x-coordinates of bar centers
errorbar(x_pts, incorrect_anti, sd_incorrect_anti, ...
    'k', 'linestyle', 'none', 'linewidth', 1.5);  % Add error barsylim([0, 0.8])
ylim([0, 1.5])
title('RT for Incorrect Anti-Correlated Trials')

fileName = sprintf('RT_lowervisfield%d.jpg', count);
fullFilePath = fullfile(savefigures, fileName);
saveas(rt_fig, fullFilePath);  % Saves as JPG if .jpg extension is used



