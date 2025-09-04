function StimulusInfo = GetStimulusInfoFromConditionEtc(condition, FrontOrBack, RedColor, Background_Color, FrameRate)

x_stimulus= condition.x_stimulus;
y_stimulus = condition.y_stimulus;
x_fixation= condition.x_fixation;
y_fixation=condition.y_fixation;
FixationCross_Size=condition.FixationCross_Size;
x_fixation2=condition.x_fixation2;
y_fixation2=condition.y_fixation2;
FixationCross2_Size=condition.FixationCross2_Size;
Dot_Radius=condition.Dot_Radius;
Disk_Radius=condition.Disk_Radius;
Ring_OuterRadius=condition.Ring_OuterRadius;
Ring_InnerRadius=condition.Ring_InnerRadius;
CallNextTrial_x1=condition.CallNextTrial_x1;
CallNextTrial_y1=condition.CallNextTrial_y1;
CallNextTrial_x2=condition.CallNextTrial_x2;
CallNextTrial_y2=condition.CallNextTrial_y2;
PresentationPeriod=condition.PresentationPeriod;
PresentationDuration=condition.PresentationDuration;
Depth_Magnitude=condition.Depth_Magnitude;
Dot_Density=condition.Dot_Density;
Prob_DiskDotIsSameAcrossEyes=condition.Prob_DiskDotIsSameAcrossEyes;
Add_UnPaired_Dots=condition.Add_UnPaired_Dots;
Add_FixationCross = condition.Add_FixationCross;
Noise_Fraction=condition.Noise_Fraction;
Anti_Fraction=condition.Anti_Fraction;


%--- set up the basic page background if it is changed
% NMoviePages = PresentationDuration/PresentationPeriod;
% SetUpStimulusFixationPageWarningPage_Dynamic;
% if Lastx_fixation ~= x_fixation | Lasty_fixation ~= y_fixation | Last_FixationCross_Size ~=FixationCross_Size | ...
%         Lastx_fixation2 ~= x_fixation2 | Lasty_fixation2 ~= y_fixation2 | Last_FixationCross2_Size ~=FixationCross2_Size | ...
%          Last_NMoviePages ~= NMoviePages
% 
% end

%--- each dot is a square rather than a disk.

%--- calculate the amount of horizontal shifts of the central disk dots to obtain the depth.
Disk_Shifts = zeros(1, 2); %--- Disk_Shifts(i = 1, 2) is amount of shift of the central disk in the left and right eyes.
if mod(Depth_Magnitude, 2) ==0   %--- if Depth_Magnitude is even
    Disk_Shifts = Depth_Magnitude/2*ones(1, 2);  %--- same amount of shift in the two eyes.
else   %--- otherwise, randomly one of them shifts a bit more than the others in the number of pixels.
    temlist = [0, 1]; temlist = temlist(randperm(2));
    Disk_Shifts= floor(Depth_Magnitude/2)*ones(1, 2) +temlist; 
end
%--- shift the left and right eye dots in opposite directions, so make one of the Disk_Shifts negative depending on depth    
if FrontOrBack==1
    Disk_Shifts(2) = - Disk_Shifts(2);
else
    Disk_Shifts(1) = -Disk_Shifts(1);
end

%%%%%%%%%%%%%%% Set up the stimulus for the trial.
%
NMoviePages = PresentationDuration/PresentationPeriod;
NFrames = ceil(PresentationDuration*FrameRate);
NFrames_PerMoviePage = ceil(PresentationPeriod*FrameRate);
if NMoviePages -round(NMoviePages) ~=0
    error('NMoviePages is not an integer in GetTrialStimulusReady_Dynamic');
end
if NFrames ~= NMoviePages* NFrames_PerMoviePage 
    error('PresentationDuration and PresentationPeriod values are problematic in GetTrialStimulusReady_Dynamic');
end
%


