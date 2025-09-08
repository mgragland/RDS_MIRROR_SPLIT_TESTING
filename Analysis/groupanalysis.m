function groupanalysis(Accuracy, lowervis, uppervis, multiple_sessions, savefigures)



if lowervis==1;
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
        % Create the scatter plot
        scatter(x,Accuracy{1,i}, 'filled')
        % Hold the current plot to add lines
        hold on;
        % Plot the lines connecting the points
        plot(x, Accuracy{1,i});  % '-o' adds a line with circle markers
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
        % Create the scatter plot
        scatter(x,Accuracy{2,i}, 'filled')
        % Hold the current plot to add lines
        hold on;
        % Plot the lines connecting the points
        plot(x, Accuracy{2,i});  % '-o' adds a line with circle markers
        hold on
    end

    fileName='Group_accuracy_w_IndividualData.jpg';
    fullFilePath = fullfile(savefigures, fileName);
    saveas(group_fig, fullFilePath);  % Saves as JPG if .jpg extension is used



    if multiple_sessions==1
        mult_sessions=figure;
        label={'Central', 'Lower Peripheral'};
        subplot(1,2,1)
        x=1:2;
        bar_corr_mult=[group_corr_central;group_corr_lower];
        bar(x, bar_corr_mult)
        ylim([0,1.2])
        xticklabels(label);
        ylabel('Accuracy According to V1 Output')
        title('Correlated Random Dot Stereograms')
        hold on
        subplot(1,2,2)
        bar_ant_mult=[group_anti_central;group_anti_lower];
        bar(x, bar_ant_mult)
        ylim([0,1.2])
        xticklabels(label);
        ylabel('Accuracy According to V1 Output')
        title('Anti-Correlated Random Dot Stereograms')
        fileName='Group_accuracy_multsessions.jpg';
        fullFilePath = fullfile(savefigures, fileName);
        saveas(mult_sessions, fullFilePath);  % Saves as JPG if .jpg extension is used

    end


elseif uppervis==1 || lowervis==2;
    [numrows, numcols]= size(Accuracy);
    lefttrials= NaN(numrows, numcols);
    centraltrials= NaN(numrows, numcols);
    righttrials= NaN(numrows, numcols);
    for i=1:numrows
        for j=1:numcols
            vector=Accuracy{i,j}
            lefttrials(i,j)=vector(1)
            centraltrials(i,j)=vector(2)
            righttrials(i,j)=vector(3)
        end
    end

    meanvalues=NaN(4,3);
    std_values=NaN(4,3);
    for i=1:numrows
        meanvalues(i, 1)= mean(lefttrials(i,:));
        meanvalues(i, 2)= mean(centraltrials(i,:));
        meanvalues(i, 3)= mean(righttrials(i,:));
        std_values(i, 1)= std(lefttrials(i,:));
        std_values(i, 2)= std(centraltrials(i,:));
        std_values(i, 3)= std(righttrials(i,:));
    end

    condition_labels={'Correlated Dynamic', 'Anticorrelated Dynamic'};
    labels={'Left', 'Central', 'Right'}

    for i = 1:2
        if i == 1
            figure
            subplot(1,2,1)
            hold on
        else
            subplot(1,2,i)
        end

        % Create the bar plot
        b = bar(meanvalues(i,:));
        hold on
        x = b.XData;
        errorbar(x, meanvalues(i,:), std_values(i,:), 'k', 'LineStyle', 'none');
        title(['' num2str(condition_labels{i})]);
        xticks(1:length(labels));
        xticklabels(labels);
        ylabel('Accuracy in Reporting V1 Output');
        ylim([0,1.2]);
        hold on

        for j=1:size(Accuracy,2)
            % Create the scatter plot
            scatter(x,Accuracy{i,j}, 'filled')
            % Hold the current plot to add lines
            hold on;
            % Plot the lines connecting the points
            plot(x, Accuracy{i,j});  % '-o' adds a line with circle markers
            hold on
        end
    end
else
    [numrows, numcols]= size(Accuracy);
    lefttrials= NaN(numrows, numcols);
    centraltrials= NaN(numrows, numcols);
    righttrials= NaN(numrows, numcols);
    for i=1:numrows
        for j=1:numcols
            vector=Accuracy{i,j}
            lefttrials(i,j)=vector(1)
            centraltrials(i,j)=vector(2)
            righttrials(i,j)=vector(3)
        end
    end

    meanvalues=NaN(4,3);
    std_values=NaN(4,3);
    for i=1:numrows
        meanvalues(i, 1)= mean(lefttrials(i,:));
        meanvalues(i, 2)= mean(centraltrials(i,:));
        meanvalues(i, 3)= mean(righttrials(i,:));
        std_values(i, 1)= std(lefttrials(i,:));
        std_values(i, 2)= std(centraltrials(i,:));
        std_values(i, 3)= std(righttrials(i,:));
    end

    condition_labels={'Correlated Static', 'Correlated Dynamic','Anticorrelated Static', 'Anticorrelated Dynamic'};
    labels={'Left', 'Central', 'Right'}
    for i = 1:4
        if i == 1
            figure
            subplot(2,2,1)
            hold on
        else
            subplot(2,2,i)
        end

        % Create the bar plot
        b = bar(meanvalues(i,:));
        hold on
        x = b.XData;
        errorbar(x, meanvalues(i,:), std_values(i,:), 'k', 'LineStyle', 'none');
        title(['' num2str(condition_labels{i})]);
        xticks(1:length(labels));
        xticklabels(labels);
        ylabel('Accuracy in Reporting V1 Output');
        ylim([0,1.2]);
        labels={'Left', 'Central', 'Right'}
        hold on

        for j=1:size(Accuracy,2)
            % Create the scatter plot
            scatter(x,Accuracy{i,j}, 'filled')
            % Hold the current plot to add lines
            hold on;
            % Plot the lines connecting the points
            plot(x, Accuracy{i,j});  % '-o' adds a line with circle markers
            hold on
        end
    end
end
end

