
function  temMatrix=Update_Matrix_By_Dots(Initial_Matrix, Dots_x_tem, Dots_y_tem, Color_Of_Dots, Dot_Size, xsize_stimulus, ColorIndex);

temMatrix = Initial_Matrix; 

for i = 1:length(Dots_x_tem)
    x_start  = Dots_x_tem(i) - floor(Dot_Size/2);
    y_start  = Dots_y_tem(i) - floor(Dot_Size/2);
    x_end = x_start+Dot_Size-1;
    y_end = y_start+Dot_Size-1;
    x_start = max([x_start, 1]);
    x_end =min([x_end, xsize_stimulus]);
    y_start = max([y_start, 1]);
    y_end =min([y_end, xsize_stimulus]);
    if x_start ~= floor(x_start) | x_end~= floor(x_end) | y_start ~= floor(y_start) | y_end ~= floor(y_end)
        R=input('non-integer values , enter to continue');
    end
    temMatrix(y_start:y_end, x_start:x_end) = ColorIndex(Color_Of_Dots(i)+1)*ones(y_end-y_start+1, x_end-x_start+1); 
end
