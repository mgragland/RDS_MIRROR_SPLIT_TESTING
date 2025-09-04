function   SetUp_Info = Get_SetUp_Info(use_default_or_review)
Display_Setup_prompt = {'Enter 1 or 2 for debug mode (using part screen) or whole screen mode', ...
                           ' enter the viewing distance in mm (give integer numbers) ', ...
                        };
dialog_title='Debug/whole screen mode and viewing distance';
num_lines=1;
Display_Setup_default_answer={'2', '570'};
if use_default_or_review~=1
	DisplaySetUp_info=inputdlg(Display_Setup_prompt, dialog_title,num_lines, Display_Setup_default_answer);
else
	DisplaySetUp_info=Display_Setup_default_answer;
end
%
Debug_Or_Whole_Screen = str2num(DisplaySetUp_info{1});
Viewing_Distance_in_mm = str2num(DisplaySetUp_info{2});
% Stereo_Color_Gain_Vectors(1, :) = str2num(DisplaySetUp_info{3});
% Stereo_Color_Gain_Vectors(2, :) = str2num(DisplaySetUp_info{4});

SetUp_Info= initializePtbStereo(Debug_Or_Whole_Screen, Viewing_Distance_in_mm);

