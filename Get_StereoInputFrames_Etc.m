
function  [StereoInputFrames,  fixationFrame_pt] = ...
    Get_StereoInputFrames_Etc(design, SetUp_Info, condition, Stereograms, MaskInfo)

stimulus_center.x = condition.x_stimulus;
stimulus_center.y = condition.y_stimulus;
x_fixation= condition.x_fixation;
y_fixation=condition.y_fixation;
Window_ID= SetUp_Info.Window_ID;
GrayColor  = SetUp_Info.GrayColor;
WhiteColor  = SetUp_Info.WhiteColor;
BlackColor  = SetUp_Info.BlackColor;
nFramesEachTrial=condition.PresentationDuration/condition.PresentationPeriod;
FixationCross_Size = design.FixationCross_Size_in_Pixel;
x_fixation2= condition.x_fixation2;
y_fixation2=condition.y_fixation2;
Add_FixationCross = condition.Add_FixationCross;

%--- Fixation Frames
[FixationFrameMatrix3D,  fixationFrame_pt, stimulus_center_x, stimulus_center_y] = ...
    Prepare_ScreenAndDisplay_Parameters(design, SetUp_Info, stimulus_center.x, stimulus_center.y, x_fixation, y_fixation);
% 
%  for i = 1:nFramesEachTrial
%     for j = 1:2
%         WholeFrame_Stereograms(i, j, :, :, :) = FixationFrameMatrix3D;
%     end
% end

[WholeFrame_Stereograms StereoInputFrames] = Get_WholeFrame_Stereograms(Stereograms, ...
    stimulus_center.x, stimulus_center.y, ...
    FixationFrameMatrix3D, GrayColor, ...
    x_fixation, y_fixation, x_fixation2, y_fixation2, ...
    design.FixationCross_Matrix3D, Add_FixationCross);
  
% Old snippet, speed improved below.
% for frame = 1:nFramesEachTrial
%     for LeftOrRight = 1:2
%         StereoInputFrames{frame,LeftOrRight}  =  shiftdim(squeeze(WholeFrame_Stereograms(frame, LeftOrRight, :, :, :)),1);
%     end
% end

% StereoInputFrames2 = cell(nFramesEachTrial,2);
% elements_logical = logical(ones(nFramesEachTrial,2));
% StereoInputFrames2(elements_logical) =  {shiftdim(squeeze(WholeFrame_Stereograms(nFramesEachTrial, 2, :, :, :)),1);};
% 
% StereoInputFrames3 = cell(nFramesEachTrial,2);
% for frame = 1:nFramesEachTrial
%     for LeftOrRight = 1:2
%         StereoInputFrames3{frame,LeftOrRight}  =  shiftdim(squeeze(WholeFrame_Stereograms(frame, LeftOrRight, :, :, :)),1);
%     end
% end
% 
% StereoInputFrames4 = num2cell(WholeFrame_Stereograms,[3 4 5]);
if design.Add_Mask ==1 %--- add another frame to contain the mask
    Mask_Matrix = Get_MaskMatrix_FromMaskInfoAndBlackWhiteBackgroundColors(MaskInfo, ...
        SetUp_Info.BlackColor, SetUp_Info.WhiteColor, SetUp_Info.GrayColor);
    WholeFrame_WithMaskMatrix_3D  = FixationFrameMatrix3D;
    x1 = floor(stimulus_center.x-condition.Ring_OuterRadius);
    x2 =  round(x1 + 2*condition.Ring_OuterRadius -1);
    y1 = floor(stimulus_center.y-condition.Ring_OuterRadius);
    y2 =  round(y1+  2* condition.Ring_OuterRadius-1);
    for i=1:3
        WholeFrame_WithMaskMatrix_3D(i, y1:y2, x1:x2) = Mask_Matrix;
    end
    frame = nFramesEachTrial+1;
    for LeftOrRight = 1:2
        StereoInputFrames{frame,LeftOrRight}  =  shiftdim(WholeFrame_WithMaskMatrix_3D,1);
    end
end


