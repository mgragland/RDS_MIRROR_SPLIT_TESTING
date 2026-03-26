function plotgrid(center_x, center_y, disk_radius, inner_ring_radius, outer_ring_radius, fixation_x, fixation_y, PPD_offset, centralorperipheral, pix_deg)

% Calculation of Circles for Plotting: 
theta= linspace(0,2*pi, 100); %angles from 0 to 2pi

%stereogram center
x_stereogram= center_x + disk_radius *cos(theta);
y_stereogram= center_y  + disk_radius*sin(theta);
inner_ring_x= center_x  + inner_ring_radius*cos(theta);
inner_ring_y= center_y  + inner_ring_radius*sin(theta);
outer_ring_x= center_x + outer_ring_radius *cos(theta);
outer_ring_y= center_y  +  outer_ring_radius *sin(theta);

% 5 DVA Offset--> Peripheral 
if centralorperipheral == 2
   PPD_x1= fixation_x + PPD_offset;
   PPD_y1= fixation_y;
else
     PPD_x1= fixation_x;
     PPD_y1= fixation_y;
end


% PLOT POINTS ON THE GRID 
figure
plot(fixation_x, fixation_y, 'ro', 'MarkerFaceColor', 'r')
hold on 
plot(PPD_x1,PPD_y1, 'ko', 'MarkerFaceColor', 'k' )
hold on
plot(center_x,center_y, 'o')
plot(x_stereogram,y_stereogram,'b-', 'LineWidth', 2)
hold on 
plot(inner_ring_x,inner_ring_y,'r-', 'LineWidth', 2)
hold on 
plot(outer_ring_x, outer_ring_y,'m-', 'LineWidth', 2)
axis([0 1920 0 1080])
axis equal; 
set(gca, 'YDir', 'reverse')
set(gca, 'XLimMode', 'manual', 'YLimMode', 'manual')


distance_x=abs(fixation_x-center_x);
distance_y=abs(fixation_y-center_y);

