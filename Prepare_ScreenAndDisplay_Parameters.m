function [FixationFrameMatrix3D,  fixationFrame_pointer stimulus_center_x, stimulus_center_y] = ...
    Prepare_ScreenAndDisplay_Parameters(design, SetUp_Info,  stimulus_center_x, stimulus_center_y, x_fixation, y_fixation)

Window_ID= SetUp_Info.Window_ID;
Window_rectangle = SetUp_Info.Window_rectangle;
GrayColor  = SetUp_Info.GrayColor;
WhiteColor  = SetUp_Info.WhiteColor;
BlackColor  = SetUp_Info.BlackColor;

%--- vergence/fixation frame
%--- first make the vergence as the background gray.
vergenceFrameMatrix =GrayColor*ones(RectHeight(Window_rectangle), RectWidth(Window_rectangle));
%--- then draw the rectangular black
y1 = stimulus_center_y-design.vergenceFrameRect_Height_in_Pixel/2+1;
y2 = stimulus_center_y+design.vergenceFrameRect_Height_in_Pixel/2;
x1 = stimulus_center_x-design.vergenceFrameRect_Width_in_Pixel/2+1;
x2 = stimulus_center_x+design.vergenceFrameRect_Width_in_Pixel/2;

%disp([x1, x2, y1, y2]);
vergenceFrameMatrix(y1:y2, x1:x2) =  BlackColor*ones(design.vergenceFrameRect_Height_in_Pixel, design.vergenceFrameRect_Width_in_Pixel);
%--- then draw the inside of this rectangular black as gray
y1 = y1+design.vergenceFrameRect_LineWidth_in_Pixel;
y2 = y2-design.vergenceFrameRect_LineWidth_in_Pixel;
x1 = x1+design.vergenceFrameRect_LineWidth_in_Pixel;
x2 = x2-design.vergenceFrameRect_LineWidth_in_Pixel;
vergenceFrameMatrix(y1:y2, x1:x2) = GrayColor*ones(design.vergenceFrameRect_Height_in_Pixel-2*design.vergenceFrameRect_LineWidth_in_Pixel, ...
    design.vergenceFrameRect_Width_in_Pixel-2*design.vergenceFrameRect_LineWidth_in_Pixel);

vergenceFrameMatrix3D =zeros(3, size(vergenceFrameMatrix, 1), size(vergenceFrameMatrix, 2));
for item = 1:3
    vergenceFrameMatrix3D(item, :, :) =vergenceFrameMatrix;
end
for LeftOrRight = 1:2
    Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
    %vergenceFrame_pt{LeftOrRight} =Screen('MakeTexture', Window_ID, vergenceFrameMatrix);
    vergenceFrame_pt{LeftOrRight} =Screen('MakeTexture', Window_ID, shiftdim(vergenceFrameMatrix3D,1));
    Screen('DrawTexture', Window_ID, vergenceFrame_pt{LeftOrRight});
end
%Screen('Flip', Window_ID);

%--- fixation frames
FixationFrameMatrix3D = vergenceFrameMatrix3D;
for item = 1:3
    %--- add fixation point
    x1 = x_fixation - design.FixationCross_Size_in_Pixel/2;
    x2 = x1 +  design.FixationCross_Size_in_Pixel -1;
    y1 = y_fixation - design.FixationCross_Size_in_Pixel/2;
    y2 = y1 +  design.FixationCross_Size_in_Pixel -1;
    FixationFrameMatrix3D(item, y1:y2, x1:x2) = design.FixationCross_Matrix3D(item, :, :);
end

for LeftOrRight = 1:2
    Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
    fixationFrame_pointer{LeftOrRight} = ...
        Screen('MakeTexture', Window_ID, shiftdim(FixationFrameMatrix3D,1));
    
end


