% Open PTB window 
Viewing_Distance_in_mm = 570; 
ScreenNumber = max(Screen('Screens'));
ScreenResolution = Screen('Resolution', ScreenNumber);
[ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
StereoMode = 8;
size_window=[ScreenWidth_in_mm, ScreenHeight_in_mm];
satisfied=0;

% Colors 
WhiteColor =  WhiteIndex(ScreenNumber);
BlackColor =  BlackIndex(ScreenNumber);
GrayColor =   round(WhiteColor+BlackColor)/2;
Background_ColorVector = GrayColor*[1, 1, 1];



Screen('Preference', 'SkipSyncTests', 1)
[window, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
    [0 0 round(ScreenResolution.width*0.5), round(ScreenResolution.height*0.8)], [], [], StereoMode);



%% Create GUI with Sliders for RGB Gain Adjustment 

% Create GUI 
f= uifigure('Position', [1500,100,300,700], 'Name', 'RGB Gain Adjuster');

%% Create Sliders for Red, Green, Blue 
% Left Eye 
redSlider_left= uislider(f, 'Position', [20,600,250,3], 'Limits', [0,1], 'Value', 1)
greenSlider_left= uislider(f, 'Position', [20,500,250,3], 'Limits', [0,1], 'Value', 1)
blueSlider_left= uislider(f, 'Position', [20,400,250,3], 'Limits', [0,1], 'Value', 1)

% Right Eye 
redSlider_right= uislider(f, 'Position', [20,300,250,3], 'Limits', [0,1], 'Value', 1)
greenSlider_right= uislider(f, 'Position', [20,200,250,3], 'Limits', [0,1], 'Value', 1)
blueSlider_right= uislider(f, 'Position', [20,100,250,3], 'Limits', [0,1], 'Value', 1)

%% Create Labels for Each Slider 
% Left Eye 
redLabel_left = uilabel(f, 'Position', [20, 620, 100, 20], 'Text', ' Left Red Gain');
greenLabel_left = uilabel(f, 'Position', [20,520, 100, 20], 'Text', 'Left Green Gain');
blueLabel_left = uilabel(f, 'Position', [20, 420, 100, 20], 'Text', 'Left Blue Gain');

% Right Eye 
redLabel_right = uilabel(f, 'Position', [20, 320, 100, 20], 'Text', 'Right Red Gain');
greenLabel_right = uilabel(f, 'Position', [20, 220, 100, 20], 'Text', 'Right Green Gain');
blueLabel_right = uilabel(f, 'Position', [20, 120, 100, 20], 'Text', 'Right Blue Gain');

%% Callback Function for Sliders 
addlistener(redSlider_left, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));
addlistener(greenSlider_left, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));
addlistener(blueSlider_left, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));

addlistener(redSlider_right, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));
addlistener(greenSlider_right, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));
addlistener(blueSlider_right, 'ValueChanged', @(src, event) updateRGBGain(window, redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value, size_window));



%% Check if window needs to be closed 
keyIsDown =0;
FlushEvents;
while keyIsDown==0   %While waiting for button response.
    [keyIsDown,timeSecs,keyCode] = KbCheck;  %Check response
    pause(0.001);
end
R= KbName(keyCode);
if strcmp(R, 'RightArrow') ==1
   satisfied =1;
end
disp(R);
FlushEvents;
pause(0.2);
FlushEvents;

GainValues=[redSlider_left.Value, greenSlider_left.Value, blueSlider_left.Value, redSlider_right.Value, greenSlider_right.Value, blueSlider_right.Value]

if satisfied==1
    Screen('CloseAll')
end
