function  print_parameters_on_screen(design, SetUp_Info)

Window_Width=SetUp_Info.ScreenWidth_in_mm;
Window_Height= SetUp_Info.ScreenHeight_in_mm;
Window_Width_pixels = SetUp_Info.ScreenResolution.width;
Window_Height_pixels =SetUp_Info.ScreenResolution.height;

DistancetoStimulus= 570;
SizeofDisk= design.Disk_Radiuses_in_Scale;
SizeofDots=design.Dot_Radiuses_in_Scale;
DepthMagnitude=design.Depth_Magnitudes_in_Scale;
InnerRing=design.Ring_InnerRadiuses_in_Scale;
OuterRing=design.Ring_OuterRadiuses_in_Scale;
Fixation_Pixels_central=design.Fixation_center_xy_in_Pixel(1,1,2);
Fixation_Pixels_peripheral=design.Fixation_center_xy_in_Pixel(1,2,2);
Fixation_Pixels=[Fixation_Pixels_central, Fixation_Pixels_peripheral];

%% Calculate Pixels/Degree
deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * DistancetoStimulus)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 *DistancetoStimulus)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) 

%% Scale for Parameters 
% scale based on the Window Width in pixels 
% inputs in degrees
Scale.SizeofDots=(SizeofDots*pix_deg)/Window_Width_pixels
Scale.SizeofDisk=(SizeofDisk*pix_deg)/Window_Width_pixels
Scale.DepthMagnitude=(DepthMagnitude*pix_deg)/Window_Width_pixels

%% Distance Calculations
[scalelocations, PPD_offset, pixelLocations]=degreevisualanglecalc(5, pix_deg, pix_degree_width, pix_degree_height, Window_Width_pixels, InnerRing, OuterRing, Fixation_Pixels) 


