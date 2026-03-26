function plotgrid_rect(Fixation_Pixels_left,Fixation_Pixels_right, disk_radius, inner_ring_radius, outer_ring_radius, rect_half, Fix_Pixels_left, Fix_Pixels_right, h)
theta= linspace(0,2*pi, 100); %angles from 0 to 2pi
x_stereogram_left= Fixation_Pixels_left(1) + disk_radius *cos(theta);
y_stereogram_left= Fixation_Pixels_left(2) + disk_radius*sin(theta);
inner_ring_x_left= Fixation_Pixels_left(1)  + inner_ring_radius*cos(theta);
inner_ring_y_left= Fixation_Pixels_left(2)  + inner_ring_radius*sin(theta);
outer_ring_x_left= Fixation_Pixels_left(1) + outer_ring_radius *cos(theta);
outer_ring_y_left= Fixation_Pixels_left(2)  +  outer_ring_radius *sin(theta);

x_stereogram_right= Fixation_Pixels_right(1) + disk_radius *cos(theta);
y_stereogram_right= Fixation_Pixels_right(2) + disk_radius*sin(theta);
inner_ring_x_right= Fixation_Pixels_right(1)  + inner_ring_radius*cos(theta);
inner_ring_y_right= Fixation_Pixels_right(2)  + inner_ring_radius*sin(theta);
outer_ring_x_right= Fixation_Pixels_right(1) + outer_ring_radius *cos(theta);
outer_ring_y_right= Fixation_Pixels_right(2)  +  outer_ring_radius *sin(theta);


pos1=[0,0,rect_half, h];
pos2=[rect_half,0,rect_half, h];
figure 
plot(Fix_Pixels_left(1), Fix_Pixels_left(2), 'ko', 'MarkerFaceColor', 'k')
hold on 
plot(Fix_Pixels_right(1), Fix_Pixels_right(2), 'ko', 'MarkerFaceColor', 'k')
axis([0 1920 0 1080])
axis equal; 
r_left = rectangle('Position', pos1, 'EdgeColor', 'r', 'FaceColor', 'none');
r_left = rectangle('Position', pos2, 'EdgeColor', 'b', 'FaceColor', 'none');
set(gca, 'YDir', 'reverse')
set(gca, 'XLimMode', 'manual', 'YLimMode', 'manual')
plot(x_stereogram_left,y_stereogram_left,'b-', 'LineWidth', 2)
plot(inner_ring_x_left,inner_ring_y_left,'r-', 'LineWidth', 2)
plot(outer_ring_x_left, outer_ring_y_left,'m-', 'LineWidth', 2)
plot(x_stereogram_right,y_stereogram_right,'b-', 'LineWidth', 2)
plot(inner_ring_x_right,inner_ring_y_right,'r-', 'LineWidth', 2)
plot(outer_ring_x_right, outer_ring_y_right,'m-', 'LineWidth', 2)
axis([0 1920 0 1080])
axis equal; 
set(gca, 'YDir', 'reverse')
set(gca, 'XLimMode', 'manual', 'YLimMode', 'manual')