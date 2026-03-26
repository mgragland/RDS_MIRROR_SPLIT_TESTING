Calculation_RDS_prompt={'PTB?', 'Display Width (mm)', 'Display Height (mm)', 'Display Width (pixels)', 'Display Height (pixels)', 'DVA (Distance to Stimulus)', 'Size of Inner Ring (radius)', 'Size of Outer Ring (radius)', 'Stimulus Center_X_scale', 'Stimulus Center_Y_scale', 'Distance from observer to screen'}
Calculation__RDS_dialog_title='Give_Exp_Information';
num_lines=1;
Calculation__RDS_default_answer={'no', '698', '393',  '1920', '1080', '5', '2.5', '4.3', '0', '0.094', '700'};
Calculation_RDS_info=inputdlg(Calculation_RDS_prompt,Calculation__RDS_dialog_title,num_lines,Calculation__RDS_default_answer);
Calculation_RDS_info=Calculation_RDS_info';
ptb = Calculation_RDS_info{1};

if strcmp(ptb, 'no')
    Window_Width= str2double(Calculation_RDS_info{2});
    Window_Height= str2double(Calculation_RDS_info{3});
    Window_Width_pixels= str2double(Calculation_RDS_info{4});
    Window_Height_pixels= str2double(Calculation_RDS_info{5});
    DistancetoStimulus= str2double(Calculation_RDS_info{6});
    InnerRing_Deg=  str2double(Calculation_RDS_info{7});
    OuterRing_Deg=str2double(Calculation_RDS_info{8});
    Stim_Center_X_scale=str2double(Calculation_RDS_info{9});
    Stim_Center_Y_scale=str2double(Calculation_RDS_info{10});
    distance_observer_to_screen= str2double(Calculation_RDS_info{11});

elseif strcmp(ptb, 'yes')
    PsychImaging('PrepareConfiguration');
    ScreenNumber = max(Screen('Screens'));
    ScreenResolution = Screen('Resolution', ScreenNumber);
    [ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
    Window_Width=ScreenWidth_in_mm;
    Window_Height= ScreenHeight_in_mm;
    Window_Width_pixels = ScreenResolution.width;
    Window_Height_pixels = ScreenResolution.height;
    DistancetoStimulus= str2double(Calculation_RDS_info{6});
    InnerRing_Deg=  str2double(Calculation_RDS_info{7});
    OuterRing_Deg=str2double(Calculation_RDS_info{8});
    Stim_Center_X_scale=str2double(Calculation_RDS_info{9});
    Stim_Center_Y_scale=str2double(Calculation_RDS_info{10});
    distance_observer_to_screen= str2double(Calculation_RDS_info{11});
end

%% Calculate Pixels/Degree
deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) 

%% Inner Ring and Outer Ring 
InnerRing_pix=InnerRing_Deg*pix_deg
OuterRing_pix=OuterRing_Deg*pix_deg

%% Stimulus Center Scale 
Stim_Center_X=Stim_Center_X_scale*Window_Width_pixels
Stim_Center_Y=Stim_Center_Y_scale*Window_Width_pixels

%% Calculate Fixation Pixel and Scale 
Fixation_Inferior= (InnerRing_pix) + (DVA*pix_deg); % offset from stim center
Fixation_Central= (OuterRing_pix) - ((OuterRing_pix-InnerRing_pix)/2); % offset from stim center


%% SCALE 
InnerRing_scale= InnerRing_pix/Window_Width_pixels
OuterRing_scale=OuterRing_pix/Window_Width_pixels
Fixation_Inferior_scale= Fixation_Inferior/Window_Width_pixels
Fixation_Central_scale=Fixation_Central/Window_Width_pixels