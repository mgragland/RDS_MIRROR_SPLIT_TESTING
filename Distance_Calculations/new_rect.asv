w = 1920; %RectWidth(SetUp_Info.Window_rectangle); 1920 
h = 1080; %RectHeight(SetUp_Info.Window_rectangle); 1080 
rect_half=w/2;
distance_observer_to_screen=570; 

% Calculations for pix_deg do not change because assumption is that screen
% is split in half for view for L and R eye 
Window_Width=698;   %SetUp_Info.ScreenWidth_in_mm; mm = 698 
Window_Height= 393; %SetUp_Info.ScreenHeight_in_mm; mm = 393 
Window_Width_pixels = 1920; %RectWidth(SetUp_Info.Window_rectangle); 1920 
Window_Height_pixels = 1080; %RectHeight(SetUp_Info.Window_rectangle); 1080 
deg_screen_width = rad2deg(2 * atan(Window_Width/ (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) %29 pixels 


%% Pixel Dimensions for Each Component of the Stereogram 
convert_10degree_stimlus=0.7143; % compatible with the FLAP stimulus; 0.85 is the largest stimuli can be 
DiskRadius= 159*convert_10degree_stimlus; %design.Disk_Radiuses_in_Pixel; % 159 
OuterRing= 207*convert_10degree_stimlus; % design.Ring_OuterRadiuses_in_Pixel; % 207
InnerRing= 163*convert_10degree_stimlus; %design.Ring_InnerRadiuses_in_Pixel; % 163 
Fixation_Pixels_right=[(1920/2+rect_half/2), 540]; %design.Reference_Display_location_xy_in_Pixel;
Fixation_Pixels_left=[rect_half/2, 540]; %design.Reference_Display_location_xy_in_Pixel;

% Degrees for stimuli size 
disk_radius_deg=DiskRadius/pix_deg; %5.4 degree
OuterRing_Deg=OuterRing/pix_deg; %7 degrees --> 5 degrees 
InnerRing_Deg=InnerRing/pix_deg; % 5 degrees 

% dot radius 
dot_radius=0.006*Window_Width_pixels;
dot_radius_degrees= dot_radius/pix_deg; %0.4 degree


%% DVA 
DVA=5; 
PPD_offset= DVA* pix_deg; %147.21 pixels 

% Left and Right Periphery (MGR CALCULATION) 
inferior_position_left= round(Fixation_Pixels_left(2) + OuterRing - InnerRing);
inferior_position_right= round(Fixation_Pixels_right(2) + OuterRing - InnerRing);
central_position_left= round(Fixation_Pixels_left(2) + OuterRing - ((OuterRing-InnerRing)/2));
central_position_right= round(Fixation_Pixels_right(2) + OuterRing - ((OuterRing-InnerRing)/2));


leftp_position_left= round(Fixation_Pixels_left(1)- PPD_offset - InnerRing);
leftp_position_right= round(Fixation_Pixels_right(1)- PPD_offset - InnerRing);
rightp_position_left= round(Fixation_Pixels_left(1)+ PPD_offset+InnerRing);
rightp_position_right= round(Fixation_Pixels_right(1)+ PPD_offset+InnerRing);


%% Create Stimuli for Graph Purposes
% Defining Pixel Coordinates 
inferiorleft=[Fixation_Pixels_left(1), inferior_position_left];
inferior_right=[Fixation_Pixels_right(1), inferior_position_right];
central_left=[Fixation_Pixels_left(1),central_position_left];
central_right=[Fixation_Pixels_right(1),central_position_right];
leftp_left=[leftp_position_left, Fixation_Pixels_left(2)];
leftp_right=[leftp_position_right, Fixation_Pixels_right(2)];
rightp_left=[rightp_position_left, Fixation_Pixels_left(2)];
rightp_right=[rightp_position_right, Fixation_Pixels_right(2)];


% inferior 
plotgrid_rect(inferiorleft, inferior_right, DiskRadius, InnerRing, OuterRing, rect_half, Fixation_Pixels_left, Fixation_Pixels_right, h)

% central 
plotgrid_rect(central_left, central_right, DiskRadius, InnerRing, OuterRing, rect_half, Fixation_Pixels_left, Fixation_Pixels_right, h)

% left
plotgrid_rect(leftp_left, leftp_right, DiskRadius, InnerRing, OuterRing, rect_half, Fixation_Pixels_left, Fixation_Pixels_right, h)

% right 
plotgrid_rect(rightp_left, rightp_right, DiskRadius, InnerRing, OuterRing, rect_half, Fixation_Pixels_left, Fixation_Pixels_right, h)
