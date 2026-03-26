%%
distance_observer_to_screen=570; %cm 
ptb.scrn.n = max(Screen('screens')); 
[width, height] = Screen('DisplaySize',ptb.scrn.n); % PTB returns dimensions of screen in width/height

width_screen=width; 
height_screen=height;
dva_desired_peripheral= 5; 
dva_desired_central=3;

deg_screen=rad2deg(atan(width_screen/distance_observer_to_screen));

prop_DVA_peripheral=dva_desired_peripheral/deg_screen
prop_DVA_central=dva_desired_central/deg_screen


