function MaskInfo = Get_Mask(condition); 

    N = 2*condition.Ring_OuterRadius;
    Line_width= max([round(condition.Dot_Radius/2), 1]);
    Nlines = round(condition.Dot_Density*(N/Line_width));
%     xlist  = 1:N;
%     ylist = 1:N;
%     [X,Y] =meshgrid(xlist, ylist);
    xo_list = rand(1, Nlines)*N;
    yo_list = rand(1, Nlines)*N;
    theta_list = rand(1, Nlines)*2*pi;
    BlackOrWhite_list =(rand(1, Nlines)>0.5);
    %
    MaskInfo.xo_list = xo_list;
    MaskInfo.yo_list = yo_list;
    MaskInfo.theta_list = theta_list;
    MaskInfo.BlackOrWhite_list = BlackOrWhite_list;
    MaskInfo.N = N;
    MaskInfo.Line_width = Line_width;
    
   
    

    
    
    
    %MaskInfo.Mask_Matrix = Mask_Matrix;