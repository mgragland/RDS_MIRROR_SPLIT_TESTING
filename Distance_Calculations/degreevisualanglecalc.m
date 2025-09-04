function [scalelocations, PPD_offset, pixelLocations]=degreevisualanglecalc(DVA, pix_deg, pix_degree_width, pix_degree_height, Window_Width_pixels, InnerRing, OuterRing, Fixation_Pixels) 
pixel_5_degree_horizontal=DVA* pix_degree_width;
pixel_5_degree_vertical=DVA* pix_degree_height;
PPD_offset= DVA* pix_deg; %147.21 pixels 

% Left and Right Periphery (MGR CALCULATION) 
right_pixel_position=round(Fixation_Pixels(1)+ PPD_offset+InnerRing);  % edge of the stereogram 
left_pixel_position=round(Fixation_Pixels(1)- PPD_offset - InnerRing);
central_position= round(Fixation_Pixels(2) + OuterRing - ((OuterRing-InnerRing)/2));

pixelLocations=[left_pixel_position,central_position,right_pixel_position];

scale_right= (PPD_offset+InnerRing)/Window_Width_pixels;
scale_left= (-1*PPD_offset - InnerRing)/Window_Width_pixels;
scale_center= (OuterRing - (OuterRing-InnerRing)/2)/Window_Width_pixels;


Stimulus_Right=[scale_right, 0];
Stimulus_Left=[scale_left, 0];
Stimulus_center= [0,scale_center];

scalelocations=[Stimulus_Left; Stimulus_center; Stimulus_Right];
end