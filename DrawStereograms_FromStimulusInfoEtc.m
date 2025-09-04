function Stereograms = DrawStereograms_FromStimulusInfoEtc(StimulusInfo, BlackColor, WhiteColor, Background_Color)
%This is modified from Drawn = DrawMoviePalette_FromStimulusInfoEtc.m version July 24, 2020, just removed mainly the bits to add the fixation cross and putting left and right eye imsages to the CRS pages. 


%
Ring_OuterRadius = StimulusInfo.condition.Ring_OuterRadius;
Dot_Radius = StimulusInfo.condition.Dot_Radius;



%--- ring stimulus
Paired_Ring_Dots_xy_MoviePages=StimulusInfo.Paired_Ring_Dots_xy_MoviePages;
Paired_Ring_Dots_color_MoviePages = StimulusInfo.Paired_Ring_Dots_color_MoviePages;
%--- disk stimulus
Disk_Dots_xy_MoviePages=StimulusInfo.Disk_Dots_xy_MoviePages;
Disk_Dots_color_MoviePages=StimulusInfo.Disk_Dots_color_MoviePages;
%--- Monocular dots between ring and disk
if StimulusInfo.condition.Add_UnPaired_Dots  ==1
         Gap_Ring_Dots_x_Moviepages=StimulusInfo.Gap_Ring_Dots_x_Moviepages;
         Gap_Ring_Dots_y_Moviepages=StimulusInfo.Gap_Ring_Dots_y_Moviepages;
         Gap_Ring_Dots_color_Moviepages=StimulusInfo.Gap_Ring_Dots_color_Moviepages;
end
ColorIndex = [BlackColor, WhiteColor];

%-------------
NMoviePages = length(Paired_Ring_Dots_color_MoviePages);
%--------------

for ThisPage = 1:NMoviePages 
    %--- make stimulusMatrix
    %%%%%%%%% plot dots, 
    %---
    %--- plot the common surround dots first to make a common stimulus matrix for the left and right eyes
    Paired_Ring_Dots_x = Paired_Ring_Dots_xy_MoviePages{ThisPage}(1, :);
    Paired_Ring_Dots_y = Paired_Ring_Dots_xy_MoviePages{ThisPage}(2, :);
    Dots_x_tem = double(Paired_Ring_Dots_x)  + Ring_OuterRadius;
    Dots_y_tem = double(Paired_Ring_Dots_y)  + Ring_OuterRadius;
    Color_Of_Dots = double(Paired_Ring_Dots_color_MoviePages{ThisPage});
    temMatrix = Background_Color *(ones(2*Ring_OuterRadius, 2*Ring_OuterRadius));   %--- initially blank
    %--- given initial matrix is temMatrix, given Dots_x_tem, Dots_y_tem, Color_Of_Dots , plot these dots in temMatrix
    temMatrix=Update_Matrix_By_Dots(temMatrix, Dots_x_tem, Dots_y_tem, Color_Of_Dots, 2*Dot_Radius, 2*Ring_OuterRadius,ColorIndex);
    %
    LeftEyeImage =  temMatrix;
    RightEyeImage = temMatrix;
    
    %--- now the disk dots
    Disk_Dots_x_All{1} = Disk_Dots_xy_MoviePages{ThisPage}(1, :);
    Disk_Dots_y_All{1} = Disk_Dots_xy_MoviePages{ThisPage}(2, :);
    Disk_Dots_x_All{2} = Disk_Dots_xy_MoviePages{ThisPage}(3, :);
    Disk_Dots_y_All{2} = Disk_Dots_xy_MoviePages{ThisPage}(4, :);
    Disk_Dots_color=  Disk_Dots_color_MoviePages{ThisPage};  
    for LeftOrRight =1:2
       %--- Now, shift the coordinate origin for all dots---
        Dots_x_tem = double(Disk_Dots_x_All{LeftOrRight}) +  Ring_OuterRadius;
        Dots_y_tem = double(Disk_Dots_y_All{LeftOrRight}) +  Ring_OuterRadius;
        Color_Of_Dots = double(Disk_Dots_color(LeftOrRight, :));
        %
        if LeftOrRight ==1
            LeftEyeImage=Update_Matrix_By_Dots(LeftEyeImage, Dots_x_tem, Dots_y_tem, Color_Of_Dots, 2*Dot_Radius, 2*Ring_OuterRadius,ColorIndex);
        else 
            RightEyeImage=Update_Matrix_By_Dots(RightEyeImage, Dots_x_tem, Dots_y_tem, Color_Of_Dots, 2*Dot_Radius, 2*Ring_OuterRadius,ColorIndex);
        end
    end
  
    %--- now the monocular surround dots if required.
    if StimulusInfo.condition.Add_UnPaired_Dots  ==1
        for LeftOrRight = 1:2  %--- for the left or right eye
            Dots_x_tem = double(Gap_Ring_Dots_x_Moviepages{ThisPage}{LeftOrRight})+ Ring_OuterRadius;
            if length(Dots_x_tem)>0
                Dots_y_tem = double(Gap_Ring_Dots_y_Moviepages{ThisPage}{LeftOrRight})+ Ring_OuterRadius;
                Color_Of_Dots = double(Gap_Ring_Dots_color_Moviepages{ThisPage}{LeftOrRight});
                if LeftOrRight ==1
                    LeftEyeImage=Update_Matrix_By_Dots(LeftEyeImage, Dots_x_tem, Dots_y_tem, Color_Of_Dots, 2*Dot_Radius, 2*Ring_OuterRadius,ColorIndex);
                else
                    RightEyeImage=Update_Matrix_By_Dots(RightEyeImage, Dots_x_tem, Dots_y_tem, Color_Of_Dots, 2*Dot_Radius, 2*Ring_OuterRadius,ColorIndex);
                end   
            end
        end
    end


    Stereograms(ThisPage).LeftEyeImage = LeftEyeImage;
    Stereograms(ThisPage).RightEyeImage = RightEyeImage;
 	
end
