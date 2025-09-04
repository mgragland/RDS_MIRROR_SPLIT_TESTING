%--
function  [WholeFrame_Stereograms, StereoInputFrames_cell] = Get_WholeFrame_Stereograms(Stereograms, ... 
			x_stimuluscenter, y_stimuluscenter, ...
    			FixationFrameMatrix3D, GrayColor, ... 
    			x_fixation, y_fixation, x_fixation2, y_fixation2, ...
			FixationCross_Matrix3D, Add_FixationCross)

WholeFrame_Stereograms = 1;
Fixation_Values = [x_fixation, y_fixation; ...
		   x_fixation2, y_fixation2];

CentralOrPeripheral=1;
if x_fixation~=x_fixation2 || y_fixation~=y_fixation2
	CentralOrPeripheral=2;
end


nFramesEachTrial =length(Stereograms);

%used before repmat
%WholeFrame_Stereograms = GrayColor*ones(nFramesEachTrial, 2, 3, WholeFrameHeight, WholeFrameWidth); %--- 2 is for Left or Right eyes (1 or 2), and 3 is for r, g, b color channels

% WholeFrame_Stereograms_part(1, 1, :, :, :) = FixationFrameMatrix3D;
% WholeFrame_Stereograms= repmat(WholeFrame_Stereograms_part, i, j);
%old version of code segment before repmat
%  for i = 1:nFramesEachTrial
%     for j = 1:2
%         WholeFrame_Stereograms(i, j, :, :, :) = FixationFrameMatrix3D;
%     end
%  end


Stereogram_Height = size(Stereograms(1).LeftEyeImage, 1); %--- width and height should be even numbers
Stereogram_Width = size(Stereograms(1).LeftEyeImage, 2); %--- width and height should be even numbers

%%inserting cell stuff

StereoInputFrames_cell = cell(nFramesEachTrial,2);
%elements_logical = logical(ones(nFramesEachTrial,2));
%StereoInputFrames_cell(elements_logical) =  {shiftdim(squeeze(WholeFrame_Stereograms(nFramesEachTrial, 2, :, :, :)),1);};
FixationModMatrix3d_L = FixationFrameMatrix3D;
FixationModMatrix3d_R = FixationFrameMatrix3D;



%%


for ThisPage = 1:nFramesEachTrial  
   
    x1 = floor(x_stimuluscenter-Stereogram_Width/2);
    x2 =  round(x1 + Stereogram_Width -1);
    y1 = floor(y_stimuluscenter-Stereogram_Height/2);
    y2 =  round(y1+  Stereogram_Height-1);
    for rgb = 1:3
        for LeftOrRight = 1:2
            if LeftOrRight ==1
%                 WholeFrame_Stereograms(ThisPage, LeftOrRight, rgb, y1:y2, x1:x2) = Stereograms(ThisPage).LeftEyeImage;
                FixationModMatrix3d_L(rgb,y1:y2, x1:x2) = Stereograms(ThisPage).LeftEyeImage;
            else
%                 WholeFrame_Stereograms(ThisPage, LeftOrRight, rgb, y1:y2, x1:x2) = Stereograms(ThisPage).RightEyeImage;
                FixationModMatrix3d_R(rgb,y1:y2, x1:x2) = Stereograms(ThisPage).RightEyeImage;
            end
        end
    end
    %     %%%%%%%%%%%% add the red fixation cross
    %AddFixation = 1;
    if Add_FixationCross ==1
      for NumFixation = 1:CentralOrPeripheral
        x_fixation = Fixation_Values(NumFixation, 1);
        y_fixation = Fixation_Values(NumFixation, 2);
        FixationCross_Size = size(FixationCross_Matrix3D, 2);
        %--- add to the left and right images
        x1 = floor(x_fixation -FixationCross_Size/2);
        x2 = x1+ FixationCross_Size-1;
        y1 = floor(y_fixation -FixationCross_Size/2);
        y2 = y1+ FixationCross_Size-1;
        %for rgb = 1:3
            for LeftOrRight = 1:2
                %FixationCrossMatrix = GetFixationMatrix(FixationCross_Size, FixationCross_RGB(rgb)*(WhiteColor-BlackColor) + BlackColor, GrayColor);
%                 WholeFrame_Stereograms(ThisPage, LeftOrRight, :, y1:y2, x1:x2) = FixationCross_Matrix3D;
          
            end
            %%Modify cell data here
            FixationModMatrix3d_L(:, y1:y2, x1:x2) = FixationCross_Matrix3D;
            FixationModMatrix3d_R(:, y1:y2, x1:x2) = FixationCross_Matrix3D;
            StereoInputFrames_cell(ThisPage, 1) = {shiftdim(FixationModMatrix3d_L,1)};
            StereoInputFrames_cell(ThisPage, 2) = {shiftdim(FixationModMatrix3d_R,1)};
           
            %%end this
        %end
      end
    end
end


