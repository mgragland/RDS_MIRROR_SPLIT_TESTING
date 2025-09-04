ptb.scrn.n = max(Screen('screens')); 
ptb.scrn.res = Screen('Resolution',ptb.scrn.n);  
ptb.scrn.obs_to_scr_mm  = 550; % 55cm  % Distance observer to screen  --> if 0, no visual degree measurement

[ptb.scrn.size_w_mm, ptb.scrn.size_h_mm] = Screen('DisplaySize',ptb.scrn.n); % PTB returns dimensions of screen in width/height

ptb.scrn.size_deg = atand([ptb.scrn.size_w_mm ptb.scrn.size_h_mm]./(ptb.scrn.obs_to_scr_mm.*2)).*2;  % Screen size in degrees (inverse tangent function)
ptb.scrn.pix_per_deg = mean([ptb.scrn.res.width/ptb.scrn.size_deg(1) ptb.scrn.res.height/ptb.scrn.size_deg(2)]); %28 pixels/degree 
pix_degree=ptb.scrn.pix_per_deg;
save workspace_locationcalc.mat

%% ALL CALCULATIONS IN PIXELS 
fixation_center=[ptb.scrn.res.width*0.5, ptb.scrn.res.height *0.5];
disk_radius= round(0.083 * ptb.scrn.res.width);
inner_ring_radius=  round(0.085 * ptb.scrn.res.width);
outer_ring_radius=  round(0.108 *ptb.scrn.res.width);

diff_ring_disk=inner_ring_radius-disk_radius;
diff_outerminusinnerring_disk=(0.5*(outer_ring_radius-inner_ring_radius))-disk_radius
%% Central vs Peripheral Stimuli 
deg=5;
PPD_Offset= deg * ptb.scrn.pix_per_deg;

peripheral_left= [(fixation_center(1)-(PPD_Offset)-disk_radius-inner_ring_radius), fixation_center(2)]
peripheral_right= [(fixation_center(1)+PPD_Offset+inner_ring_radius+disk_radius), fixation_center(2)]
central=[fixation_center(1), (fixation_center(2)+disk_radius+(0.5*(outer_ring_radius-inner_ring_radius)))];

plotgrid(peripheral_right(1), peripheral_right(2), disk_radius, inner_ring_radius, outer_ring_radius, fixation_center(1), fixation_center(2))



% Calculate DVA: 
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
