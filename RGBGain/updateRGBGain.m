function updateRGBGain(window, leftredGain, leftgreenGain, leftblueGain, rightredGain, rightgreenGain, rightblueGain, size_window)
WhiteColor =  WhiteIndex(window);
BlackColor =  BlackIndex(window);
GrayColor =   round(WhiteColor+BlackColor)/2;
Background_ColorVector = GrayColor*[1, 1, 1];
StereoMode=8; 
%% Set up Anaglyph Display
PsychImaging('PrepareConfiguration');
ptb_drawformattedtext_oversize = 2;
PsychImaging('AddTask', 'LeftView', 'DisplayColorCorrection', 'SimpleGamma');
PsychImaging('AddTask', 'RightView', 'DisplayColorCorrection', 'SimpleGamma');

if StereoMode==8
 SetAnaglyphStereoParameters('StandardMode', window); %--- this is standard, depending on the StereoMode
 SetAnaglyphStereoParameters('LeftGains', window,  [leftredGain, leftgreenGain, leftblueGain]);
 SetAnaglyphStereoParameters('RightGains', window, [rightredGain, rightgreenGain, rightblueGain]);
end
 
word_list= {'DOG' 'CAT'};
 Depth_Sign_list  = [0, 1, -1];
 for LeftOrRight =1:2
     Screen('SelectStereoDrawBuffer', window, LeftOrRight-1);
     Screen('TextSize', window, 200);
     if LeftOrRight ==1
         for i = 1
             DrawFormattedText(window, word_list{1}, size_window(1)/2, size_window(2), BlackColor); %left= DOG
         end
     else
         Depth_Sign_list = Depth_Sign_list(randperm(3));
         for i = 1
             DrawFormattedText(window, word_list{2}, size_window(1)/2+ 3*Depth_Sign_list(i)*0.002, size_window(2), BlackColor); %right=CAT
         end
     end
 end
 Screen('DrawingFinished', window, 2);
 Screen('Flip', window);
end