%---- The central or surround dots are created by 
%-------  (1) first randomly generating dots within two disks, A and B, A has Radius = Disk_Radius, B has radius= Ring_OuterRadius.
%------------ A disk is for the central disk dots, B disk contains dots later used for surrounding dots in the surrounding ring.
%-------  (2) Each dot in each disk is assigned randomly to black or white color.
%------   (3) For the central disk dots, called Disk_Dots, given a dot in the left eye, the corresponding dot is having the same color (black or white) with a probability Prob_DiskDotIsSameAcrossEyes
%-------  (4) Shift the central disk dots by Disk_Shifts(1) or Disk_Shifts(2) for left eye or right eye dots, to create depth
%---------(5) For each eye, remove the dots in the B disk which are within the area of the shifted disk A for the central dots, the remaining dots
%                   of disk B for each eye are the ring dots for that eye. 
%---------(6) Some dots in the surrounding ring are binocular, they are called Paired_Ring_Dots, other dots in the surrounding ring are monocular, they are called 
%               Gap_Ring_Dots, they are near the outer edge of the Central Disk, and are absent when Add_UnPaired_Dots =0; All binocular ring dots are matched in color and position between eyes.
%---------(7) added July 2020, make a Noise_Fraction of disk dots as noisy dots, i.e., randomly assign them x, y positions independently between the eyes, in the central disk, they have no disparity
%              information, they retain their original color.
%---------(8) added July 2020, if Anti_Fraction is not equal to zero, then some dots among the noise dots will be assigned as anti dots, and their x-y locations and color are re-assigned. 
%-------------- so that (A) if their colors are matched between the two eyes, now they are anti-matched, and vice versa, this is done by randomly pick an eye, and change the color of that dot.
%-----------------------(B) if Anti_Fraction > 0, then the disparity of these anti-dots will be opposite of that of the signal dots, i.e., their x-y position will start by taking the original 
%                                xy positions in steps 1-4 above, and then revert the disparity shift. If Anti_Fraction < 0, then this disparity reverting step is skipped.



Disk_Dots_N_SignalDots_NoiseDots_AntiDots = zeros(NMoviePages, 3); %--- NoiseDots are those in the disk, not to be
%--- confused with UnPaired_Dots in the outer ring.

