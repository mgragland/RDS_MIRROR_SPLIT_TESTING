function [Trials_Table]=createconditiontable(Trial_Index, Testing_Trial_Data, design)
center_y=design.Stimulus_center_xy_in_Pixel(2,2);
left_x=design.Stimulus_center_xy_in_Pixel(1,1);
right_x=design.Stimulus_center_xy_in_Pixel(3,1);
Trials_Table=zeros(3,3,3);

for i= 1:length(Trial_Index)
    Trial=Testing_Trial_Data(Trial_Index(i));
    a=Trial.TrialResponses.Task_Button_Response.Button_Characters; 
    if strcmp(a, 'b')
        Response=2;
    elseif strcmp(a, 'space')
        Response=1;
    else
        continue
    end
    if Trial.condition.y_stimulus==center_y % Center Trial
        if Trial.FrontOrBack==1
            Trials_Table(2,1,2)= Trials_Table(2,1,2)+1; % Total Front Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,1,2)= Trials_Table(1,1,2)+1; % Correct Front
                Trials_Table(3,1,2)=Trials_Table(1,1,2)/Trials_Table(2,1,2);
            end
        elseif Trial.FrontOrBack==2
            Trials_Table(2,2,2)= Trials_Table(2,2,2)+1; % Total Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,2,2)= Trials_Table(1,2,2)+1; % Correct Back
                Trials_Table(3,2,2)=Trials_Table(1,2,2)/Trials_Table(2,2,2);
            end
        end
        Trials_Table(1,3,2)=Trials_Table(1,1,2)+Trials_Table(1,2,2); % Total Correct
        Trials_Table(2,3,2)=Trials_Table(2,1,2)+Trials_Table(2,2,2); % Total Trials
        Trials_Table(3,3,2)=Trials_Table(1,3,2)/Trials_Table(2,3,2); % Total Accuracy
    elseif Trial.condition.x_stimulus==left_x % Left  Trial
        if Trial.FrontOrBack==1
            Trials_Table(2,1,1)= Trials_Table(2,1,1)+1; % Total Front Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,1,1)= Trials_Table(1,1,1)+1; % Correct Front
                Trials_Table(3,1,1)=Trials_Table(1,1,1)/Trials_Table(2,1,1);
            end
        elseif Trial.FrontOrBack==2
            Trials_Table(2,2,1)= Trials_Table(2,2,1)+1; % Total Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,2,1)= Trials_Table(1,2,1)+1; % Correct Back
                Trials_Table(3,2,1)=Trials_Table(1,2,1)/Trials_Table(2,2,1);
            end
        end
        Trials_Table(1,3,1)=Trials_Table(1,1,1)+Trials_Table(1,2,1); % Total Correct
        Trials_Table(2,3,1)=Trials_Table(2,1,1)+Trials_Table(2,2,1); % Total Trials
        Trials_Table(3,3,1)=Trials_Table(1,3,1)/Trials_Table(2,3,1); % Total Accuracy
    elseif Trial.condition.x_stimulus==right_x % Right Trial
        if Trial.FrontOrBack==1
            Trials_Table(2,1,3)= Trials_Table(2,1,3)+1; % Total Front Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,1,3)= Trials_Table(1,1,3)+1; % Correct Front
                Trials_Table(3,1,3)=Trials_Table(1,1,3)/Trials_Table(2,1,3);
            end
        elseif Trial.FrontOrBack==2
            Trials_Table(2,2,3)= Trials_Table(2,2,3)+1; % Total Trials
            if Response==Trial.FrontOrBack
                Trials_Table(1,2,3)= Trials_Table(1,2,3)+1; % Correct Back
                Trials_Table(3,2,3)=Trials_Table(1,2,3)/Trials_Table(2,2,3);
            end
        end
        Trials_Table(1,3,3)=Trials_Table(1,1,3)+Trials_Table(1,2,3); % Total Correct
        Trials_Table(2,3,3)=Trials_Table(2,1,3)+Trials_Table(2,2,3); % Total Trials
        Trials_Table(3,3,3)=Trials_Table(1,3,3)/Trials_Table(2,3,3); % Total Accuracy
    end
    end
end

