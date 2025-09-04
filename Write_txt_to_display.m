
function Write_txt_to_display(Window_ID, txt, x_location_window_width_scale, y_location_window_height_scale, color)

[window_width, window_height] = Screen('WindowSize', Window_ID);


for LeftOrRight =1:2
    Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
    DrawFormattedText(Window_ID,txt, x_location_window_width_scale*window_width, y_location_window_height_scale*window_height, color);
end
Screen('Flip', Window_ID);