for ThisPage = 1:NMoviePages  %--- create NMoviePages of independent dichoptic images, they differ in terms of the random positions of the dots and randomly generated matches in the central dots.
    %---- start with initial dot xy locations and color (black or white) for the surround ring and center disk.
    for CentralOrSurround = 1:2   % 1 or 2 for central disk or surround ring.
        if CentralOrSurround ==1
            This_Radius  = Disk_Radius;
        else
            This_Radius  = Ring_OuterRadius;
        end 
        %--- set up the location of N_Dots, within the square box of 2*This_Radius
        N_Dots = round(pi*(This_Radius)^2/(2*Dot_Radius)^2 * Dot_Density);
        Dots_r = This_Radius*sqrt(rand(1, N_Dots));
        Dots_theta = 2*pi*rand(1, N_Dots); 
        Dots_x = round(Dots_r.* cos(Dots_theta));  %--- x coordinate of the dots
        Dots_y = round(Dots_r.* sin(Dots_theta));  %--- y coordinate of the dots
        % --- make sure that none of the dots occlude another
        for idot = 1:N_Dots
            Dot_x = Dots_x(idot); Dot_y = Dots_y(idot);
            %--- see if this dot occlude another
            Check_Occlusion = 0;
            while Check_Occlusion ==1
                Occlusion_List = find( abs(Dots_x -Dot_x)< 2*Dot_Radius &  abs(Dots_y -Dot_y)< 2*Dot_Radius );
                if sum(Occlusion_List>0)>1  %--- number of occluded dots, including self-occlusion, >1
                    Dot_r = This_Radius*sqrt(rand);
                    Dot_theta = 2*pi*rand; 
                    Dot_x = round(Dot_r* cos(Dot_theta));  %--- move the dot to another random location.
                    Dot_y = round(Dot_r* sin(Dot_theta));  %---  
                    Dots_x(idot) = Dot_x; Dots_y(idot) = Dot_y;
                else
                    Check_Occlusion =0;  %---  no occlusion, done!
                end
            end
        end
        %--- keep only the dots within the circle of This_Radius from the center of the outer ring
        Dots_Distances_ToCenter = sqrt(Dots_x.^2 + Dots_y.^2);
        Retained_Dots = find(Dots_Distances_ToCenter <This_Radius);
        if CentralOrSurround ==1  %--- Assign location and color to the central disk dots
            Disk_Dots = Retained_Dots;
            Disk_Dots_x  = Dots_x(Disk_Dots);
            Disk_Dots_y  = Dots_y(Disk_Dots);
            %--- color of the central disk dots
            Disk_Dots_color = zeros(2, length(Disk_Dots_x));  %
            Disk_Dots_color(1, :) = (rand(1, length(Disk_Dots_x))>0.5);  %--- 0 for black, 1 for white color of the dot in the left eye.
            SwitchColorAcrossEyes_Dots = (rand(1, length(Disk_Dots_x))>Prob_DiskDotIsSameAcrossEyes);    %--- 1 or 0 to switch or not switch color for the right eye.
            Dots_To_Switch_Color = find(SwitchColorAcrossEyes_Dots ==1);
            temlist = Disk_Dots_color(1,:);
            Ntem = length(Dots_To_Switch_Color);
            if Ntem >0  %--- switch color from black to white or from white to black among these dots.
                temlist(Dots_To_Switch_Color) = ones(1, Ntem) -temlist(Dots_To_Switch_Color);
            end
            Disk_Dots_color(2, :) = temlist;  %--- color of the dots in the right eye.
        else %--- surround ring dots.
            Ring_Dots = Retained_Dots;
            Ring_Dots_x  = Dots_x(Ring_Dots);
            Ring_Dots_y  = Dots_y(Ring_Dots);
            %----- Remove from surround ring dots those that are in the potential occluded locations, 
            for LeftOrRight = 1:2
                DiskCenter_x = Disk_Shifts(LeftOrRight); 
                DiskCenter_y = 0;
                Distances_ToDiskCenter = sqrt((Ring_Dots_x - DiskCenter_x).^2 + (Ring_Dots_y -DiskCenter_y).^2);
                Ring_Dots_OneEye{LeftOrRight} = find(Distances_ToDiskCenter >Ring_InnerRadius + 2*Dot_Radius);  %the margin of Dot_Radius is left to be safe
                %--- add the Border zone dots if they do not overlap with the central disk dots.
                Bordering_Dots =  find(Distances_ToDiskCenter >Ring_InnerRadius & Distances_ToDiskCenter <=Ring_InnerRadius + 2*Dot_Radius);
                ThisEye_Disk_Dots_x = Disk_Dots_x +Disk_Shifts(LeftOrRight);
                if length(Bordering_Dots)>0
                    Added_dots = [];
                    for bb = 1:length(Bordering_Dots)
                        Dot_x = Ring_Dots_x(Bordering_Dots(bb));  Dot_y = Ring_Dots_y(Bordering_Dots(bb));
                        Occluded_DiskDots = find(abs(ThisEye_Disk_Dots_x - Dot_x)< 2*Dot_Radius &  abs(Disk_Dots_y - Dot_y)<2*Dot_Radius);
                        if length(Occluded_DiskDots) ==0 %--- if this dot does not overlap with any Disk dots.
                            Added_dots = [Added_dots, Bordering_Dots(bb)];
                        end
                    end
                    Ring_Dots_OneEye{LeftOrRight} = [Ring_Dots_OneEye{LeftOrRight}, Added_dots];
                end
                
            end
            %--- Identify the common Ring dots between the two eyes
            Paired_Ring_Dots = intersect(Ring_Dots_OneEye{1}, Ring_Dots_OneEye{2});
            Paired_Ring_Dots_x = Ring_Dots_x(Paired_Ring_Dots);
            Paired_Ring_Dots_y = Ring_Dots_y(Paired_Ring_Dots);
            Paired_Ring_Dots_color = (rand(1, length(Paired_Ring_Dots))>0.5); %--- 0 for black, 1 for white color of the dot in the left eye.
            %--- unpaired, monocular surrounding ring dots
            if Add_UnPaired_Dots ==1
                for LeftOrRight = 1:2
                    temlist = Ring_Dots_OneEye{LeftOrRight};
                    Gap_Ring_Dots{LeftOrRight} =  temlist(find(ismember(temlist, Paired_Ring_Dots)==0));
                    if length(Gap_Ring_Dots{LeftOrRight})>0
                        Gap_Ring_Dots_x{LeftOrRight} = Ring_Dots_x(Gap_Ring_Dots{LeftOrRight});
                        Gap_Ring_Dots_y{LeftOrRight} = Ring_Dots_y(Gap_Ring_Dots{LeftOrRight});
                        Gap_Ring_Dots_color{LeftOrRight} = (rand(1, length(Gap_Ring_Dots{LeftOrRight}))>0.5);
                    else
                        Gap_Ring_Dots_x{LeftOrRight}=[];
                        Gap_Ring_Dots_y{LeftOrRight}=[];
                        Gap_Ring_Dots_color{LeftOrRight} =[];
                    end
                end
            end
            
        end
    end
    

    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %--- Do a bit more processing for the xy location and colors of the central dots, depending on the Noise_Fraction and Anti_Fraction
    %--- all central disk dots are paired between two eyes, choose a fraction of them to be unpaired, and move their positions randomly within the radius.
    %%%%%%%%%%%%%% First assign each dot to Signal, Noise, or Anti.
    N_DiskDots = length(Disk_Dots_x);
    N_NoiseDots = round(Noise_Fraction*N_DiskDots);
    N_SignalDots  = N_DiskDots - N_NoiseDots;
    %--- AntiDots	
    N_AntiDots =round(abs(Anti_Fraction)*N_DiskDots); %--- this is determined by absolute value of Anti_Fraction
    %--- take these N_AntiDots from among the N_NoiseDots, and reduce  N_NoiseDots accordingly 
    N_NoiseDots = N_NoiseDots - N_AntiDots;
    if N_NoiseDots <0
        error('N_NoiseDots is negative, inside GetTrialStimulusReady.m');
        return;
    end	
    %--- randomly pick N_NoiseDots among N_DiskDots to shift their positions in the two eyes in an independent and unpredictable manner.
    temlist = randperm(N_DiskDots);
    if N_NoiseDots > 0
        NoiseDot_list = temlist(1:N_NoiseDots); %--- the indices of the randomized dots.
    else
        NoiseDot_list = [];
    end
    %--- also for AntiDot_list
    if N_AntiDots>0    
        AntiDot_list = temlist((N_NoiseDots+1):(N_NoiseDots+ N_AntiDots)); %--- the indices of the anti dots.
    else
        AntiDot_list = [];
    end	
    %--- now the signal dots
    SignalDot_list = temlist((N_NoiseDots+ N_AntiDots+1):end);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
    %--- change the color of the AntiDot_list to update Disk_Dots_color.
    if N_AntiDots>0
        %--- Randomly pick left or right eye of each of these dots to flip its color
        RandomEyes = (rand(1, N_AntiDots) > 0.5)+1;  %--- randomly left or right eye picked
        Color_Of_TheseDots = Disk_Dots_color(:, AntiDot_list); %--- these have values 0 for black and 1 for white.
        for i = 1:N_AntiDots
            ThisEye = RandomEyes(i);
            %--- now flip its color
            Color_Of_TheseDots(ThisEye, i) = 1-Color_Of_TheseDots(ThisEye, i);
        end
        Disk_Dots_color(:, AntiDot_list) =  Color_Of_TheseDots;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %--- now assign dot locations for the center disk dots, depending on whether they are noise dots, add in the disparity shifts when needed.
    %--- These are then pu tin Disk_Dots_x_All and Disk_Dots_y_All, and these xy locations are not yet including the shift Ring_OuterRadius.
    for LeftOrRight = 1:2  %--- for the left or right eye
        %Dots_x_tem = Disk_Dots_x  + Disk_Shifts(LeftOrRight)+Ring_OuterRadius;
        %Dots_y_tem = Disk_Dots_y  + Ring_OuterRadius;
        %--- initialize the dots' x-y positiions as originally planned, coordinate origin at the disk center.
        Dots_x_tem = Disk_Dots_x;  
        Dots_y_tem = Disk_Dots_y;
        %--- first, re-assign the positions of the Noise dots in the NoiseDot_list, in the same coordinate system
        if N_NoiseDots > 0
            %--- among these dots, take those in the NoiseDot_list, and randomly put their location within the disk region.
            RandomDots_r  = Disk_Radius*sqrt(rand(1, N_NoiseDots));
            RandomDots_theta =  2*pi*rand(1, N_NoiseDots);
            RandomDots_x = round(RandomDots_r.* cos(RandomDots_theta));  %--- x coordinate of the random dots
            RandomDots_y = round(RandomDots_r.* sin(RandomDots_theta));  %--- x coordinate of the random dots
            Dots_x_tem(NoiseDot_list) = RandomDots_x;
            Dots_y_tem(NoiseDot_list) = RandomDots_y;
        end
        %----Second, the anti-dots, take the same or opposite disparity as the SignalDots, depending on the sign of Anti_Fraction
        if N_AntiDots>0
            if Anti_Fraction>0	
                WhichEye = 3-LeftOrRight;  %--- opposite disparity from the SignalDots.
            else
                WhichEye = LeftOrRight;    %--- same disparity as the SignalDots
            end
            Dots_x_tem(AntiDot_list) = Dots_x_tem(AntiDot_list) +  Disk_Shifts(WhichEye);
        else
            WhichEye=2; 
        end
        %--- Third, the signal dots, take the original disparity
        if length(SignalDot_list)>0
            Dots_x_tem(SignalDot_list) = Dots_x_tem(SignalDot_list) +  Disk_Shifts(LeftOrRight);
        end
        %----Now, save these Dots_x,y_tem locations as Disk_Dots_x,y_All, for each eye, since they are mostly not corresponding, 
        Disk_Dots_x_All{LeftOrRight} = Dots_x_tem;
        Disk_Dots_y_All{LeftOrRight} = Dots_y_tem;
    end
    
  
    
    % %     %%%%%%%%%%%% add the red fixation cross
    if Add_FixationCross ==1
        %--- make the fixation cross matrix
        FixationCrossMatrix = GetFixationMatrix(FixationCross_Size, RedColor, Background_Color); 
