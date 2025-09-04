plot= 1; 

Window_Width=698;   %SetUp_Info.ScreenWidth_in_mm; mm = 698 
Window_Height= 393; %SetUp_Info.ScreenHeight_in_mm; mm = 393 
Window_Width_pixels = 1920; %RectWidth(SetUp_Info.Window_rectangle); 1920 
Window_Height_pixels = 1080; %RectHeight(SetUp_Info.Window_rectangle); 1080 
%distance_observer_to_screen=570; % our distance is 570 
distance_observer_to_screen=700; % our viewing distance is 570 BUT FLAP
% hardcode= 70cm 

% Zhaoping's Calculation 
% screen_deg = atand([Window_Width Window_Height]./(distance_observer_to_screen.*2)).*2;  % Screen size in degrees (inverse tangent function)
% pix_deg= mean([Window_Width_pixels/screen_deg(1) Window_Height_pixels/screen_deg(2)]);

% MGR calculation for pixel/ degree (5 Degrees) 
deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) % 29 pixels--> FLAP= 33.6063 degrees (used in data) PRLecc= 7.5 

%%
% FLAP calculations 
v_d=70; % hardcoded 
screencm= [69.8, 40];  % hardcoded 
wRect=[0,0,1920,1080]; 
pix_deg_FLAP=1./((2*atan((screencm(1)/wRect(3))./(2*v_d))).*(180/pi));
pix_deg_FLAP_vert = pi * wRect(4) / atan(screencm(2)/v_d/2) / 360;

%% Pixel Dimensions for Each Component of the Stereogram 
DiskRadius= 159; %design.Disk_Radiuses_in_Pixel; % 159 
OuterRing= 207; % design.Ring_OuterRadiuses_in_Pixel; % 207
InnerRing= 163; %design.Ring_InnerRadiuses_in_Pixel; % 163 
Fixation_Pixels=[960 540]; %design.Reference_Display_location_xy_in_Pixel;
Fixation_Scale=Fixation_Pixels/Window_Width_pixels;
dot_radius=0.006*Window_Width_pixels;
dot_radius_degrees= dot_radius/pix_deg;

% Degrees for stimuli size 
disk_radius_deg=DiskRadius/pix_deg; %5.4 degree
OuterRing_Deg=OuterRing/pix_deg; %7 degrees 
InnerRing_Deg=InnerRing/pix_deg; % 5 degrees 

%% Convert 5 Degrees to Number of Pixels 

%[scale_right, scale_left, scale_center]=degreevisualanglecalc(DVA, pix_degree_width, pix_degree_height, Window_Width_pixels, InnerRing, OuterRing, Fixation_Pixels) 
[scalelocations, PPD_offset, pixelLocations]=degreevisualanglecalc(5, pix_deg, pix_degree_width, pix_degree_height, Window_Width_pixels, InnerRing, OuterRing, Fixation_Pixels) 
[scalelocations_FLAP, PPD_offset, pixelLocations]=degreevisualanglecalc(5, pix_deg_FLAP, pix_degree_width, pix_degree_height, Window_Width_pixels, InnerRing, OuterRing, Fixation_Pixels) 

%% Plotting:  
if plot==1; 
%function plotgrid(center_x, center_y, disk_radius, inner_ring_radius, outer_ring_radius, fixation_x, fixation_y)
figure
plotgrid(pixelLocations(3),Fixation_Pixels(2), DiskRadius, InnerRing, OuterRing, Fixation_Pixels(1),Fixation_Pixels(2), PPD_offset, 2, pix_deg_FLAP)

figure 
plotgrid(Fixation_Pixels(1),pixelLocations(2), DiskRadius, InnerRing, OuterRing, Fixation_Pixels(1),Fixation_Pixels(2), PPD_offset, 1, pix_deg_FLAP)

figure 
plotgrid(pixelLocations(1),Fixation_Pixels(2), DiskRadius, InnerRing, OuterRing, Fixation_Pixels(1),Fixation_Pixels(2), -1*PPD_offset, 2, pix_deg_FLAP)
end




