function Mask_Matrix = Get_MaskMatrix_FromMaskInfoAndBlackWhiteBackgroundColors(MaskInfo, BlackColor, WhiteColor, Background_Color)
    xo_list =  MaskInfo.xo_list;
    yo_list = MaskInfo.yo_list;
    theta_list = MaskInfo.theta_list;
    BlackOrWhite_list = MaskInfo.BlackOrWhite_list;
    N = MaskInfo.N;
    Line_width =  MaskInfo.Line_width;
    
    %
    xlist = 1:N;
    ylist = 1:N;
    [X,Y] =meshgrid(xlist, ylist);
    Nlines = length(xo_list);
    
    %
    Mask_Matrix = Background_Color *(ones(N, N));
    for i = 1:Nlines
        xo = xo_list(i);
        yo = yo_list(i);
        a = tan(theta_list(i));
        D_matrix = ((Y-yo) -a*(X-xo)).^2/(1+a^2);
        BlackOrWhite = BlackOrWhite_list(i);
        Mask_Matrix(find(D_matrix<Line_width)) = (1-BlackOrWhite)*BlackColor+ BlackOrWhite*WhiteColor ;
    end
    %--- make the pixels outside the ring as gray
    DistanceSquare_ToCenter = (X-(N/2+0.5)).^2 +  (Y-(N/2+0.5)).^2;
    Mask_Matrix(find(DistanceSquare_ToCenter > (N/2)^2)) = Background_Color;