%         for LeftOrRight = 1:2
%             %--- add the fixation point to its location
%             centerx=TwoEyeCenters_X(LeftOrRight)+x_fixation;
%             centery= TwoEyeCenters_Y(LeftOrRight)+y_fixation;
%             crsDrawMatrixPalettised([centerx, centery], FixationCrossMatrix); 
%         end
        %--- add the second fixation cross if it is different from the first one.
        if x_fixation2 ~= x_fixation | y_fixation2 ~=y_fixation
            FixationCrossMatrix2 = GetFixationMatrix(FixationCross2_Size, RedColor, Background_Color);    
%             for LeftOrRight = 1:2
%                 %--- add the fixation point to its location
%                 centerx=TwoEyeCenters_X(LeftOrRight)+x_fixation2;
%                 centery= TwoEyeCenters_Y(LeftOrRight)+y_fixation2;
%                 crsDrawMatrixPalettised([centerx, centery], FixationCrossMatrix2); 
%             end
        else
            FixationCrossMatrix2 =[];
        end    
    else
        FixationCrossMatrix = [];
        FixationCrossMatrix2 = [];
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %--- Summarizing the variables for later recording.
    %----------- Dots for the central disk	
    Disk_Dots_color_MoviePages{ThisPage} =int8(Disk_Dots_color);   %Disk_Dots_color(1, :) and Disk_Dots_color(2,:) for the left and right eyes of ThisPage
    Disk_Dots_xy_MoviePages{ThisPage} = int16([Disk_Dots_x_All{1}; Disk_Dots_y_All{1}; Disk_Dots_x_All{2}; Disk_Dots_y_All{2}]);      %--- Disk_Dots_x_All{LeftOrRight} and Disk_Dots_y_All{LeftOrRight}, each is a 1-d array.
    Disk_Dots_NoiseDot_list_MoviePages{ThisPage} = int16(NoiseDot_list);
    Disk_Dots_AntiDot_list_MoviePages{ThisPage} = int16(AntiDot_list);
    Disk_Dots_N_SignalDots_NoiseDots_AntiDots(ThisPage, :) = [N_SignalDots, N_NoiseDots,  N_AntiDots];  	
    %	
    %---- Dots for the outer ring 
    Paired_Ring_Dots_color_MoviePages{ThisPage} =int8(Paired_Ring_Dots_color);  %--- this is a 1-d array, same for both eyes.
    Paired_Ring_Dots_xy_MoviePages{ThisPage} =int16([Paired_Ring_Dots_x; Paired_Ring_Dots_y]); %--- {[Paired_Ring_Dots_x and Paired_Ring_Dots_y, each is a 1-d array.
    %
    %--- UnPaired Dots.	
    if Add_UnPaired_Dots  ==1
        Gap_Ring_Dots_x_Moviepages{ThisPage}= {int16(Gap_Ring_Dots_x{1}), int16(Gap_Ring_Dots_x{2})};   % Gap_Ring_Dots_x{LeftOrRight} for LeftOrRight = 1, 2 for left and right eyes.
        Gap_Ring_Dots_y_Moviepages{ThisPage}={int16(Gap_Ring_Dots_y{1}), int16(Gap_Ring_Dots_y{2})};   % Gap_Ring_Dots_y{LeftOrRight} for LeftOrRight = 1, 2 for left and right eyes.
        Gap_Ring_Dots_color_Moviepages{ThisPage}={int8(Gap_Ring_Dots_color{1}), int8(Gap_Ring_Dots_color{2})}; % Gap_Ring_Dots_Color{LeftOrRight} for LeftOrRight = 1, 2 for left and right eyes.
    end
    %TwoEyeImages_MoviePages{ThisPage} = {LeftEyeImage, RightEyeImage}; %--- this is taken out Sep. 26, 2019, as it is taking too much memory space
    
end

%---- save in the StimulusInfo
StimulusInfo.Disk_Dots_color_MoviePages=Disk_Dots_color_MoviePages;
StimulusInfo.Disk_Dots_xy_MoviePages =Disk_Dots_xy_MoviePages;
StimulusInfo.Disk_Dots_NoiseDot_list_MoviePages = Disk_Dots_NoiseDot_list_MoviePages;
StimulusInfo.Disk_Dots_AntiDot_list_MoviePages = Disk_Dots_AntiDot_list_MoviePages;
StimulusInfo.Disk_Dots_N_SignalDots_NoiseDots_AntiDots = Disk_Dots_N_SignalDots_NoiseDots_AntiDots;
%
StimulusInfo.Paired_Ring_Dots_color_MoviePages=Paired_Ring_Dots_color_MoviePages;
StimulusInfo.Paired_Ring_Dots_xy_MoviePages =Paired_Ring_Dots_xy_MoviePages;
%
%StimulusInfo.TwoEyeImages_MoviePages = TwoEyeImages_MoviePages; %--- this is taken out Sep. 26, 2019, as it is taking too much memory space
if Add_UnPaired_Dots  ==1
    StimulusInfo.Gap_Ring_Dots_x_Moviepages = Gap_Ring_Dots_x_Moviepages;
    StimulusInfo.Gap_Ring_Dots_y_Moviepages = Gap_Ring_Dots_y_Moviepages;
    StimulusInfo.Gap_Ring_Dots_color_Moviepages = Gap_Ring_Dots_color_Moviepages;
end
StimulusInfo.Disk_Shifts=Disk_Shifts;  
StimulusInfo.FixationMatrice{1} = FixationCrossMatrix;
StimulusInfo.FixationMatrice{2} = FixationCrossMatrix2;
%
StimulusInfo.condition = condition;
StimulusInfo.FrontOrBack = FrontOrBack;
%
StimulusInfo.NFrames =NFrames;
StimulusInfo.NFrames_PerMoviePage=NFrames_PerMoviePage;
StimulusInfo.NMoviePages = NMoviePages;
StimulusInfo.FrameRate = FrameRate;
StimulusInfo.DebugEuye=LeftOrRight;
StimulusInfo.WhichEye= WhichEye; 
StimulusInfo.Disk_shifts2= Disk_Shifts(WhichEye);