%% Extra Calculations 
% Left and Right Periphery (Zhaoping Default Parameter) 
pixels_ZP= round(0.198*Window_Width_pixels); %380 pixels = 12.9 degrees 
pixels_MGR= round(0.0796*Window_Width_pixels); %310 pixels = 10 degrees 
total_deg=pixels_MGR/pix_deg; %5 degrees 
%pixels_MGR= round(0.1616*Window_Width_pixels); %310 pixels = 10 degrees 
pix_off_ZP=(pixels_ZP- InnerRing)/pix_deg; % 7 degrees 
%pix_off_MGR=(pixels_MGR- InnerRing)/pix_deg %4.99 ~ 5 degrees 

%% mm to pixels 
Number_pixels_mm= Window_Width_pixels/Window_Width; 
inches_to_mm_10= 4.5*25.4; 
pixels_mm= inches_to_mm_10*Number_pixels_mm;
PPD_offset_10= 10*pix_deg;


Number_pixels_mm= Window_Width_pixels/Window_Width; 
inches_to_mm_5= 2.15*25.4; 
pixels_mm_5= inches_to_mm_5*Number_pixels_mm;
PPD_offset_5= 5*pix_deg;

%% Old Calculations Right Periphery --> OLD CODE 
% x1_peripheral_right = floor(Fixation_Pixels(1) + PPD_offset+InnerRing);
% x2_peripheral_right = x1_peripheral_right+2*(OuterRing)-1;
% disk_center_oldcalc_periphery_right=(x1_peripheral_right+x2_peripheral_right)/2;
% %% Old Calculations Central--> OLD CODE 
% y1_central = floor(Fixation_Pixels(2)+ DiskRadius - OuterRing+ 0.5*(OuterRing- InnerRing));
% y2_central = Fixation_Pixels(2)+(2*OuterRing)-1;
% disk_center_oldcalc_central=(y1_central+y2_central)/2;


%% Calculations from Zhaoping's Code 
% leftperiphery_scale=design.Stimulus_center_xy_in_Scale(1,:);
% center_scale=design.Stimulus_center_xy_in_Scale(2,:);
% rightperiphery_scale=design.Stimulus_center_xy_in_Scale(3,:);
% leftperiphery_pixels=design.Stimulus_center_xy_in_Pixel(1,:);
% center_pixels=design.Stimulus_center_xy_in_Pixel(2,:);
% rightperiphery_pixels=design.Stimulus_center_xy_in_Pixel(3,:);
% need to figure out when design.Stimulus_center_xy_in_Pixel

% %% Location of Stereogram on the screen: 
% Stereogram_Width = 2*design.Ring_OuterRadiuses_in_Pixel; %207
% x_stimuluscenter_left= leftperiphery_pixels(1);
% x_stimuluscenter_right= rightperiphery_pixels(1)
% x1 = floor(x_stimuluscenter-Stereogram_Width/2);
% x2 =  round(x1 + Stereogram_Width -1);
% leftperiphery_pixel_5DVA=round(Fixation_Pixels(1)+pixel_5_degree_horizontal);
% % design.x_stimulus_width_in_Pixel = 2*design.Ring_OuterRadiuses_in_Pixel;

%% Depth Calculation 
Depth_Magnitude_Scale= 0.002;
Depth_Mag_Pixels= Depth_Magnitude_Scale*Window_Width_pixels; 
Depth_Mag_DVA= Depth_Mag_Pixels/pix_deg;

DiskShifts= 2; 
DiskShift_DVA=2/pix_deg;

% Ideal Disk Shift 
ZP_paper= 0.087*pix_deg; %2.5616
DepthMag_ZP=(ZP_paper*2)/Window_Width_pixels;

pixels_depth=0.087*pix_deg;
pixels_depth_scale= pixels_depth/Window_Width_pixels;


% previous paper depth magnitude= 0.087 degrees 
